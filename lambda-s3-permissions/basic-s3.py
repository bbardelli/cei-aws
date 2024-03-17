import json
import boto3

def lambda_handler(event, context):
    
    print("starting")
    # Create an S3 client
    s3_client = boto3.client(
        's3',
    )
    
    bucket_name = 'cei-curso-test-bruno'
    file_name = 'hello.txt'
    file_content = 'Hello World'
    
    # Write the string to a file in S3
    s3_client.put_object(Bucket=bucket_name, Key=file_name, Body=file_content)

    print(f"'{file_name}' has been written to bucket '{bucket_name}'.")
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!!!!')
    }
