#!/bin/bash
root=$(dirname "$0")

# install nimterop, if not already installed
if ! [ -x "$(command -v toast)" ]; then
  nimble install -y nimterop@0.6.13
fi

git submodule deinit -f "${root}"
git submodule update --init --recursive --checkout "${root}"

cmake -S "${root}/sources" -B "${root}/build"

# Remove testing, benchmarking, third-party libraries.
rm -Rf "${root}/sources/third_party"
rm -Rf "${root}/sources/benchmarks"
rm "${root}/sources/util/testutil.cc"

# prelude: not needed?

rm "${root}/leveldb.nim"
echo >> "${root}/leveldb.nim"

# assemble files to be compiled:
extensions="c cc cpp"
for ext in ${extensions}; do
  for file in `find "${root}/sources" -type f -name "*.${ext}"`; do
    if [[ $file == *"_test"* ]]; then
      echo "Skip test file: ${file}"
    else
      echo "Include file: ${file}"
      compile="${compile} --compile=${file}"
    fi
  done
done

# generate nim wrapper with nimterop
toast \
  $compile \
  --pnim \
  --preprocess \
  --noHeader \
  --includeDirs="${root}/sources" \
  --includeDirs="${root}/sources/helpers" \
  --includeDirs="${root}/sources/helpers/memenv" \
  --includeDirs="${root}/sources/port" \
  --includeDirs="${root}/sources/include" \
  --includeDirs="${root}/build/include" \
  "${root}/sources/include/leveldb/c.h" >> "${root}/leveldb.nim"
  