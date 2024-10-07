# Reranking

![Redis](https://redis.io/wp-content/uploads/2024/04/Logotype.svg?auto=webp&quality=85,75&width=120)

RedisVL can be used to rerank search results (documents or chunks or records) based on the input query. Today RedisVL supports reranking through:

- Hugging Face cross encoder models example: `BAAI/bge-reranker-base`
- The Cohere /rerank API

Original: https://www.redisvl.com/user_guide/rerankers_06.html
