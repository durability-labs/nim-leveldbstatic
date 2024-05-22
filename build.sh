#!/bin/bash
root=$(dirname "$0")

sourceDir="${root}/vendor"
buildDir="${root}/build"
output="${root}/leveldbstatic/raw.nim"

# install nimterop, if not already installed
if ! [ -x "$(command -v toast)" ]; then
  nimble install -y nimterop@0.6.13
fi

git submodule deinit -f "${root}"
git submodule update --init --recursive --checkout "${root}"

cmake -S "${sourceDir}" -B "${buildDir}"

# Remove testing, benchmarking, third-party libraries.
rm -Rf "${sourceDir}/third_party"
rm -Rf "${sourceDir}/benchmarks"
rm "${sourceDir}/util/testutil.cc"

# Prelude:
cat "${root}/leveldbstatic/prelude.nim" > "${output}"
echo >> "${output}"

# assemble files to be compiled:
extensions="c cc cpp"
for ext in ${extensions}; do
  for file in `find "${sourceDir}" -type f -name "*.${ext}" \
          | grep -v "_test" \
          | grep -v "env_windows.cc" \
          | grep -v "env_posix.cc" \
          | grep -v "leveldbutil.cc"`; do
    compile="${compile} --compile=${file}"
  done
done

# generate nim wrapper with nimterop
toast \
  $compile \
  --pnim \
  --preprocess \
  --noHeader \
  --includeDirs="${sourceDir}" \
  --includeDirs="${sourceDir}/helpers" \
  --includeDirs="${sourceDir}/helpers/memenv" \
  --includeDirs="${sourceDir}/port" \
  --includeDirs="${sourceDir}/include" \
  "${sourceDir}/include/leveldb/c.h" >> "${output}"

sed -i 's/\bpassC\b/passc/g' "${output}"
sed -i 's/{\.compile\:\ \"\./{\.compile\:\ root\ \&\ \"/g' "${output}"
sed -i 's/{\.passc\:\ \"-I\./{\.passc\:\ \"-I\"\ \&\ root\ \&\ \"/g' "${output}"
