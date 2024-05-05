# Redis as a Vector Database for Amazon Bedrock KnowledgeBase

## Create Redis Database

Create Redis cloud database in the console. You can use Essentials subscription. Free 30MB redis database CAN NOT be used with Amazon Bedrock. Bedrock requires connection to be mutual TLS authenticated, which is not an option for 30MB free DB.

Enable TLS, including mutual TLS. Download and save files under the `./tls` folder.

- Official Redis documentation: https://redis.io/docs/latest/integrate/amazon-bedrock/set-up-redis/
- Official AWS Documentation: https://docs.aws.amazon.com/bedrock/latest/userguide/knowledge-base-setup.html

## Enable client TLS authentication and download certificates

Bedrock requires that the client must be authenticated with TLS using client certificate (mutual authentication).


![enable mutual TLS](media/redis-tls-certs.png)

## Create AWS secret with Redis credentials and certificates

![AWS Secret](media/aws-secret.png)

You can use `create-secret.sh` script to create AWS secret based on your credentials. Make sure to capture the secret ARN - you'll need it to create the knowledgebase.

## Create Redis index

Index should exist in the Database before you connect Amazon Bedrock knowledgebase to Redis.

Make sure the index, field names and the dimension of the vector field are matching these you will select in the KnowledgeBase configuration. The easiest way to create the index is using the Redis Insight.

```
FT.CREATE vectorIndex                   
    ON HASH                
    SCHEMA
        "text" TEXT
        "metadata" TEXT                   
        "vectorField"  VECTOR FLAT     
            6                          
            "TYPE" "FLOAT32"            
            "DIM" 1536                   
            "DISTANCE_METRIC" "COSINE"
```

## Create Amazon Bedrock knowledgebase

![Bedrock configuration with Redis](media/bedrock-config.png)

## Troubleshooting

### Knowledgebase creation fails with SSL - related error

Make sure you are using mutual TLS and all the correct keys and certificates. Try to connect to the database from the command like that looks like this:

```
redis-cli -u redis://default:XXXXXXXX@redis-12584.c102.us-east-1-mz.ec2.redns.redis-cloud.com:12584 --tls --cacert tls/redis_ca.pem --cert tls/redis-db-12278986.crt --key tls/redis-db-12278986.key
```

Make sure the secret contains the correct keys and certificates.

### Knowledgebase creation fails with error "Storage configuration is invalid"

Most likely you are using the wrong index definition.

Connect to Redis instance with the CLI and/or RedisInsigt and start profiling session (`MONITOR` command).

If you see Bedrock executing FT.SEARCH command and then failing - most likely cause is index either does not exist or does not match the fields you used in the knowledgebase definition.

### Retrieving Knowledgebase definition

```
aws bedrock-agent  get-knowledge-base --knowledge-base-id 38AAZFWQ3G --region us-east-1
```