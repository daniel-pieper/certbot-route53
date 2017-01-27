FROM alpine:3.5
MAINTAINER dlee@nvisia.com

RUN apk add --update --no-cache --virtual=run-deps \
    openssl \
    ca-certificates \
    py-dnspython \
    certbot \
    tzdata \
    py2-pip \
    git

RUN pip install -e git+https://github.com/daniel-pieper/certbot-route53-1.git#egg=certbot-route53

WORKDIR /

VOLUME /etc/letsencrypt

RUN mkdir /root/certbot-route53

COPY certbot-route53/ /root/certbot-route53/

RUN chmod +x /root/certbot-route53/*.sh

ENTRYPOINT ["/root/certbot-route53/main.sh"]
