#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "headers.h"

char* prevdir[10000];

int main(){
    //using variables to store the different parts of the prompt
    char* host = (char *) malloc(sizeof(char)*10000);
    char* systemname = (char *) malloc(sizeof(char)*10000);
    char* directory  = (char *) malloc(sizeof(char)*10000);
    char root[10000] = "<";

    //getting host, system and cwd name
    gethostname(host, 10000);
    systemname =  getlogin(); 
    getcwd(directory, 10000);

    strcpy(prevdir,directory);

    //root holds the basic prompt now
    strcat(root,systemname);
    strcat(root,"@");
    strcat(root,host);
    strcat(root,":");
    strcat(root,"~"); //starts off with home directory

    // printf("\033[0;96m%s> \n",root); // \033[0;96m -> gives the string a different colour

    int run = 1; //will change to zero if we want to stop process
    while(run)
    {
        display(root,directory);

        //getting the command from user
        char* command;
        command = (char *)malloc(sizeof(char) * 10000);
        char* s = (char *)malloc(sizeof(char) * 10000);
        s = fgets(command,10000,stdin);

        if(s==NULL)
        {
            //if null then return 0
            printf("\n");
            return 0;
        }


        int size = strlen(command);
        command[size - 1] = '\0'; //replace new line character with null terminator

        //for echo to work, cause the tokensize function changes the command varibale
        char* comm2 = (char *)malloc(sizeof(char) * 10000);
        strcpy(comm2,command);

        //separating out the command on the basis of tab and space
        char* args[10000];
        int n = 0;
        char* temp = (char *)malloc(sizeof(char) * 10000);
        while(temp = strtok_r(command," \t",&command))
        {
            args[n] = temp;
            n++;
        }

        // printf("%s",args[1]);
        //now args stores all the arguments that are there
        if(strcmp(args[0],"echo")==0)
            //call the function
            echo(n,args,comm2,size);
        else if(strcmp(args[0],"cd")==0)
            cd(n,args,directory);
        else if(strcmp(args[0],"pwd")==0)
            pwd(n,args,directory);
        else if(strcmp(args[0],"exit")==0)
            run = 0;
    }
}