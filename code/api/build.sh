#!/bin/bash

dist_dir="./python/lib/python3.9/site-packages"
package_file="./requirements.txt"

rm -rf "$dist_dir"
mkdir -p "$dist_dir"

python3 -m pip install \
    --platform manylinux2014_aarch64 \
    --target="$dist_dir" \
    --implementation cp \
    --python 3.9 \
    --only-binary=:all: --upgrade \
    --requirement="$package_file"
