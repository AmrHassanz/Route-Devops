from fastapi import FastAPI, Request
import redis

app = FastAPI()
r = redis.Redis(host='redis', port=6379, db=0)  # Uses Docker service name 'redis'

@app.get("/api/redis")
async def handle_redis(request: Request):
    params = request.query_params
    action = params.get("action")
    key = params.get("key")
    
    if action == "set":
        value = params.get("value")
        r.set(key, value)
        return {"status": "success", "action": "set", "key": key, "value": value}
    
    elif action == "get":
        value = r.get(key)
        return {"status": "success", "action": "get", "key": key, "value": value.decode() if value else None}
    
    return {"error": "Invalid action"}