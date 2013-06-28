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
VOLUME_VALUE      "V"[0-1]
DURATION_VALUE    "T"(0|([1-9][0-9]{0,2}))       
REGULAR_NOTE_VALUE     [A|C|D|F|G]
IRREGULAR_NOTE_VALUE [B|E]
NOTE_VALUE (({REGULAR_NOTE_VALUE}{SHARP}?{OCTAVE})|({IRREGULAR_NOTE_VALUE}{OCTAVE}))
FREQUENCY_VALUE ((0|([1-9][0-9]{0,2})|([1-4][0-9]{3}))((\.([0-9]){1,2})?))
FUNCTION        "FUNCTION"\({NAME}\)
ENDFUNCTION     "ENDFUNCTION"\({NAME}\)
FUNCTION_CALL   "CALL"\({NAME}\)
ITEM    ({NOTE_VALUE}|{FREQUENCY_VALUE}|{VOLUME_VALUE}|{DURATION_VALUE}|{FUNCTION_CALL})
VAR_ASSIGN {VAR_DEFINITION}={ITEM}
TYPE	("NOTE"|"FREQ"|"VOL"|"DUR")
STREAM	("STREAM")

%%

"("		return(LEFT_PARENTHESIS);
")"		return(RIGHT_PARENTHESIS);
"{"		return(LEFT_BRACE);
"}"		return(RIGHT_BRACE);
"+"		return(PLUS);
"="		return(EQUALS);
"OUT"		return(OUT);
^{STREAM}	return(STREAM);
^{TYPE}		return(TYPE);
{ITEM}		yylval.strval = malloc(strlen(yytext)); strcpy(yylval.strval, yytext); return(ITEM);
{NAME}		yylval.strval = malloc(strlen(yytext)); strcpy(yylval.strval, yytext); return(NAME);

%%

void yyerror(char * s) {
	printf("%s", s);
}

