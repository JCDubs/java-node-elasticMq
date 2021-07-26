FROM openjdk:11

ARG ELASTICMQ_VERSION
ENV ELASTICMQ_VERSION ${ELASTICMQ_VERSION:-0.14.6}
ENV NODE_VERSION 14.17.3
ENV NVM_DIR="/root/.nvm"

RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
    && rm -rf /var/lib/apt/lists/*
    
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

RUN mkdir -p /opt/elasticmq/log /opt/elasticmq/lib /opt/elasticmq/config
RUN curl -sfLo /opt/elasticmq/lib/elasticmq.jar https://s3-eu-west-1.amazonaws.com/softwaremill-public/elasticmq-server-${ELASTICMQ_VERSION}.jar
COPY ./bin/etc/init.d/* /etc/init.d
RUN chmod 755 /etc/init.d/mq.start && chmod 755 /etc/init.d/mq.stop

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/v$NODE_VERSION/bin:$PATH

RUN echo PATH="$PATH:/etc/init.d" >> /root/.bashrc \
    && echo "/etc/init.d/mq.start" >> /root/.bashrc \
    && echo ". $NVM_DIR/nvm.sh" >> /root/.bashrc \
    && echo "nvm use $NODE_VERSION" >> /root/.bashrc

EXPOSE 9324
EXPOSE 9325
EXPOSE 3000
EXPOSE 3002
