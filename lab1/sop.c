#include <stdio.h>
#define INPUTBITS 12
#define MAXOUTPUT 12
#define COLUMN 24
#define LINE 961

int Table[LINE][COLUMN];

void PrintTerm(int Row)
{
    char Prefix[2] = {'~', ' '};
    char Input[12] = {'a', 'a', 'a', 'a', 'a', 'a', 'b', 'b', 'b', 'b', 'b', 'b'};
    int Number[12] = {5, 4, 3, 2, 1, 0, 5, 4, 3, 2, 1, 0};

    printf("(");
    for (int Index = 0; Index < INPUTBITS; ++Index)
    {
        int Check = Table[Row][Index];
        printf("(%c%c[%d])", Prefix[Check], Input[Index], Number[Index]);

        if (Index < (INPUTBITS - 1)) printf("&");
    }
    printf(")");
}

int main()
{
    int Count[COLUMN] = {};
    for (int Row = 0; Row < LINE; ++Row)
    {
        for (int Col = 0; Col < COLUMN; ++Col)
        {
            scanf("%d", &(Table[Row][Col]));
            if (Table[Row][Col]) ++Count[Col];
        }
    }

    for (int Col = 12; Col < COLUMN; ++Col)
    {
        printf("assign c[%d] = ", COLUMN - Col - 1);
        for (int Row = 0; Row < LINE; ++Row)
        {
            if (!Table[Row][Col]) continue;

            PrintTerm(Row);
            if (--Count[Col]) printf(" | ");
            else              printf(";");
        }
        printf("\n");
    }

}
