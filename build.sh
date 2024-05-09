#!/bin/bash
root=$(dirname "$0")

# install nimterop, if not already installed
if ! [ -x "$(command -v toast)" ]; then
  nimble install -y nimterop@0.6.13
fi

cmake -S "${root}/sources" -B "${root}/build"

# prelude: not needed?

echo >> "${root}/leveldb.nim"

# assemble files to be compiled:
extensions="c cc cpp"
for ext in ${extensions}; do
  echo ${ext}
  for file in `find "${root}/sources" -type f -name "*.${ext}"`; do
    echo ${file}
  done
done

# generate nim wrapper with nimterop
#toast \
#  --compile="${root}/sources/randombytes.c" \
#  --compile="${root}/sources/hazmat.c" \
#  --pnim \
#  --noHeader \
#  "${root}/sources/randombytes.h" \
#  "${root}/sources/hazmat.h" > "${root}/sss/cwrapper.nim"
~                                                                                ~                                                                                ~                                        