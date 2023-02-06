import logging
import boto3
#from aws_xray_sdk.core import patch_all

logger = logging.getLogger()
logger.setLevel(logging.INFO)
#patch_all()

#s3 = boto3.client('s3')
#response = s3.get_object(Bucket=bucket, Key=key)
#emailcontent = response['Body'].read().decode('utf-8')

import numpy as np

def main(event, context):
    """Respond to HTTP requests"""

    val = np.abs(200)

    logger.info(val)

    return {
        'statusCode' : 200,
        'body': 'Hello world'
    }