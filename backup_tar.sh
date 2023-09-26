#! /bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: ${0} <output_dir> <input_dir>"
  exit 0
fi

set -xe

out=${1}
inp=${2}
ts=$(date "+%Y-%m-%d-%H:%M:%S")
dirname=$(basename $inp)

mkdir -p ${out}/${dirname}_backups/
tar -zcf ${out}/${dirname}_backups/${ts}_${dirname}.tar.gz ${inp}

cd ${out}/${dirname}_backups/
array=()
IFS=$'\n' read -r -d '' -a array < <( ls -1t | head -n +2 && printf '\0' )
num_files=${#array[@]}

if [ $num_files -ge 2 ]; then
  hash1=$(md5sum "${array[0]}" | awk '{print $1}')
  hash2=$(md5sum "${array[1]}" | awk '{print $1}')

  if [ "$hash1" == "$hash2" ]; then
    rm "${array[1]}"
    cd -
    exit 0
  fi
fi
ls -1t | tail -n +21 | xargs rm -f
cd -
exit 0

