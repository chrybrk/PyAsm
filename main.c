#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>

int main()
{
    char buffer[1024];
    int fd = open("main.asm", O_RDONLY);
    ssize_t len = read(fd, buffer, 1024);
    buffer[len + 1] = '\0';

    // printf("%ld\n%s\n", len, buffer);
    printf("%d\n", O_RDONLY);

    return 0;
}
