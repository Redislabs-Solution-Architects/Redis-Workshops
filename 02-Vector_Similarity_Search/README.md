# Vector Similarity Search with Redis

[Always-on demo](https://antonum-redis-vss-streamlit-streamlit-app-p4z5th.streamlit.app/)

![Redis](https://redis.io/wp-content/uploads/2024/04/Logotype.svg?auto=webp&quality=85,75&width=120)

This notebook generates vector embeddings using pre-trained `sentence-transformers/all-MiniLM-L6-v2` model from HuggingFace, loads them to Redis and runs Vector Similarity search against Redis database. 

First notebook is using RedisVL library (recommended) and second one is using generic redis-py python library.

- https://www.redisvl.com/ RedisVL Library
- https://redis-py.readthedocs.io/en/stable/index.html Redis Python client docs