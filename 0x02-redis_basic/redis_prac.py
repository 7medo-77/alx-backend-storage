#!/usr/bin/env python3
import redis, uuid

newRedis = redis.Redis()
newArray = [1,2,3]
newKey = str(uuid.uuid4())
arrayKey = str(uuid.uuid4())

variableTest = newRedis.set(newKey, 23)
typeResponse = newRedis.get(newKey)
newRedis.rpush(arrayKey, str(newArray))

print(newKey)
print(str(newRedis.getrange(arrayKey, 0, -1)))
# print(newRedis.lrange(arrayKey, 0, -1))
