#include <fcntl.h>
#include <unistd.h>

#define STDIN 0
#define STDOUT 1
#define STDERR 2

#define MAX_CHARACTER 1024
#define MAX_TOKENS 1024

// [x]: read file
// [ ]: generate tokens
// [ ]: parse tokens
// [ ]: intrepret

char *identifiers[] = { "print", "exit" };
char  symbols[] = { '(', ')', ';', '"' };
char  t_type[] = {
    0, // identifier
    1, // keyword
    2, // symbol
    3, // string_lit
    4, // int_lit
};

struct TOKEN
{
    unsigned char type; // 256 token type
    unsigned long int value; // 32bits: starting, 32bits: ending
    unsigned short int line_number;
};

static char buffer[MAX_CHARACTER];
static struct TOKEN tokens[MAX_TOKENS];

char cannot_read_file_err[] = "[ERROR]: Cannot read file from path.";
size_t crfe_len = sizeof(cannot_read_file_err) / sizeof(cannot_read_file_err[0]);

ssize_t read_file(const char *pathname)
{
    int fd = open(pathname, O_RDONLY);
    if (fd < 0) write(STDERR, cannot_read_file_err, crfe_len - 1);
    ssize_t len = read(fd, buffer, MAX_CHARACTER);
    close(fd);

    return len;
}

int main()
{
    ssize_t len = read_file("main.p");
    write(STDOUT, buffer, len);

    return 0;
}
