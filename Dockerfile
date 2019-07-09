FROM python:3.6

MAINTAINER Spoqa
ENV PONG_PATH=""

RUN apt-get update && \
    apt-get install -y libcairo2 libpango1.0-0 libgdk-pixbuf2.0-0 \
                       shared-mime-info python3-cffi python3-lxml \
                       unzip otf-freefont ttf-freefont \
                       fonts-nanum fonts-nanum-extra fonts-nanum-coding \
                       ttf-baekmuk ttf-wqy-zenhei ttf-wqy-microhei && \
    rm -rf /var/lib/apt/lists/*
 
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