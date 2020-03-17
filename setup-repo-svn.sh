#!/usr/bin/env bash
# setup-repo.sh
# Used to configure a repo for formatting, and adds a precommit hook to check formatting.
# Copyright 2015 Square, Inc

set -ex
export CDPATH=""
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function symlink_clang_format() {
  $(rm ".clang-format");
  $(cp -f "$DIR/.clang-format" ".clang-format")
}

function ensure_format_ignore_file_exists() {
  ignore_path=".formatting-directory-ignore"
  $(touch $ignore_path)
}

symlink_clang_format && ensure_format_ignore_file_exists
