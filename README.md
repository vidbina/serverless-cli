# Serverless CLI Container

This container just provides an environment with the serverless CLI tool
configured to work without you having to think of managing which version of the
CLI, dealing with npm or figuring how to manage multiple versions of a
globally npm-installed package.

It's mostly an experiment to explore to which extend running all CLI tools in
containers makes sense.

Alias `serverless` from you local env to the container. One could either source
the `setup-alias.sh` shell script through the command `source setup-alias.sh`
or explicitly state the alias (perhaps through the shell's profile or rc file).
The following snippet presents an example of the command used to setup a
serverless alias.

`alias serverless='docker run -v $(pwd):/root/serverless --env AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id) --env AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key) -it --rm vidbina/serverless-cli:latest /usr/bin/serverless'`

> You could directly specify the keys for AWS in the alias, but I would
recommend against it, since managing it through the `aws configure` AWS CLI
tools allows you to pickup whichever AWS configuration is appropriate from
a single source, which should make live simpler when a profile or credential
change is in order.

After setup, all `serverless` commands (e.g.: `serverless version`) will be
directed to the serverless installation inside the container :wink:.
