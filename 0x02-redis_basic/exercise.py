#!/usr/bin/env python3
"""
Module which uses redis
"""
import redis
import uuid
from typing import Union, Any, Callable
import functools


def count_calls(method: Callable) -> Callable:
    """
    Decorator method which returns a callable
    """
    @functools.wraps(method)
    def wrapper_function(self, *args, **kwargs) -> Any:
        """
        Wrapper function which increments a counter
        """
        keyArg = method.__qualname__
        if isinstance(self._redis, redis.Redis):
            if not self._redis.get(keyArg):
                self._redis.set(keyArg, 1)
            else:
                self._redis.incr(keyArg)
        return method(self, *args)
    return wrapper_function

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

    @count_calls
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
