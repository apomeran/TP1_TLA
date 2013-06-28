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

%token OUT;
%token LEFT_PARENTHESIS;
%token RIGHT_PARENTHESIS;
%token LEFT_BRACE;
%token RIGHT_BRACE;
%token EQUALS;
%token TYPE;
%token PLUS;
%token STREAM;
%token INVALID;
%token ENDF;

%token <strval> ITEM;
%token <strval> NAME;


%type <strval> VAR_VALUE;
%type <strval> STREAM_ITEM;
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
		OUT VAR_VALUE
		{
			printf("%s\n", get_var($2));
		}
		|
		STREAM LEFT_BRACE NAME RIGHT_BRACE EQUALS STREAM_ITEM
		{
			set_var($3, $6);
		};

STREAM_ITEM:	STREAM_ITEM PLUS STREAM_ITEM 
		{	
			char * new_stream = malloc(strlen($1) + strlen($3) + 1);
			strcpy(new_stream, $1);
			strcat(new_stream, " ");
			strcat(new_stream, $3);
			printf("holi\n");
			printf("new stream: %s", new_stream);
			$$ = new_stream;
		}
		|
		VAR_VALUE
		{
			printf("var value");
			$$ = $1;
		}
		|
		ITEM
		{
			printf("item");
			$$ = $1;
		};

VAR_VALUE:	LEFT_PARENTHESIS NAME RIGHT_PARENTHESIS 
		{
			$$ = get_var($2);
		}



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
