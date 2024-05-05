
# secret name must be unique
SECRET_NAME="redis-anton-tls2"
REGION="us-east-1"
PROFILE="redis-ai"
URL="redis-12584.c102.us-east-1-mz.ec2.redns.redis-cloud.com:12584"
USERNAME="default"
PASSWORD="XXXXXXX"
serverCertificate=$(cat "tls/redis_ca.pem")
clientCertificate=$(cat "tls/redis-db-12278986.crt")
clientPrivateKey=$(cat "tls/redis-db-12278986.key")
serverCertificate=${serverCertificate//$'\n'/' '}
clientCertificate=${clientCertificate//$'\n'/' '}
clientPrivateKey=${clientPrivateKey//$'\n'/' '}
#echo $serverCertificate $clientCertificate $clientPrivateKey
SECRET_STRING="{ \"username\":\"$USERNAME\", \
\"password\":\"$PASSWORD\", \
\"serverCertificate\":\"$serverCertificate\", \
\"clientCertificate\":\"$clientCertificate\", \
\"clientPrivateKey\":\"$clientPrivateKey\" \
}"

#echo $SECRET_STRING

aws secretsmanager create-secret \
    --region $REGION \
    --profile $PROFILE \
    --name $SECRET_NAME \
    --description "Redis credentials for $URL" \
    --secret-string "$SECRET_STRING"


#redis-cli -u redis://default:XXXXXX@redis-12584.c102.us-east-1-mz.ec2.redns.redis-cloud.com:12584 --tls --cacert tls/redis_ca.pem --cert tls/redis-db-12278986.crt --key tls/redis-db-12278986.key
