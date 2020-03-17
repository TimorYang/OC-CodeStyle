#!/usr/bin/env bash
# format-objc-files.sh
# Formats Objective-C files in place.
# Copyright 2015 Square, Inc
#
# Default behavior: formats staged Objective-C files, but doesn't stage these changes.
# Optional arguments:
# -s : staged the changes in git.
# <git SHA> : this SHA is used with `git diff` to generate the list of files to format.

IFS=$'\n'
export CDPATH=""
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR"/lib/common-lib.sh

stage_flag=0
optional_base_sha=$1

objc_files=$(objc_files_to_format_svn "$optional_base_sha")
echo "$objc_files"
[ -z "$objc_files" ] && exit 0

function format_objc() {
  for file in $objc_files; do
	  $("$DIR"/format-objc-file.sh "$file")
	  echo "Formatted $file"
  done
}

format_objc
echo "Formatting complete."

exit 0
