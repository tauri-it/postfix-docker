FROM ubuntu:18.04

ENV POST_PORT ""
ENV HOSTNAME ""

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && apt-get install -y\
    postfix \
	ssmtp \
    mailutils && \
    apt-get autoremove

COPY ./postfix/main.cf /etc/postfix/main.cf
COPY ./postfix/postfix_start.sh /root/scripts/postfix_start.sh

RUN sed -i -e 's/\r//g' /root/scripts/postfix_start.sh && \
    chmod -R 766 /root/scripts/

EXPOSE ${POST_PORT}
WORKDIR /root/

CMD ["./scripts/postfix_start.sh"]