%{
#include <stdio.h>
#include <string.h>
%}

%token VOL;
%token ENDF;
%token F_CALL;
%token FREQ;
%token DUR;
%token FUNC;
%token NOT;
%token STR;
%token VAR;
%token INVALID;


%start PROGRAM
%%
PROGRAM:	MAIN{printf("Program starting\n");}
statement	: VOL
		{
			printf("Holis");
		};

%%

int yywrap() {
	return 1;
}

int main(void) {
	printf("starting program");
	yyparse();
}
