#include "headers.h"

extern char* prevdir[10000];

void cd(int len, char* args[],char* home)
{
    //first get the current working directory
    char* current = (char *) malloc(sizeof(char) * 10000);
    getcwd(current,10000);

    char* path = (char *) malloc(sizeof(char) * 10000);
    strcpy(path,home);

    //if more than two len then too many arguments
    if(len > 2) perror("cd Error: Too many arguments (expected only one argument)\n");
    else if(len == 1) //just cd
    {
        //change into home directory 
        chdir(home);
    }
    else if(strcmp(args[1],"~") == 0)
    {
        //change into home directory 
        chdir(home);
    }
    else if(strcmp(args[1],".") == 0)
    {
        //stay in same directory
    }
    else if(strcmp(args[1],"..") == 0)
    {
        //else do nothing
    }
    else if(strcmp(args[1],"-")== 0)
    {
        if(strcmp(prevdir,home)==0) {printf("%s\n",home); chdir(home);}
        else{
            printf("%s\n",prevdir);
            chdir(prevdir);
        }
    }
    else
    {
        if(args[1][0] == '.')
        {
            if(chdir(args[1])!=0) perror("No such file or directory\n");
        }
        else
        {
            strcat(path,"/");
            strcat(path,args[1]);
            if(chdir(path)!=0) perror("No such file or directory\n");
        }
    }

    strcpy(prevdir,current); //update the previous directory variable to hold the new directory
}