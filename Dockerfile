FROM oraclelinux:7-slim

ADD oke-admission-webhook /oke-admission-webhook
ENTRYPOINT ["./oke-admission-webhook"]
