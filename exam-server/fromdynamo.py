import os
import boto3
import json

AWS_REGION = os.environ.get('DYNAMO_AWS_REGION', 'eu-south-2')
DYNAMO_TABLE = os.environ.get('DYNAMO_TABLE', 'my_exam_table')
# Create a DynamoDB client
dynamodb = boto3.resource('dynamodb', region_name=AWS_REGION)
table = dynamodb.Table(DYNAMO_TABLE)

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
