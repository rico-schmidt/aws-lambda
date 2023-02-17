from pydantic import BaseModel
from typing import Literal
 
 
task_types = Literal["TASK1", "TASK2", "TASK3"]
status_types = Literal["CREATED", "IN_PROGRESS", "COMPLETED", "FAILED"]
 
 
class TaskResponse(BaseModel):
    id: str
    task_type: task_types
    status: status_types
    status_msg: str = ""
    created_time: int = None
    updated_time: int = None
