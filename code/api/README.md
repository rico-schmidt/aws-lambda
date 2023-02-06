# Install python packages locally to add to lambda function

https://aws.amazon.com/premiumsupport/knowledge-center/lambda-python-package-compatible/

python3 -m pip install --platform manylinux2014_x86_64 --target=/Users/ricoschmidt/Projects/aws-lambda/code/api --implementation cp --python 3.9 --only-binary=:all: --upgrade numpy