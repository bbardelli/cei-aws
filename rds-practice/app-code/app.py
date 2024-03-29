import os
import pymysql
import json

#get rds host from environment variable
rds_host = os.environ.get('RDS_HOST')
rds_user = os.environ.get('RDS_USER', 'admin')
rds_db = os.environ.get('RDS_DATABASE', 'dummy')
rds_password = os.environ.get('RDS_PASSWORD')

#get all records from the authors table
def get_authors():
    #establish connection to the database
    connection = pymysql.connect(host=rds_host,
                                 user=rds_user,
                                 password=rds_password,
                                 database=rds_db)
    cursor = connection.cursor()
    cursor.execute('SELECT * FROM authors')
    rows = cursor.fetchall()
    cursor.close()
    connection.close()
    return rows

print(get_authors())
