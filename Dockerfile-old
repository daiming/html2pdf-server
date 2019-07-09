FROM alpine:edge

MAINTAINER daiming
ENV PONG_PATH=""



COPY ./repositories /etc/apk/repositories

RUN apk update && \
    apk add  build-base python3 cairo pango gdk-pixbuf shared-mime-info py3-cffi py3-lxml python3-dev  imagemagick-dev@v35main zlib-dev libjpeg-turbo-dev && \
    echo alias python=python3 >> ~/.bashrc && \
    echo alias pip=pip3 >> ~/.bashrc && \
    source ~/.bashrc && \
    pip3 install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple
    
WORKDIR /tmp
RUN wget https://gitee.com/local/fonts/repository/archive/fonts-v1.0.zip && \
    unzip fonts-v1.0.zip && \
    find ./fonts -name '*.ttf' | xargs -n1 -I {} cp -f {} /usr/share/fonts/ && \
    fc-cache -f -v && \
    rm -rf __MACOSX fonts && \
    rm -f fonts-v1.0.zip 

WORKDIR /
ADD . /app

WORKDIR /app
RUN pip3 install -e . -i https://pypi.tuna.tsinghua.edu.cn/simple

EXPOSE 8080
CMD if [ "$PONG_PATH" = "" ]; then \
        html2pdfd; \
    else \
        html2pdfd --pong-path="$PONG_PATH"; \
    fi
