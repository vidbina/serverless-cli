#/bin/sh
# Make things simpler by sourcing this setup-alias shell script ;)
alias serverless='docker run \
  -v $(pwd):/root/serverless \
  --env AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id) \
  --env AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key) \
  -it --rm \
  vidbina/serverless-cli:latest /usr/bin/serverless'
