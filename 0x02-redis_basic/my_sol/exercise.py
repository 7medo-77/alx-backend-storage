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
        """
        Store method which stores a new data type
        """
        randomKey: str = str(uuid.uuid4())
        self._redis.set(randomKey, data)
        return randomKey

    def get_str(self, key) -> str:
        """
        Get method which returns string type
        """
        return str(key)

    def get_int(self, key) -> int:
        """
        Get method which returns int type
        """
        return int(key)

    def get(self, key: str, fn: Callable = None) -> Union[str, bytes, int, float]:
        """
        Get method which replicates the
        behavior of the .get redis method
        """
        if (fn):
            return fn(key)
        else:
            return self._redis.get(key)
