%{
#include "y.tab.h"
#include "stdio.h"
#include "string.h"
%}

NAME    [_a-zA-Z][_a-zA-Z0-9]*
VAR_DEFINITION \[{NAME}\]
VAR_VALUE    \({NAME}\)
OCTAVE        [0-8]
SHARP        \#
VOLUME_VALUE      "V"(0[0-9][0-9]|"100")
DURATION_VALUE    "T"(0|([1-9][0-9]{0,2}))       
REGULAR_NOTE_VALUE     [A|C|D|F|G]
IRREGULAR_NOTE_VALUE [B|E]
NOTE_VALUE (({REGULAR_NOTE_VALUE}{SHARP}?{OCTAVE})|({IRREGULAR_NOTE_VALUE}{OCTAVE}))
FUNCTION        "FUNCTION"
ENDFUNCTION     "ENDFUNCTION"
CALL   "CALL"
ITEM    ({NOTE_VALUE}|{VOLUME_VALUE}|{DURATION_VALUE})
TYPE	("NOTE"|"VOLUME"|"DURATION")
STREAM	("STREAM")

%%

"("		printf("lp ");return(LEFT_PARENTHESIS);
")"		printf("rp ");return(RIGHT_PARENTHESIS);
"{"		return(LEFT_BRACE);
"}"		return(RIGHT_BRACE);
"+"		return(PLUS);
"="		return(EQUALS);
"OUT"		return(OUT);
"\n"		return(EOL);
^{STREAM}	return(STREAM);
^{TYPE}		return(TYPE);
^{FUNCTION}	printf("Function\n");return(FUNCTION);
^{ENDFUNCTION}	printf("EndFucnction\n");return(ENDFUNCTION);
^{CALL}		return(CALL);
{ITEM}		printf("Item: %s\n", yytext);yylval.strval = malloc(strlen(yytext)); strcpy(yylval.strval, yytext); return(ITEM);
{NAME}		yylval.strval = malloc(strlen(yytext)); strcpy(yylval.strval, yytext); return(NAME);


%%

void yyerror(char * s) {
	printf("%s", s);
	exit(1);
}

