SHELL=/bin/sh
DOCKER=docker

include VERSION

LIST_FILTER=-f "label=owner=vidbina" \
	-f "label=project=serverless-cli"
LIST_CONTAINER_CMD=${DOCKER} ps ${LIST_FILTER} -a
LIST_IMG_CMD=${DOCKER} images ${LIST_FILTER} -a

LIST_CONTAINER_IDS_CMD=${LIST_CONTAINER_CMD} -q
LIST_IMG_IDS_CMD=${LIST_IMG_CMD} -q

run: Dockerfile
	${DOCKER} build \
		--rm --force-rm \
		-t "serverless:latest" \
		-t "serverless:${VERSION}" \
		--build-arg version="v${VERSION}" \
		--label="owner=vidbina" --label="project=serverless-cli" \
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

clean: clean-containers clean-images

.PHONY: run clean-containers clean-images clean
