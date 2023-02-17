from fastapi import FastAPI
from mangum import Mangum
from starlette.requests import Request
from src import errors as err
from src import models

app = FastAPI()

@app.get("/")
async def hello_world(request: Request):
    #request.scope["aws.event"]

    return {"aws": request.scope["aws"]}



handler = Mangum(app)

"""
def main(event, context):
    #Respond to HTTP requests

    val = np.abs(200)

    logger.info(val)

    return {
        'statusCode' : 200,
        'body': 'Hello world'
    }
"""

"""
table = boto3.resource("dynamodb").Table(os.environ["TABLE_NAME"])

def get_task(task_id: str) -> dict:
    res = table.get_item(
        Key={
            "id": task_id,
        },
    )
 
    item = res.get("Item")
    if not item:
        raise err.TaskNotFoundError
 
    return item
"""

"""
@app.get("/tasks/{task_id}", response_model=models.TaskResponse)
def get_task(task_id: str):
    try:
        return dynamo.get_task(task_id)
    except dynamo.TaskNotFoundError:
        raise HTTPException(status_code=404, detail="Task not found")
"""

"""
@app.post("/tasks", status_code=201, response_model=models.CreateResponse)
def post_task(payload: models.CreatePayload):
    return dynamo.create_task(payload.task_type, payload.data)
"""
