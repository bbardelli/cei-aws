import boto3

BUCKET_NAME = 'bruno-cei-test'
s3 = boto3.client('s3')

def get_exam_list():
    s3_response = s3.list_objects_v2(Bucket=BUCKET_NAME, Prefix='exams/')

def get_exam(filename):
    s3_response = s3.get_object(Bucket=BUCKET_NAME, Key='exams/' + filename)
    return parse_exam(s3_response['Body'].read().decode('utf-8'))



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
    return json.dumps(question_list)