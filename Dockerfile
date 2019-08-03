FROM oraclelinux:7-slim

ADD oke-admission-webhook /oke-admission-webhook
ADD oke-webhook.crt /oke-webhook.crt
ADD oke-webhook.key /oke-webhook.key
ENTRYPOINT ["./oke-admission-webhook"]
