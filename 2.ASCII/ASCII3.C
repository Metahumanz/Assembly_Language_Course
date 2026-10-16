
#include <stdio.h>

int main(void)
{
    int i, j;
    char ch = 'a';

    for (i = 0; i < 2; i++)
    {
        for (j = 0; j < 13; j++)
        {
            putchar(ch);
            ch++;
        }

        putchar('\n');
    }

    return 0;
}
