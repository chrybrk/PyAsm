struct TOKEN
{
    int type;
    char *name;
};

static struct TOKEN tokens[1024];


int main(void)
{

    tokens[0] = (struct TOKEN){10, "test"};
    tokens[1] = (struct TOKEN){10, "tes"};
    tokens[2] = (struct TOKEN){10, "tst"};
    tokens[3] = (struct TOKEN){10, "est"};
    tokens[4] = (struct TOKEN){10, "tet"};
    tokens[5] = (struct TOKEN){10, "testa"};
    tokens[6] = (struct TOKEN){10, "testb"};

    return 0;
}
