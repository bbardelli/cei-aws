import boto3
import json

target_dir = 'output/'
def lambda_handler(event, context):
    # Get the S3 bucket and key from the event
    s3_bucket = event['Records'][0]['s3']['bucket']['name']
    s3_key = event['Records'][0]['s3']['object']['key']
    
    # Create an S3 client
    s3_client = boto3.client('s3')
    
    # Read the JSON file from S3
    response = s3_client.get_object(Bucket=s3_bucket, Key=s3_key)
    file_content = response['Body'].read().decode('utf-8')
    json_content = json.loads(file_content)
    
    count = 0
    for file in json_content["files"]:
        file['filename'] = file['filename'].lower()
        new_s3_key = target_dir + file['filename']
        s3_client.put_object(Body=file["content"], Bucket=s3_bucket, Key=new_s3_key)
        count += 1
    
    return {
        'statusCode': 200,
        'body': f' {count} File(s) created in {s3_bucket}/{target_dir}'
    }