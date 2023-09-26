#! /bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: ${0} <output_dir> <input_dir>"
  exit 0
fi

set -xe

out=${1}
inp=${2}
ts=$(date "+%Y-%m-%d")
dirname=$(basename $inp)

mkdir -p ${out}/${dirname}_backups/
tar -zcf ${out}/${dirname}_backups/${ts}_${dirname}.tar.gz ${inp}

cd ${out}/${dirname}_backups/
ls -1t | tail -n +21 | xargs rm -f
cd -
exit 0

