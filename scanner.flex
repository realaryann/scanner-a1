%{
#include "token.h"
%}
DIGIT  [0-9]
LETTER [a-zA-Z]
%%
(" "|\t|\n)  /* skip whitespace */

char       { return TOKEN_TYPE_CHAR; }
boolean    { return TOKEN_TYPE_BOOLEAN; }
string     { return TOKEN_TYPE_STRING; }
integer    { return TOKEN_TYPE_INTEGER; }
double     { return TOKEN_TYPE_DOUBLE; }
true       { return TOKEN_TRUE; }
false      { return TOKEN_FALSE; }
array      { return TOKEN_ARRAY; }
carray     { return TOKEN_CARRAY; }
float      { return TOKEN_FLOAT; }
auto       { return TOKEN_AUTO; }
while      { return TOKEN_WHILE; }
for        { return TOKEN_FOR; }
if         { return TOKEN_IF; }
else       { return TOKEN_ELSE; }
function   { return TOKEN_FUNCTION; }
void       { return TOKEN_VOID; }
return     { return TOKEN_RETURN; }
{DIGIT}+   { return TOKEN_INTEGER; }
({DIGIT}\.)({DIGIT}{1,8})   { return TOKEN_DOUBLE; }
({DIGIT}+\.)({DIGIT}{1,15})  { return TOKEN_FLOAT; }
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
\!         { return TOKEN_LOGICAL_NOT; }
\-         { return TOKEN_UNARY_NEGATION; }
\#         { return TOKEN_UNARY_ARRAY_LEN; }
{LETTER}{LETTER}*    { return TOKEN_IDENT; }
.          { return TOKEN_ERROR; }
%%
int yywrap() { return 1; }
