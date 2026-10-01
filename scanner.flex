%{
#include "token.h"
%}
DIGIT  [0-9]
LETTER [a-zA-Z]
%%
(" "|\t|\n)  /* skip whitespace */
 \+        { return TOKEN_ADD; }
while      { return TOKEN_WHILE; }

{DIGIT}+\.{DIGIT}+[fF] { return TOKEN_FLOAT_LITERAL; }
{DIGIT}+\.{DIGIT}+   { return TOKEN_DOUBLE_LITERAL; }
{DIGIT}+             { return TOKEN_INTEGER_LITERAL; }
{LETTER}{LETTER}*    { return TOKEN_IDENT; }

.          { return TOKEN_ERROR; }
%%
int yywrap() { return 1; }
