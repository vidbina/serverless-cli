SHELL=/bin/sh
DOCKER=docker

OWNER=vidbina
PROJECT=serverless-cli

include VERSION

LIST_FILTER=-f "label=owner=${OWNER}" \
	-f "label=project=${PROJECT}"
LIST_CONTAINER_CMD=${DOCKER} ps ${LIST_FILTER} -a
LIST_IMG_CMD=${DOCKER} images ${LIST_FILTER} -a

LIST_CONTAINER_IDS_CMD=${LIST_CONTAINER_CMD} -q
LIST_IMG_IDS_CMD=${LIST_IMG_CMD} -q

build: Dockerfile
	${DOCKER} build \
		--rm --force-rm \
		-t "${OWNER}/${PROJECT}:latest" \
		-t "${OWNER}/${PROJECT}:${VERSION}" \
		--build-arg version="v${VERSION}" \
		--label="owner=${OWNER}" --label="project=${PROJECT}" \
		.

clean-containers:
	$(eval CONTAINERS=$(shell ${LIST_CONTAINER_IDS_CMD}))
	if [ -n "${CONTAINERS}" ]; then ${DOCKER} rm ${CONTAINERS}; \
	else echo "No containers to cleanup"; \
	fi

clean-images:
	$(eval IMAGES=$(shell ${LIST_IMG_REPTAG_CMD}))
	if [ -n "${IMAGES}" ]; then ${DOCKER} rmi ${IMAGES}; \
	else echo "No images to cleanup"; \
	fi

shell:
	${DOCKER} run \
		-v ${PWD}:/root/serverless \
		-it --rm \
		--env AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id) \
		--env AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key) \
		vidbina/serverless-cli:latest \
		/bin/sh

clean: clean-containers clean-images

.PHONY: build clean-containers clean-images clean shell
