#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

extern void pwd(int len, char* args[],char* home);
extern void display(char* root,char *home);
extern void cd(int len, char* args[],char* home);
extern void echo(int len, char* args[], char* command,int size);
// extern void history(int len, char* args[]);
// extern void addhist(char* command);