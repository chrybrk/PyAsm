#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

#define STDIN 0
#define STDOUT 1
#define STDERR 2


int main()
{
    int *ptr0 = mmap(NULL, 1024, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
    int *ptr1 = mmap(ptr0, 1024, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);

    printf("PROT_READ = %d\n", PROT_READ);
    printf("PROT_WRITE = %d\n", PROT_WRITE);
    printf("MAP_PRIVATE = %d\n", MAP_PRIVATE);
    printf("MAP_ANONYMOUS = %d\n", MAP_ANONYMOUS);
    printf("MAP_FAILED = %p\n", MAP_FAILED);


    if (ptr0 == MAP_FAILED) printf("cannot create memory block."), exit(139);
    if (ptr1 == MAP_FAILED) printf("cannot create memory block."), exit(139);

    printf("%p\n", ptr0);
    printf("%p\n", ptr1);

    munmap(ptr0, 8);
    munmap(ptr1, 8);

    return 0;
}
