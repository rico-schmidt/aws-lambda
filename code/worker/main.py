import time
import logging
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)


#s3 = boto3.client('s3')
#response = s3.get_object(Bucket=bucket, Key=key)
#emailcontent = response['Body'].read().decode('utf-8')

def lambda_handler(event, context):
    """Lambda entry point"""

    time.sleep(2)

    return {
        'statusCode' : 200,
        'body': 'Hello world'
    }
