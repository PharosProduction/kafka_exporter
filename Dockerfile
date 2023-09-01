FROM quay.io/prometheus/busybox:latest

ARG VERSION
ARG TARGETARCH
ARG BIN_DIR=.build/linux-${TARGETARCH}/

ENV ENV_VERSION=VERSION

COPY ${BIN_DIR}/kafka_exporter /bin/kafka_exporter

EXPOSE     9308
ENTRYPOINT [ "/bin/kafka_exporter" ]
