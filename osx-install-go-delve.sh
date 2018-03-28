#!/bin/bash

brew install go-delve/delve/delve

HOMEBREW_CACHE_DIR="${HOME}/Library/Caches/Homebrew"
TAR_FILE=`ls "${HOMEBREW_CACHE_DIR}" | grep -iE "delve.*\.tar.gz" | awk '{print $1}'`
TMP_FOLDER=`mktemp -d`

tar xvf "${HOMEBREW_CACHE_DIR}/${TAR_FILE}" -C "${TMP_FOLDER}"
sudo bash "${TMP_FOLDER}/${TAR_FILE%.tar.gz}/scripts/gencert.sh"
rm -rf "${TMP_FOLDER}"
