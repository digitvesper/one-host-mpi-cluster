#include <ifaddrs.h>
#include <unistd.h>
#include <mpi.h>
#include <stdio.h>

int main( int argc, char *argv[] )
{
    int rank, size;
    MPI_Init( &argc, &argv );
    MPI_Comm_rank( MPI_COMM_WORLD, &rank );
    MPI_Comm_size( MPI_COMM_WORLD, &size );
    printf( "I am %d of %d\n", rank, size );

   char hostname[256];
   int val = gethostname( hostname, 256);
   printf("Hostname = %s\n", hostname);
    MPI_Finalize();
    return 0;
}