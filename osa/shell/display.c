#include "headers.h"

void display(char* root,char *home){
    char* directory  = (char *) malloc(sizeof(char)*10000);
    getcwd(directory, 10000); //getting the absolute path to the directory we are currently working in
    // printf("%s\n",directory);
    // directory = "/Users/sreeja/Desktop/shell/test"; //REMOVE THIS LINE LATER

    if (strcmp(directory, home) == 0)
        printf("\033[0;96m%s> ",root);

    else if (strstr(directory, home)) //returns first occurence of home in directory
        printf("\033[0;96m%s%s> ",root,directory + strlen(home)); //adds memory adress of home to directory

    else
        printf("\033[0;96m%s%s> ",root,directory);
}