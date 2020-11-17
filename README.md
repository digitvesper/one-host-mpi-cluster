## one-host-mpi-cluster

Travis CI: [![Build Status](https://travis-ci.org/ocramz/docker.openmpi.svg?branch=master)](https://travis-ci.org/ocramz/docker.openmpi)

Used the code from this repository, you can build a Docker container that provides 
the OpenMPI runtime and tools along with various supporting libaries.
The container also runs an OpenSSH server
so that multiple containers can be linked together and used via `mpirun`.


## MPI Container Cluster with `docker-compose`

Simple command-line tool to define and run multi-container applications. 
We provide a sample `docker-compose.yml` file in the repository:

```
version: "3"
services:
  mpi_head:
      build: .
      image: dockeropenmpi_mpi_head:latest
      container_name: head
      ports: 
        - "22"
      links: 
        - mpi_node1
        - mpi_node2
      volumes:
        - ../mpi-hello:/mpi-hello

  mpi_node1:
      build: .
      image: dockeropenmpi_mpi_head:latest
      container_name: node1
      volumes:
        - ../mpi-hello:/mpi-hello

  mpi_node2:
      build: .
      image: dockeropenmpi_mpi_head:latest
      container_name: node2
      volumes:
        - ../mpi-hello:/mpi-hello

```
(Note: the above is docker-compose API version 1)

The file defines an `mpi_head`, `mpi_node1` and an `mpi_node2`.
The only difference is, that the `mpi_head` container exposes its SSH server to 
the host system, so you can log into it to start your MPI applications.


## Usage

The following command, run from the repository's directory, will start and stop containers: 

```
$> sudo docker-compose up
$> sudo docker-compose down
```
Once all containers are running, you can login into the `mpi_head` node and start MPI jobs with `mpirun`. Alternatively, you can execute a one-shot command on that container with the `docker-compose exec` syntax, as follows: 

    sudo docker-compose exec --user mpirun --privileged mpi_head mpirun -n 2 -hostfile /mpi-hello/hostfile  /mpi-hello/mpi-hello
    
Breaking the above command down:

1. Execute command on node `mpi-head`
2. run on 2 MPI ranks
3. Command to run

You can use makefile:
```
$> make build
$> make run
```
