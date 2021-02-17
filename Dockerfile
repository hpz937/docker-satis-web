FROM alpine:latest
RUN apk add bash php7 php7-dom php7-tokenizer php7-xml php7-xmlwriter composer git nginx && \
    composer create-project composer/satis:dev-main /app -q && \
    mkdir /web /run/nginx && \
    printf "#!/bin/sh\n/app/bin/satis build /config/satis.json /web -vvv\nnginx -g\"daemon off;\"" > /init.sh && \
    chmod +x /init.sh
COPY conf/default.conf /etc/nginx/http.d/default.conf
ENTRYPOINT [ "/init.sh" ]
