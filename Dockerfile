FROM ubuntu:20.04 as OS_SETUP

RUN apt update && apt upgrade -y
RUN apt install wget gnupg2 -y

FROM OS_SETUP as NGINX_PRE_REQ

RUN wget https://nginx.org/keys/nginx_signing.key -P /tmp
RUN apt-key add /tmp/nginx_signing.key
RUN rm /tmp/nginx_signing.key
RUN echo "deb [arch=amd64] http://nginx.org/packages/ubuntu/ focal nginx" > /etc/apt/sources.list.d/nginx.list
RUN echo "deb-src http://nginx.org/packages/ubuntu/ focal nginx" >> /etc/apt/sources.list.d/nginx.list

FROM NGINX_PRE_REQ as NGINX_INSTALLATION

RUN apt update && apt install nginx -y

FROM NGINX_INSTALLATION as POST_INSTALLATION

COPY ./src/entrypoint.sh /entrypoint.sh
RUN chmod +X /entrypoint.sh
CMD ["/bin/bash", "entrypoint.sh"]
