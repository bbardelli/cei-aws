import json
import urllib.parse
import boto3

print('Loading function')

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('my_exam_table')

def lambda_handler(event, context):
    #print("Received event: " + json.dumps(event, indent=2))

    # Get the object from the event and show its content type
    bucket = event['Records'][0]['s3']['bucket']['name']
    key = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    try:
        response = s3.get_object(Bucket=bucket, Key=key)
        files_response = s3.list_objects_v2(Bucket=bucket, Prefix='exams/')
        exam_list = [content['Key'].replace('exams/', '') for content in files_response['Contents']]
        exam_list = [x for x in exam_list if x != ""]
        print("CONTENT TYPE: " + response['ContentType'] + " Key:" + key)
        file_name = key.split("/")[-1]
        
        dynamo_response = table.update_item(
            Key={
                'name': 'examlist'
            },
            UpdateExpression='SET files = :val1',
            ExpressionAttributeValues={
                ':val1': exam_list
            }
        )
        s3_file_content = response["Body"].read()
        exam = parse_exam(s3_file_content.decode("utf-8"))
        dynamo_response = table.update_item(
            Key={
                'name': 'exam' + file_name
            },
            UpdateExpression='SET content = :val1',
            ExpressionAttributeValues={
                ':val1': exam
            }
        )
        return response
    except Exception as e:
        print(e)
        print('Error getting object {} from bucket {}. Make sure they exist and your bucket is in the same region as this function.'.format(key, bucket))
        raise e


def parse_exam(content):
    
    lines = content.split('\n')
    line_number = 0
    question_list = []
    for question in range(1,51):
        question_dict = {}
        question = str(question)
        question_dict["question_number"] = question
        while not lines[line_number].startswith(f'{question}.') and line_number < len(lines) - 1:
            line_number += 1
        question_dict['question'] = lines[line_number].replace(f'{question}. ',"")
        #print (lines[line_number])
        line_number += 1
        while not lines[line_number].startswith('    -') and line_number < len(lines) - 1:
            question_dict['question'] += lines[line_number]
            line_number += 1
        #match lines which start with undefined number of blank spaces and a dash using regex
        question_dict['answers'] = {}
        while lines[line_number].startswith('    -') and line_number < len(lines) - 1:
            question_dict['answers'][lines[line_number].replace('    - ',"")[0]] = {}
            question_dict['answers'][lines[line_number].replace('    - ',"")[0]]["text"] = lines[line_number].replace('    - ',"")[2:]
            question_dict['answers'][lines[line_number].replace('    - ',"")[0]]["is_correct"] = False
            #print (lines[line_number])
            line_number += 1
        while not "Correct Answer:" in lines[line_number] and line_number < len(lines) - 1:
            line_number += 1
        correct_answer = question_dict['correct_answer'] = lines[line_number].replace("    Correct Answer: ","").rstrip()
        print(question_dict)
        for x in correct_answer:
            question_dict['answers'][x]["is_correct"] = True
        #print (lines[line_number])
        question_list.append(question_dict)
    return question_list