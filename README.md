Materials for MicroService Workshop

* Booster 2014 in Bergen, Norway
* GOTO Chicago 2014


Docker was used to run RabbitMQ and the various services (Uganda class)

* Boot2Docker used
* dockerfile/rabbitmq image used
** docker pull dockerfile/rabbitmq
** docker run -d -p 5672:5672 -p 15672:15672 --name="rabbitmq" dockerfile/rabbitmq
** for restarting: docker start rabbitmq
** for console dumping: docker logs rabbitmq



# Start Zookeeper and expose port 2181 for use by the host machine
docker run -d --name zookeeper -p 2181:2181 confluent/zookeeper

# Start Kafka and expose port 9092 for use by the host machine
docker run -d --name kafka -p 9092:9092 --link zookeeper:zookeeper confluent/kafka

# Start Schema Registry and expose port 8081 for use by the host machine
docker run -d --name schema-registry -p 8081:8081 --link zookeeper:zookeeper \
    --link kafka:kafka confluent/schema-registry

# Start REST Proxy and expose port 8082 for use by the host machine
docker run -d --name rest-proxy -p 8082:8082 --link zookeeper:zookeeper \
    --link kafka:kafka --link schema-registry:schema-registry confluent/rest-proxy