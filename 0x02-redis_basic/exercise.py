#!/usr/bin/env python3
"""
Module which uses redis
"""
import redis
import uuid


class Cache:
    _redis = redis.Redis()

    def __init__(self):
        self._redis.flushdb()

    def store(self, data):
        randomKey = str(uuid.uuid4())
        self._redis.set(randomKey, data)
        return randomKey
