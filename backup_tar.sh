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
diff_res=$(diff ${array[0]} ${array[1]})
if [ "${diff_res}" != "" ]; then
  ls -1t | tail -n +21 | xargs rm -f
  cd -
  exit 0
fi

rm ${array[0]}
cd -
exit 0

