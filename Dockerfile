FROM timbru31/java-node

ARG ELASTICMQ_VERSION
ENV ELASTICMQ_VERSION ${ELASTICMQ_VERSION:-0.14.6}

RUN mkdir -p /opt/elasticmq/log /opt/elasticmq/lib /opt/elasticmq/config
RUN curl -sfLo /opt/elasticmq/lib/elasticmq.jar https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-${ELASTICMQ_VERSION}.jar
COPY ./bin/etc/init.d/* /etc/init.d
RUN chmod 755 /etc/init.d/mq.start && chmod 755 /etc/init.d/mq.stop
RUN echo PATH="$PATH:/etc/init.d" >> /root/.bashrc
RUN echo "/etc/init.d/mq.start" >> /root/.bashrc
EXPOSE 9324
EXPOSE 9325
