ARG ALPINE_VERSION=3.13
ARG AWS_CDK_VERSION=2.41.0
FROM alpine:${ALPINE_VERSION}

RUN apk -v --no-cache --update add \
        nodejs \
        npm \
        python3 \
        ca-certificates \
        groff \
        less \
        bash \
        make \
        curl \
        wget \
        zip \
        git \
        py-pip \
        docker

RUN update-ca-certificates
RUN npm install -g aws-cdk@${AWS_CDK_VERSION}

VOLUME [ "/root/.aws" ]
VOLUME [ "/opt/app" ]

# Allow for caching python modules
VOLUME ["/usr/lib/python3.8/site-packages/"]

WORKDIR /opt/app

RUN pip install --upgrade pip

CMD ["npx", "cdk"]
