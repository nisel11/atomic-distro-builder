#!/bin/bash

set -e

echo "::group:: ===$(basename "$0")==="

sudo podman exec iso-builder su - builder -c "
  cd ~ && \
  git clone https://github.com/${GITHUB_REPOSITORY} --branch ${GITHUB_REF##*/} test-builder && \
  cd test-builder/src/source && \
  git clone -b next https://altlinux.space/mkimage-profiles/mkimage-profiles.git mkimage-profiles && \
  cp -rf mkimage/* mkimage-profiles && \
  cd mkimage-profiles
  make V=1 DEBUG=1 REPORT=1 STDOUT=1 \
  IMAGEDIR=\"/workspace/out\" \
  BUILDLOG=\"/workspace/out/build.log\" \
  regular-rescue.iso"

echo "::endgroup::"
