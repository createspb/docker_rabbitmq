FROM phusion/baseimage:0.9.16

MAINTAINER Vladimir Shulyak "vladimir@shulyak.net" (prev: Fernando Mayo <fernando@tutum.co>)

# Install RabbitMQ
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F7B8CEA6056E8E56 && \
    echo "deb http://www.rabbitmq.com/debian/ testing main" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y rabbitmq-server pwgen && \
    rabbitmq-plugins enable rabbitmq_management && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "ERLANGCOOKIE" > /var/lib/rabbitmq/.erlang.cookie
RUN chown rabbitmq:rabbitmq /var/lib/rabbitmq/.erlang.cookie
RUN chmod 400 /var/lib/rabbitmq/.erlang.cookie


ADD set_rabbitmq_password.sh /set_rabbitmq_password.sh
RUN chmod 755 /set_rabbitmq_password.sh

ADD start_rabbitmq.sh /etc/service/rabbitmq/run
RUN chmod 755 /etc/service/rabbitmq/run


EXPOSE 5672 15672
