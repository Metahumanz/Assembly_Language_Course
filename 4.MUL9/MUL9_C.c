
#include <stdio.h>

/* 打印一项乘法算式 */
void print_cell(int row, int col)
{
    printf("%d*%d=%d", row, col, row * col);
}

int main(void)
{
    int i, j;

    printf("The 9mul9 table:\n");

    /* 外层循环：从第 9 行到第 1 行 */
    for (i = 9; i >= 1; i--)
    {
        /* 内层循环：从第 1 列到第 i 列 */
        for (j = 1; j <= i; j++)
        {
            print_cell(i, j);

            if (j < i)
            {
                printf("   ");
            }
        }

        printf("\n");
    }

    return 0;
}
