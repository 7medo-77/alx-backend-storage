#!/usr/bin/env python3
"""
Module which uses redis
"""
import redis
import uuid
from typing import Union, Any, Callable


class Cache:
    """
    Object for storing data
    """
    _redis = redis.Redis()

    def __init__(self) -> None:
        """
        Initializing an instance of Cache
        """
        # self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        randomKey: str = str(uuid.uuid4())
        """
        Store method which stores a new data type
        """
        self._redis.set(randomKey, data)
        return randomKey
