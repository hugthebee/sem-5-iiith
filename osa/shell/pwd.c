#include "headers.h"

void pwd(int len, char* args[],char* home)
{
    char* present = (char*) malloc(sizeof(char) * 10000);
    char* s = getcwd(present, 10000);
    if(s==NULL)
    {
        perror("pwd Error: getcwd() error");
    }
    else
    {
        printf("%s\n",present);
    }
}