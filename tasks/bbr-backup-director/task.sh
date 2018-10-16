#!/usr/bin/env bash

set -eux

scripts="$(dirname "$0")/../../scripts"

# shellcheck disable=SC1090
source "$scripts/export-director-metadata"
#source "$(dirname "$0")/../../scripts/export-director-metadata"

source "$scripts/export-cf-metadata"


pushd director-backup-artifact
  ../binary/bbr director --host "${BOSH_ENVIRONMENT}" \
    --username "$BOSH_USERNAME" \
    --private-key-path <(echo "${BOSH_PRIVATE_KEY}") \
    backup

  tar -cvf director-backup.tar -- *
  # shellcheck disable=SC2086
  rm -rf ${BOSH_ENVIRONMENT}_*
popd
