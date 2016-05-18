#include <stdio.h>
#define MAXBITCOUNT 6

void
PrintBits(int A)
{
    for (int Index = MAXBITCOUNT - 1; Index >= 0; --Index)
    {
        if (A & (1 << Index)) printf("1 ");
        else                  printf("0 ");
    }
}

void
PrintLine(int A, int B, int Q, int R)
{
    PrintBits(A);
    PrintBits(B);
    PrintBits(Q);
    PrintBits(R);
    printf("\n");
}

int main()
{
    for (int A = 1; A < 32; ++A)
    {
        for (int B = 1; B < 32; ++B)
        {
            int Q = A / B;
            int R = A % B;
            PrintLine(A, B, Q, R);
        }
    }
}
