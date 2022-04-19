FROM alpine:latest
MAINTAINER GOTUNIX Networks <projects@gotunixcode.net>

RUN apk update
RUN apk add --no-cache \
    build-base \
    make \
    cmake \
    git \
    libevent-dev \
    libffi-dev \
    libxslt-dev \
    bash \
    ca-certificates \
    curl \
    openssl \
    postgresql-client \
    postgresql-libs \
    postgresql-dev \
    py3-pip \
    python3 \
    python3-dev \
    unit \
    unit-python3 \
&& python3 -m venv /opt/venv \
&& /opt/venv/bin/python3 -m pip install --upgrade \
    pip \
    setuptools \
    wheel

WORKDIR /opt/serenity

COPY config/unit.json /etc/unit/unit.json

COPY requirements.txt /opt
RUN /opt/venv/bin/pip install \
    -r /opt/requirements.txt

COPY src /opt/serenity
COPY entrypoint.sh /opt
RUN chmod 0700 /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]


