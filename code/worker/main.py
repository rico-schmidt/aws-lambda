import time
import boto3

def lambda_handler(event, context):
    """Lambda entry point"""

    time.sleep(2)

    return {
        'statusCode' : 200,
        'body': 'Hello world'
    }
