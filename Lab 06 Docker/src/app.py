import os
from fastapi import FastAPI, Depends
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy.ext.declarative import declarative_base  
from pydantic import BaseModel
from enum import Enum
from service import get_total_flights  
from database import RedisWrapper, get_db  
import json

load_dotenv()

# FastAPI app
app = FastAPI()
redis_wrapper = RedisWrapper()

# Database setup
SQLALCHEMY_DATABASE_URL = (
    f"postgresql://{os.getenv('POSTGRES_USER')}:{os.getenv('POSTGRES_PASSWORD')}@{os.getenv('POSTGRES_HOST')}:{os.getenv('POSTGRES_PORT')}/{os.getenv('POSTGRES_DB')}"
)
engine = create_engine(SQLALCHEMY_DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base() 

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@app.get("/postgres")
def hello_postgres(db: Session = Depends(get_db)):
    db.execute(text("SELECT 1"))  # simple query to check connection
    return {"message": "hello from postgree"}

@app.get("/redis")
def hello_redis():
    try:
        redis_wrapper.client.ping()  # test connection
        return {"message": "hello from redis"}
    except Exception as e:
        return {"error": str(e)}

@app.get("/")
def root():
    return {"message": "Welcome to the API. Try /postgres or /redis"}

class FlightTypology(str, Enum):
    departure = "departure"
    arrival = "arrival"

class BaseRequestSchema(BaseModel):
    start_date: str
    end_date: str
    airport_codes: list[str] | None = None
    typology: FlightTypology = FlightTypology.departure

    class Config:
        use_enum_values = True


# Uncomment and implement this post route if needed
@app.post("/data")
async def handle_post(data: BaseRequestSchema, db=Depends(get_db)):
    cache_key = redis_wrapper.create_cache_key(data.dict())
    not_hashed_cache_key = redis_wrapper.convert_payload_to_query_params(
        endpoint="/data", payload=data.dict()
    )

    print("Not hashed cache key: ", not_hashed_cache_key)

    cached_response = redis_wrapper.get_from_cache(cache_key)
    if cached_response:
        return json.loads(cached_response)

    response_data = get_total_flights(
        db=db,
        params=data.dict(),
    )
    redis_wrapper.store_in_cache(cache_key, json.dumps(response_data))

    return response_data
