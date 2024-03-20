import os
import boto3
import json


bucket_name = os.environ.get('BUCKET_NAME', 'exam-test')
aws_region = os.environ.get('BUCKET_AWS_REGION', 'eu-south-2')
s3 = boto3.client('s3', region_name=aws_region)

def get_exam_list():
    print("getting exam list" + bucket_name)
    s3_response = s3.list_objects_v2(Bucket=bucket_name, Prefix='exams/')
    exam_list = [content['Key'].replace('exams/', '') for content in s3_response['Contents']]
    exam_list = [x for x in exam_list if x != ""]
    return json.dumps(exam_list)

def get_exam(filename):
    s3_response = s3.get_object(Bucket=bucket_name, Key='exams/' + filename)
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
        #print(question_dict)
        for x in correct_answer:
            question_dict['answers'][x]["is_correct"] = True
        #print (lines[line_number])
        question_list.append(question_dict)
    return json.dumps(question_list)