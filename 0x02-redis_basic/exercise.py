#!/usr/bin/env python3
"""
Module which uses redis
"""
import redis
import uuid
from typing import Union, Any, Callable
import functools


def call_history(method: Callable) -> Callable:
    """
    Decorator method which returns a callable
    """
    @functools.wraps(method)
    def history_wrapper(self, *args) -> Any:
        """
        Wrapper function which creates two keys, input and output
        and creates a list of paramters as the value for the input
        and a list of outputs as the value for the output
        """
        input_key = '{}:inputs'.format(method.__qualname__)
        output_key = '{}:outputs'.format(method.__qualname__)
        output = method(self, *args)

        if (isinstance(self._redis, redis.Redis)):
            arguments = str(args)
            self._redis.rpush(input_key, arguments)
            self._redis.rpush(output_key, output)
        return output

    return history_wrapper

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

    @call_history
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

def replay(fn: Callable) -> None:
    redis_instance = redis.Redis()
    keyName = fn.__qualname__
    index = 0
    input_keys = redis_instance.keys('*input*')[0]
    output_keys = redis_instance.keys('*output*')[0]
    input_string_array = [key.decode('utf-8') for key in redis_instance.lrange(input_keys, 0, -1)]
    output_string_array = [key.decode('utf-8') for key in redis_instance.lrange(output_keys, 0, -1)]

    key_zip = zip(input_string_array, output_string_array)

    for index, tuple in enumerate(key_zip):
        if index == 0:
            print('{} was called {} times:'.format(fn.__qualname__, len(output_string_array)))
            print('{}(*{}) -> {}'.format(fn.__qualname__, tuple[0], tuple[1]))
        else:
            print('{}(*{}) -> {}'.format(fn.__qualname__, tuple[0], tuple[1]))

