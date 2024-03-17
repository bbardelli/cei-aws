import boto3
import json

# Create a DynamoDB client
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('my_exam_table')

# Print the resulting item
def get_exam_list():
    # Get the item from DynamoDB
    response = table.get_item(
        Key={
            'name': 'examlist'
        }
    )
    return json.dumps(response['Item']['files'])

def get_exam(filename):
    # Get the item from DynamoDB
    response = table.get_item(
        Key={
            'name': 'exam' + filename
        }
    )
    return json.dumps(response['Item']['content'])
