#!/usr/bin/env bash

AWS_ACCOUNT_ID="968331738002"
AWS_REGION="us-east-1"

DOCKER_REPO="kafka-exporter"
DATE="02-09-23"
VERSION="1"

NAME="kafka-exporter"
DESCRIPTION="Kafka exporter"
VCS_URL="https://github.com/Ludo-MVP/kafka-exporter"
VCS_BRANCH="kafka-exporter/master"
VCS_REF="40charsSHA-1hashOfCommit"

docker buildx stop
docker buildx create --use --name serverbuilder --node serverbuilder0 --driver-opt env.BUILDKIT_STEP_LOG_MAX_SIZE=1073741824

################################################################################

docker buildx build \
  --build-arg builder_image=$BUILDER_IMAGE \
  --build-arg jdk_image=$JDK_IMAGE \
  --build-arg runner_image=$RUNNER_IMAGE \
  --build-arg build_date=$DATE \
  --build-arg name=$NAME \
  --build-arg description="$DESCRIPTION" \
  --build-arg version="$VERSION" \
  --build-arg vcs_url=$VCS_URL \
  --build-arg vcs_branch=$VCS_BRANCH \
  --build-arg vcs_ref=$VCS_REF \
  --build-arg TARGETARCH=arm64 \
  --platform linux/arm64 \
  -f Dockerfile \
  --progress plain \
  --push \
  -t dmytronasyrov/$DOCKER_REPO:$DATE-$VERSION \
  .

################################################################################

docker buildx stop
