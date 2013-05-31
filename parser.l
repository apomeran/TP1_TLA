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
ITEM    ({VAR_VALUE}|{NOTE_VALUE}|{FREQUENCY_VALUE}|{VOLUME_VALUE}|{DURATION_VALUE}|{FUNCTION_CALL})
NOTE        "NOTE"\{{NAME}\}={NOTE_VALUE}
FREQUENCY    "FREQUENCY"\{{NAME}\}={FREQUENCY_VALUE}
VOLUME        "VOLUME"\{{NAME}\}={VOLUME_VALUE}
DURATION    "DURATION"\{{NAME}\}={DURATION_VALUE}
STREAM        "STREAM"\{{NAME}\}={ITEM}(\+{ITEM})*
VAR_ASSIGN {VAR_DEFINITION}={ITEM}

%%

^{VOLUME}$              printf("<TOKEN %s>\n", yytext);
^{ENDFUNCTION}$               printf("<TOKEN %s>\n", yytext);
^{FUNCTION_CALL}$           printf("<TOKEN %s>\n", yytext);
^{FREQUENCY}$           printf("<TOKEN %s>\n", yytext);
^{DURATION}$              printf("<TOKEN %s>\n", yytext);
^{FUNCTION}$               printf("<TOKEN %s>\n", yytext);
^{NOTE}$                   printf("<TOKEN %s>\n", yytext);
^{STREAM}$             printf("<TOKEN %s>\n", yytext);
^{VAR_ASSIGN}$		printf("<TOKEN %s>", yytext);
.$                         printf("Token Invalido\n");

%%

int main(int argc, char *argv[]) {

  yylex();

}
