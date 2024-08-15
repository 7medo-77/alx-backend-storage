#!/usr/bin/env python3
import redis, uuid

newRedis = redis.Redis()
newKey = str(uuid.uuid4())

variableTest = newRedis.set(newKey, 23)

print(newKey)
