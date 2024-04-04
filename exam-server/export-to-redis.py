import fromfile
import redis
import os
import json

redis_host = os.environ.get('REDIS_HOST', 'localhost')
redis_port = os.environ.get('REDIS_PORT', 6379)
redis_db = os.environ.get('REDIS_DB', 0)

def export_to_redis():
    # Connect to the Redis server
    redis_client = redis.Redis(host=redis_host, port=redis_port, db=redis_db)

    # Retrieve the exam data from the file
    exam_data = json.loads(fromfile.get_exam_list())
    print(f"Retrieved exam data from file: {exam_data}")
    # Export the exam data to Redis
    for exam in exam_data:
        print(f"Exporting exam {exam} to Redis")
        redis_client.set(f"exam:{exam}", fromfile.get_exam(exam))

    print("Exported exam data to Redis")


if __name__ == '__main__':
    export_to_redis()