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
mkdir -p ${out}/${dirname}_backups/${ts}_${dirname}
cp -pur ${inp}/* ${out}/${dirname}_backups/${ts}_${dirname}

cd ${out}/${dirname}_backups/
ls -1t | tail -n +21 | xargs rm -rf
cd -
exit 0
