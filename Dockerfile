FROM alpine:3.2

RUN apk add --update openssh-client && \
    rm -rf /var/cache/apk/* && \
    \
    echo "`awk 'BEGIN { FS = ":"; OFS = ":" } $1 == "nobody" { $6 = "/tmp"; print; next } { print }' < /etc/passwd`" > /etc/passwd

ADD tunnel.sh /

EXPOSE 1080
USER nobody
ENTRYPOINT ["/tunnel.sh"]
