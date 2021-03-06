#!/usr/bin/env bash
# format-objc-files-in-repo.sh
# Formats all the Objective-C files in the repo in place.
# Copyright 2015 Square, Inc

set -ex
IFS=$'\n'

start_date=$(date +"%s")

export CDPATH=""
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source "$DIR"/lib/common-lib.sh

objc_files=$(all_valid_objc_files_in_repo_svn)
[ -z "$objc_files" ] && exit 0

# echo "$objc_files" > /tmp/data.txt

function format_objc() {
  for file in $objc_files; do
	  $("$DIR"/format-objc-file.sh "$file")
	  # echo "Formatted $file"
  done
}
format_objc

end_date=$(date +"%s")
time_diff=$(($end_date-$start_date))
echo "$(($time_diff / 60)) minutes and $(($time_diff % 60)) seconds to format objc."

exit 0
