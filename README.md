# Serverless CLI Container

Alias `serverless` to the container
`alias serverless=docker run -v ${HOME}/.aws:/home/.aws -v $(realpath .)/serverless:/home/serverless -it --rm vidbina/serverless-cli:latest /usr/bin/serverless`.


Now any `serverless` command will be directed to the serverless installation
inside the container :wink:.
