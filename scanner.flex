%{
#include "token.h"
%}
DIGIT  [0-9]
ESCAPE  (\\[abcefnrtv06\\'"])
HEXESC  (\\0x[A-Fa-f0-9]{1,2})
LETTER [a-zA-Z_]
CHARCLASS [a-zA-Z0-9_]*

%%
(" "|\t)    { /* skip whitespace */ }

    /* comments */
"//".*     { /* skip single-line comment */ }  
"/*"([^*]|\*+[^*/])*\*+"/"    { /* skip block comment */ }

(\n)       { return TOKEN_LITERAL_NEWLINE; }    /* Used to track location of tokens */

char       { return TOKEN_TYPE_CHAR; }
boolean    { return TOKEN_TYPE_BOOLEAN; }
string     { return TOKEN_TYPE_STRING; }
integer    { return TOKEN_TYPE_INTEGER; }
double     { return TOKEN_TYPE_DOUBLE; }
true       { return TOKEN_TRUE; }
false      { return TOKEN_FALSE; }
array      { return TOKEN_ARRAY; }
auto       { return TOKEN_AUTO; }
carray     { return TOKEN_CARRY; }
else       { return TOKEN_ELSE; }
for        { return TOKEN_FOR; }
function   { return TOKEN_FUNCTION; }
if         { return TOKEN_IF; }
print      { return TOKEN_PRINT; }  
return     { return TOKEN_RETURN; }
void       { return TOKEN_VOID; }
while      { return TOKEN_WHILE; }

{DIGIT}+   { return TOKEN_INTEGER_LITERAL; }
{DIGIT}+\.({DIGIT}{1,7})   { return TOKEN_DOUBLE_LITERAL; }
{DIGIT}+\.({DIGIT}{1,15})  { return TOKEN_FLOAT_LITERAL; }

    /* Character and string literals */
\'({ESCAPE}|({LETTER}{0,1}))\'  { return TOKEN_CHAR; }
\"([^\"\\\n]|{ESCAPE}|{HEXESC})*\"  { return TOKEN_TYPE_STRING; }

     /* Escape sequences - not needed for the scanner
\\\a       { return TOKEN_BELL; }
\\\b       { return TOKEN_BACKSPACE; }
\\\e       { return TOKEN_ESCAPE; }
\\\f       { return TOKEN_FORM_FEED; }
\\\n       { return TOKEN_NEWLINE; }
\\\r       { return TOKEN_CARRIAGE_RETURN; }
\\\t       { return TOKEN_TAB; }
\\\v       { return TOKEN_VERTICAL_TAB; }
\\\\       { return TOKEN_BACKSLASH; }
\\\'       { return TOKEN_SINGLE_QUOTE; }
\\\"       { return TOKEN_DOUBLE_QUOTE; }
(\\\0\x)(({DIGIT}|[A-F])({DIGIT}|[A-F]))    { return TOKEN_HEXADECIMAL; }
     */

  /* Expressions */

\+\+       { return TOKEN_POSTFIX_INCR; }
\-\-       { return TOKEN_POSTFIX_DECR; }
\&\&       { return TOKEN_LOGICAL_AND; }
\|\|       { return TOKEN_LOGICAL_OR; }
\<\=       { return TOKEN_LESS_THAN_EQ; }
\>\=       { return TOKEN_GREATER_THAN_EQ; }
\=\=       { return TOKEN_EQUAL; }
\!\=       { return TOKEN_NOT_EQUAL; }
\>         { return TOKEN_GREATER_THAN; }
\<         { return TOKEN_LESS_THAN; }
\=         { return TOKEN_ASSIGN; }
\+         { return TOKEN_ADD; }
\-         { return TOKEN_SUB; }
\*         { return TOKEN_MULT; }
\/         { return TOKEN_DIV; }
\%         { return TOKEN_REMAINDER; }
\^         { return TOKEN_EXPONENTIATION; }
\(         { return TOKEN_L_PAREN; }
\)         { return TOKEN_R_PAREN; }
\[         { return TOKEN_L_BRACKET; }
\]         { return TOKEN_R_BRACKET; }
\{         { return TOKEN_L_CURLY_BRACKET; }
\}         { return TOKEN_R_CURLY_BRACKET; }
\:         { return TOKEN_COLON; }
\;         { return TOKEN_SEMICOLON; }
\,         { return TOKEN_COMMA; }
\!         { return TOKEN_LOGICAL_NOT; }
\#         { return TOKEN_UNARY_ARRAY_LEN; }

  /* Identifier */
({LETTER}|\_)(({LETTER}|{DIGIT}|_){0,254})    { return TOKEN_IDENT; }

   /* Error */
.          { return TOKEN_ERROR; }
%%
int yywrap() { return 1; }
