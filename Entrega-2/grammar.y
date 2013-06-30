%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>
#include <inttypes.h>
#include <assert.h>
#include <ctype.h>


char vars[1024][2][1024];

void set_var(char*,char*);
char * get_var(char*);

%}

%union{
	char * strval;
}

%token <strval> VOL;
%token <strval> F_CALL;
%token <strval> FREQ;
%token <strval> DUR;
%token <strval> FUNC;
%token <strval> NOT;
%token <strval> STR;
%token <strval> VAR;

%token OUT;
%token LEFT_PARENTHESIS;
%token RIGHT_PARENTHESIS;
%token LEFT_BRACE;
%token RIGHT_BRACE;
%token EQUALS;
%token TYPE;

%token <strval> ITEM;
%token <strval> NAME;

%token INVALID;
%token ENDF;

%type <strval> TOKEN;

%start PROGRAM
%%
PROGRAM:	TOKEN
		{
			int i, j, k;
			for(i = 0; i < 1024; i++) {
				for (j = 0; j < 2; j++) {
					for (k = 0; k < 1024; k++)
						vars[i][j][k] = 0;
				}
			}
		};

TOKEN:		TOKEN TOKEN{}
		|
		TYPE LEFT_BRACE NAME RIGHT_BRACE EQUALS LEFT_PARENTHESIS NAME RIGHT_PARENTHESIS
		{
			set_var($3, get_var($7));
		}
		|
		TYPE LEFT_BRACE NAME RIGHT_BRACE EQUALS ITEM
		{
			set_var($3, $6);
		}
		|	
		OUT LEFT_PARENTHESIS NAME RIGHT_PARENTHESIS
		{
			printf("Var: %s\n", get_var($3));
		}
		|
		LEFT_PARENTHESIS NAME RIGHT_PARENTHESIS
		{
			printf("%s\n", get_var($2));
		};


%%

int yywrap() {
	return 1;
}

int main(void) {
	yyparse();
}

void set_var(char * name, char * value) {
	int i = 0;
	while (vars[i][0][0] != 0 && strcmp(vars[i][0], name) && i < 1024)
		i++;

	if (i < 1024) {
		strcpy(vars[i][0], name);
		strcpy(vars[i][1], value); 		
	}
}

char * get_var(char * name) {
	int i = 0;
	while(vars[i][0][0] != 0 && strcmp(vars[i][0], name) && i < 1024)
		i++;

	if (i < 1024) {
		if (vars[i][0][0] != 0) 
			return vars[i][1];	
	}
}
