/* FIB100_C.c - x86-64 GCC/MinGW; run with n = 1..100.
 * Use recursion + memoization; unsigned __int128 avoids overflow at F(100).
 * Compile without optimization for easier disassembly comparison.
 */
#include <stdio.h>

#if !defined(__SIZEOF_INT128__)
#error "This program needs a GCC/Clang target supporting unsigned __int128."
#endif

typedef unsigned __int128 u128;

static u128 memo[101] = {0, 1};
static unsigned char ready[101] = {1, 1};

/* noinline keeps a separate recursive function visible in disassembly. */
__attribute__((noinline))
static u128 fib(unsigned int n)
{
    if (!ready[n]) {
        u128 a = fib(n - 1);
        u128 b = fib(n - 2);
        memo[n] = a + b;
        ready[n] = 1;
    }
    return memo[n];
}

/* Print a 128-bit integer without relying on 64-bit printf formats. */
static void print_u128(u128 value)
{
    char buffer[40];
    char *p = buffer + sizeof(buffer) - 1;
    *p = '\0';
    do {
        unsigned int digit = (unsigned int)(value % 10);
        *--p = (char)('0' + digit);
        value /= 10;
    } while (value != 0);
    puts(p);
}

int main(void)
{
    unsigned int n;
    printf("Input n (1..100): ");
    if (scanf("%u", &n) != 1 || n < 1 || n > 100) {
        puts("Invalid input. Please enter 1..100.");
        return 1;
    }
    printf("F(n) = ");
    print_u128(fib(n));
    return 0;
}
