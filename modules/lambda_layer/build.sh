#!/bin/bash

output_path="$ROOT_PATH/.python"
#"./python/lib/python3.9/site-packages"
package_file="./requirements.txt"
python_version=$PYTHON_VERSION
platform=$PLATFORM

rm -rf "$output_path"
mkdir -p "$output_path"

python3 -m pip install \
    --platform $platform \
    --target="$output_path" \
    --implementation cp \
    --python $python_version \
    --only-binary=:all: --upgrade \
    --requirement="$package_file"