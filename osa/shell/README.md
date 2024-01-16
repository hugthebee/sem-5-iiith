<h1>C-Shell Replica</h1><br>
All the programs have been compiled on MacOS

```
The program can be compiled using:
make

The executable will be run using:
./shell
```

***************************************

<h3>Features implemented:</h3><br>

display.c:
>- this function is used to display the prompt
>- uses getcwd() to compare the current and home directory

cd.c:
>- replica of the terminal cd command
>- used to go into and out of directories 
>- prints '~' for home directory

echo.c:
>- replica of the terminal echo command
>- used to print the input argument with spaces and tabs delimited

pwd.c:
>- used to output the absolute path of the current working directory

main.c:
>- main shell file that sets up the prompt and takes user input
>- also has code that tokenises the input based on delimiters(space and tab)


- The files have also been made modular and a makefile has been implemented to make their execution easy.
- the 'exit' command is used to quit the shell
