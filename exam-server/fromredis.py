import redis
import os
import json

redis_host = os.environ.get('REDIS_HOST', 'localhost')
redis_port = os.environ.get('REDIS_PORT', 6379)
redis_db = os.environ.get('REDIS_DB', 0)

# Create a Redis client
redis_client = redis.Redis(host=redis_host, port=redis_port, db=redis_db)

def get_exam(exam_id):
    # Retrieve the exam data from Redis
    exam_data = redis_client.get(f"exam:{exam_id}")

    # Return the exam data
    return exam_data.decode()

def get_exam_list():
    # Retrieve all exam IDs from Redis
    exam_ids = redis_client.keys("exam:*")
    exam_list = [x.decode().replace("exam:", "") for x in exam_ids]
    
    # Return the list of exams in JSON format
    return json.dumps(exam_list)
