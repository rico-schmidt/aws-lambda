#!/bin/bash

target_path="$TARGET_PATH/python"
package_file=$PACKAGE_FILE
python_version=$PYTHON_VERSION
platform=$PLATFORM

rm -rf $output_path
mkdir -p $output_path
chmod 775 $output_path

python3 -m pip install \
    --platform $platform \
    --target="$target_path" \
    --implementation cp \
    --python $python_version \
    --only-binary=:all: --upgrade \
    --requirement="$package_file"