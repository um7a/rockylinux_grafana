IMAGE_NAME := local/rockylinux_grafana
TAG := 0.0.1
CONTAINER_NAME := $(shell echo test_run_${IMAGE_NAME}_${TAG} | sed -e s/\\//_/g)

ContainerExists = "$(shell docker ps | grep ${CONTAINER_NAME})"

.PHONY: help
help:
	@echo ""
	@echo "  TARGETS"
	@echo "    build  ... Build docker image ${IMAGE_NAME}"
	@echo "    clean  ... Clean docker image ${IMAGE_NAME}"
	@echo "    run    ... Run docker container using image ${IMAGE_NAME}"
	@echo "    attach ... Attach on docker container using image ${IMAGE_NAME}"
	@echo "    stop   ... Stop docker container which was created by run target"
	@echo ""

.PHONY: build
build: Dockerfile
	docker build --rm -t ${IMAGE_NAME}:${TAG} .

.PHONY: clean
clean: stop
	docker rmi ${IMAGE_NAME}:${TAG}

.PHONY: run
run: stop
	@echo "Start test container."
	docker run \
	-itd \
	--rm \
	--name ${CONTAINER_NAME} \
	-p 3000:3000 \
	${IMAGE_NAME}:${TAG}
	@echo "Now you can access grafana web ui from localhost:3000."
	@echo "The initial username and password is \"admin\"."

.PHONY: attach
attach:
	# Execute bash
	docker exec \
	-it \
	${CONTAINER_NAME} \
	/bin/bash

.PHONY: stop
stop:
ifneq (${ContainerExists}, "")
	@echo "!!! Container exists. Delete. !!!"
	docker stop \
	${CONTAINER_NAME}
else
	@echo "Container does not exist."
endif
