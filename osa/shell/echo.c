#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void echo(int len, char* args[], char* command,int size)
{
    //check if its direct quotes
    if(args[1][0] == '\"')
    {
        for(int i=6;i<size-2;i++)
        {
            printf("%c",command[i]);
        }
    }
    else
    {
        for(int i=1;i<len;i++)
        {
            printf("%s ",args[i]);
        }
    }
    printf("\n");
}
