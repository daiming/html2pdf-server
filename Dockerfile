FROM python:3.5

MAINTAINER Spoqa
ENV PONG_PATH=""

RUN apt-get update && \
    apt-get install -y libcairo2 libpango1.0-0 libgdk-pixbuf2.0-0 \
                       shared-mime-info python3-cffi python3-lxml \
                       unzip otf-freefont ttf-freefont \
                       fonts-nanum fonts-nanum-extra fonts-nanum-coding \
                       ttf-baekmuk ttf-kochi-gothic ttf-kochi-mincho \
                       ttf-wqy-zenhei ttf-wqy-microhei && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://gitee.com/local/fonts/repository/archive/fonts-v1.0.zip && \
    unzip fonts-v1.0.zip && \
    find fonts-v1.0 -name '*.ttf' -print0 | xargs -0 mv -t /usr/share/fonts/ && \
    fc-cache -f -v && \
    rm -rf __MACOSX fonts-v1.0
WORKDIR /

ADD . /app
WORKDIR /app
RUN pip3 install -e .

EXPOSE 8080
CMD if [ "$PONG_PATH" = "" ]; then \
        html2pdfd; \
    else \
        html2pdfd --pong-path="$PONG_PATH"; \
    fi
