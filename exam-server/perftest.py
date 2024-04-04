import os
import json
import fromfile as ffile
import fromsss as fss
import fromdynamo as fdynamo
import fromredis as fredis

#get performance time of a function
def get_time(func):
    import time
    start = time.time()
    func()
    end = time.time()
    return end - start

def get_time_with_param(func,param):
    import time
    start = time.time()
    func(param)
    end = time.time()
    return end - start

print("Time to get exam list from file: ", get_time(ffile.get_exam_list))
#print("Time to get exam list from S3: ", get_time(fss.get_exam_list))
#print("Time to get exam list from dynamo: ", get_time(fdynamo.get_exam_list))
print("Time to get exam list from redis: ", get_time(fredis.get_exam_list))

print("Time to get exam from file: ", get_time_with_param(ffile.get_exam,"exam20.md"))
#print("Time to get exam from s3: ", get_time_with_param(fss.get_exam,"exam20.md"))
#print("Time to get exam from dynamo: ", get_time_with_param(fdynamo.get_exam,"exam20.md"))
print("Time to get exam from redis: ", get_time_with_param(fredis.get_exam,"exam20.md"))
