cmake_minimum_required(VERSION 3.0.0)

find_package(MPI REQUIRED)

include_directories(${MPI_INCLUDE_PATH})

add_executable(mpi-hello main.cpp)
target_link_libraries(mpi-hello ${MPI_LIBRARIES})

