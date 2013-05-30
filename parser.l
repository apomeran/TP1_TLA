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
FUNCTION        "FUNCTION"\s{NAME}$
ENDFUNCTION     "ENDFUNCTION"\s{NAME}$
FUNCTION_CALL   "CALL"\({NAME}\)$
ITEM    ({VAR_VALUE}|{NOTE_VALUE}|{FREQUENCY_VALUE}|{VOLUME_VALUE}|{DURATION_VALUE}|{FUNCTION_CALL})
NOTE        "NOTE"\s{NAME}\s=\s{NOTE_VALUE}$
FREQUENCY    "FREQUENCY"\s{NAME}\s=\s{FREQUENCY_VALUE}$
VOLUME        "VOLUME"\s{NAME}\s=\s{VOLUME_VALUE}$
DURATION    "DURATION"\s{NAME}\s=\s{DURATION_VALUE}$
STREAM        "STREAM"\s{NAME}\s=\s{ITEM}(\s\+\s{ITEM})*$
VAR_ASSIGN {VAR_DEFINITION}\s=\s{ITEM}$

%%

{VOLUME}               printf("VOLUME %s\n", yytext);
{ENDFUNCTION}               printf("ENDFUNCTION %s\n", yytext);
{FUNCTION_CALL}           printf("FUNCTION_CALL %s\n", yytext);
{FREQUENCY}               printf("FREQUENCY %s\n", yytext);
{DURATION}              printf("DURATION %s\n", yytext);
{FUNCTION}               printf("FUNCTION %s\n", yytext);
{NOTE}                   printf("NOTE %s\n", yytext);
{STREAM}             printf("STREAM %s\n", yytext);
.                         printf(“Token inválido”);

%%

int main(int argc, char *argv[]) {

  yylex();

}
