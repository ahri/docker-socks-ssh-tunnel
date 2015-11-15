FROM alpine:3.2

RUN apk add --update openssh-client=6.8_p1-r4 && \
    rm -rf /var/cache/apk/* && \
    \
    echo "`awk 'BEGIN { FS = ":"; OFS = ":" } $1 == "nobody" { $6 = "/tmp"; print; next } { print }' < /etc/passwd`" > /etc/passwd

ADD tunnel.sh /

EXPOSE 1080
USER nobody
ENTRYPOINT ["/tunnel.sh"]
