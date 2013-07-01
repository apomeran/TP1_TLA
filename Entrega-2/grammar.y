%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <inttypes.h>
#include <assert.h>
#include <ctype.h>


char vars[1024][2][1024];
char funcs[1024][2][1024];

FILE * output_file = NULL;
char * output_file_name = "my_song";

int in_function = 0;
char current_function[1024];
char function_out[1024];

void set_var(char*,char*);
char * get_var(char*);
void set_func(char*,char*);
char * get_func(char*);

void error(char*);
%}

%union{
	char * strval;
}

%token OUT;
%token LEFT_PARENTHESIS;
%token RIGHT_PARENTHESIS;
%token LEFT_BRACE;
%token RIGHT_BRACE;
%token EQUALS;
%token TYPE;
%token PLUS;
%token STREAM;
%token EOL;
%token ENDFUNCTION;
%token CALL;

%token <strval> ITEM;
%token <strval> NAME;
%token <strval> FUNCTION;

%type <strval> ASSIGN_NAME;
%type <strval> VAR_NAME;
%type <strval> VAR_VALUE;
%type <strval> STREAM_ITEM;
%type <strval> TOKEN;
%type <strval> FUNC_VALUE;

%start PROGRAM
%%
PROGRAM:	TOKEN
		{
			int i, j, k;
			for(i = 0; i < 1024; i++) {
				for (j = 0; j < 2; j++) {
					for (k = 0; k < 1024; k++) {
						vars[i][j][k] = 0;
						funcs[i][j][k] = 0;
					}
				}
			}
		};

TOKEN:		TOKEN TOKEN{}
		|
		TYPE ASSIGN_NAME EQUALS VAR_VALUE EOL
		{
			printf("Guardo variable\n");
			set_var($2, $4);
		}
		|
		TYPE ASSIGN_NAME EQUALS ITEM EOL
		{
			printf("Guardo item\n");
			set_var($2, $4);
		}
		|	
		OUT VAR_VALUE EOL
		{
			if (!in_function) {
				fprintf(output_file, "%s ", $2);
			} else {
				if (function_out[0] != 0)	
					strcat(function_out, " ");
				strcat(function_out, $2);	
			}	
		}
		|
		STREAM ASSIGN_NAME EQUALS STREAM_ITEM EOL
		{
			printf("Termino el stream %s con el valor %s\n", $2, $4);
			set_var($2, $4);
		}
		|
		FUNCTION VAR_NAME EOL
		{
			printf("Entrando a funcion\n");
			if(in_function)
				error("Nested functions!\n");
			in_function++;
			strcpy(current_function, $2);
		} 
		|
		ENDFUNCTION VAR_NAME EOL
		{
			if (current_function == NULL || strcmp(current_function, $2))
				error("End function no concuerda con el nombre de la funcion\n");
			in_function--;
			set_func(current_function, function_out);
			int i;
			for (i = 0; i < 1024 && function_out[i] != 0; i++)
				function_out[i] = 0;
		}
		|
		CALL FUNC_VALUE EOL
		{
			fprintf(output_file,"%s ", $2);	
		}
		|
		EOL{};

STREAM_ITEM:	STREAM_ITEM PLUS STREAM_ITEM 
		{	
			char * new_stream = malloc(strlen($1) + strlen($3) + 1);
			strcpy(new_stream, $1);
			strcat(new_stream, " ");
			strcat(new_stream, $3);
			$$ = new_stream;
		}
		|
		VAR_VALUE
		{
			$$ = $1;
		}
		|
		ITEM
		{
			$$ = $1;
		};

VAR_VALUE:	LEFT_PARENTHESIS NAME RIGHT_PARENTHESIS 
		{
			$$ = get_var($2);
		};

VAR_NAME:	LEFT_PARENTHESIS NAME RIGHT_PARENTHESIS
		{
			$$ = $2;
		};

ASSIGN_NAME:	LEFT_BRACE NAME RIGHT_BRACE 
		{
			$$ = $2;
		};

FUNC_VALUE:	LEFT_PARENTHESIS NAME RIGHT_PARENTHESIS
		{
			$$ = get_func($2);
		};	


%%

int yywrap() {
	return 1;
}

int main(void) {
        output_file = fopen(output_file_name, "w");
        if ( output_file == NULL ) {
                printf("Couldn't open output file\n");
                return 1;
        }
        yyparse();
        fclose(output_file);
}

void set_var(char * name, char * value) {
	printf("Guardando %s=%s\n", name, value);
	int i = 0;
	while (vars[i][0][0] != 0 && strcmp(vars[i][0], name) && i < 1024)
		i++;

	if (i < 1024) {
		strcpy(vars[i][0], name);
		strcpy(vars[i][1], value);
 		return;
	}
	
	error("No se pudo guardar la variable\n");
}

char * get_var(char * name) {
	printf("Obteniendo %s\n", name);
	int i = 0;
	while(vars[i][0][0] != 0 && strcmp(vars[i][0], name) && i < 1024)
		i++;

	if (i < 1024) {
		if (vars[i][0][0] != 0) 
			return vars[i][1];	
	}

	error("No se encontro la variable\n");
}


void set_func(char * name, char * value) {
	printf("Guardando funcion %s=%s\n", name, value);
	int i = 0;
	while (funcs[i][0][0] != 0 && strcmp(funcs[i][0], name) && i < 1024)
		i++;

	if (i < 1024) {
		strcpy(funcs[i][0], name);
		strcpy(funcs[i][1], value);
 		return;
	}
	
	error("No se pudo guardar la funcion\n");
}

char * get_func(char * name) {
	printf("Obteniendo funcion %s\n", name);
	int i = 0;
	while(funcs[i][0][0] != 0 && strcmp(funcs[i][0], name) && i < 1024)
		i++;

	if (i < 1024) {
		if (funcs[i][0][0] != 0) 
			return funcs[i][1];	
	}

	error("No se encontro la funcion %s");
}

void error(char* err) {
	remove(output_file_name);
	yyerror(err);
}
