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
ITEM    ({VAR_VALUE}|{NOTE_VALUE}|{FREQUENCY_VALUE}|{VOLUME_VALUE}|{DURATION_VALUE}|{FUNCTION_CALL})
NOTE        "NOTE"\{{NAME}\}=({NOTE_VALUE}|{VAR_VALUE})
FREQUENCY    "FREQUENCY"\{{NAME}\}=({FREQUENCY_VALUE}|{VAR_VALUE})
VOLUME        "VOLUME"\{{NAME}\}=({VOLUME_VALUE}|{VAR_VALUE})
DURATION    "DURATION"\{{NAME}\}=({DURATION_VALUE}|{VAR_VALUE})
STREAM        "STREAM"\{{NAME}\}={ITEM}(\+{ITEM})*
VAR_ASSIGN {VAR_DEFINITION}={ITEM}

%%

^{VOLUME}$              return VOL;
^{ENDFUNCTION}$         return ENDF;
^{FUNCTION_CALL}$       return F_CALL;
^{FREQUENCY}$           return FREQ;
^{DURATION}$            return DUR;
^{FUNCTION}$            return FUNC;
^{NOTE}$                return NOT;
^{STREAM}$          	printf("%s", yytext); return STR;
^{VAR_ASSIGN}$       	return VAR;
^(.+)$                  return INVALID;

%%

