FROM golang:1.9.2

MAINTAINER Akhmad Ghozali Amrulloh <ghostzali09@gmail.com>

RUN apt-get update -yqq && \
    curl -sL https://deb.nodesource.com/setup_8.x | bash && \
    apt-get install -y build-essential nodejs sqlite3 libsqlite3-dev vim wget git && \
    apt-get install -y xorg xvfb libxrender1 libfontconfig1 libssl-dev && \
    npm install -g --no-progress yarn && \
    yarn config set yarn-offline-mirror /npm-packages-offline-cache && \
    yarn config set yarn-offline-mirror-pruning true && \
    go get -u github.com/golang/dep/cmd/dep && \
    go get -u -v github.com/gobuffalo/buffalo/... && \
    mkdir -p /home/bin

WORKDIR /home/bin

ADD . .

RUN tar xf wkhtmltox.tar.xz && \
    chmod +x /home/bin/wkhtmltox/bin/wkhtmltopdf && \
    chmod +x /home/bin/wkhtmltox/bin/wkhtmltoimage && \
    ln -s /home/bin/wkhtmltox/bin/wkhtmltopdf /usr/bin/wkhtmltopdf && \
    ln -s /home/bin/wkhtmltox/bin/wkhtmltoimage /usr/bin/wkhtmltoimage

WORKDIR $GOPATH/src

EXPOSE 3000





