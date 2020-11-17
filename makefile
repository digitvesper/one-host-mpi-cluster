AUTH=helen
NAME=docker-openmpi
TAG=${AUTH}/${NAME}

export NNODES=4

.DEFAULT_GOAL := help

help:
	@echo "Use sudo \`make <target>\` where <target> is one of"
	@echo "  help     display this help message"
	@echo "  build   build from Dockerfile"
	@echo "  run    build and docker-compose the whole thing"

build:
	docker build -t dockeropenmpi_mpi_head:latest .

run:
	docker-compose up -d
	docker-compose exec --user mpirun --privileged mpi_head mpirun -n ${NNODES} -hostfile /mpi-hello/hostfile  /mpi-hello/mpi-hello
	docker-compose down
