# java-node-elasticmq

A Docker image providing java, node.js and a running instance of ElasticMq. When started, the container will run an instance of rabbitmq in the background with a CMD of bash. The image is intended to be used as a base image to run any applications that requires Java, Node.js and Elastic MQ. The container will export the 9324, 9325 ports to be mapped to ports on the host. 

* JDK Version: 11
* Node Version: 14.17.3
* Elastic MQ Version: 0.14.6

## Starting the MQ service

The Elastic MQ service will be running in the container when the container is spun up but it can also be started by running the following command.

```bash
mq.start
```

Starting the ElasticMQ service in the above way will output logs to the `/var/logs/elasticmq/out.log` file.

## Stopping the MQ service.

The Elastic MQ service can be stopped with the following command.

```bash
mq.stop
```
