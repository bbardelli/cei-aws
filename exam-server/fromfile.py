import json
import os

def get_exam_list():
    return json.dumps(os.listdir('exams'))

def read_file(file_name):
    # Open and read the file
    with open('exams/' + file_name, 'r') as file:
        content = file.read()
    return content

def get_exam(filename):
    return parse_exam(read_file(filename))

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