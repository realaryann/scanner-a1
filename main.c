#include "token.h"
#include <stdio.h>

extern FILE *yyin;
extern int yylex();
extern char *yytext;

const char *token_names[] = {
    "TOKEN_EOF",
    "TOKEN_IDENT",

    "TOKEN_C_COMMENT",
    "TOKEN_CPP_COMMENT",

    "TOKEN_TYPE_CHAR",
    "TOKEN_TYPE_DOUBLE",
    "TOKEN_TYPE_BOOLEAN",
    "TOKEN_TYPE_INTEGER",
    "TOKEN_TYPE_STRING",

    "TOKEN_ARRAY",
    "TOKEN_AUTO",
    "TOKEN_CARRY",
    "TOKEN_ELSE",
    "TOKEN_FALSE",
    "TOKEN_FOR",
    "TOKEN_FUNCTION",
    "TOKEN_IF",
    "TOKEN_PRINT",
    "TOKEN_RETURN",
    "TOKEN_TRUE",
    "TOKEN_VOID",
    "TOKEN_WHILE",

    "TOKEN_COLON",
    "TOKEN_SEMICOLON",
    "TOKEN_COMMA",

    "TOKEN_CHAR_LITERAL",
    "TOKEN_INTEGER_LITERAL",
    "TOKEN_FLOAT_LITERAL",
    "TOKEN_DOUBLE_LITERAL",

    "TOKEN_L_PAREN",
    "TOKEN_R_PAREN",
    "TOKEN_L_BRACKET",
    "TOKEN_R_BRACKET",
    "TOKEN_L_CURLY_BRACKET",
    "TOKEN_R_CURLY_BRACKET",
    "TOKEN_FUNCTION_CALL",
    "TOKEN_POSTFIX_INCR",
    "TOKEN_POSTFIX_DECR",
    "TOKEN_UNARY_ARRAY_LEN",
    "TOKEN_LOGICAL_NOT",
    "TOKEN_EXPONENTIATION",
    "TOKEN_MULT",
    "TOKEN_DIV",
    "TOKEN_REMAINDER",
    "TOKEN_ADD",
    "TOKEN_SUB",
    "TOKEN_LESS_THAN",
    "TOKEN_LESS_THAN_EQ",
    "TOKEN_GREATER_THAN",
    "TOKEN_GREATER_THAN_EQ",
    "TOKEN_EQUAL",
    "TOKEN_NOT_EQUAL",
    "TOKEN_LOGICAL_AND",
    "TOKEN_LOGICAL_OR",
    "TOKEN_ASSIGN",
    "TOKEN_CHAR",

    "TOKEN_LITERAL_NEWLINE",

    "TOKEN_ERROR"
};

int main(int argc, char *argv[])
{
	if (argc != 2) {
		printf("No file in command line arg\n");
		return 1;
	}
	yyin = fopen(argv[1],"r");
	if(!yyin) {
		printf("Could not open %s!\n", argv[1]);
		return 1;
	}

	for(int i = 1; i; i++) {
		token_t t = yylex();
		if(t==TOKEN_EOF) break;
		else if(t==TOKEN_LITERAL_NEWLINE) continue;
		else if(t==TOKEN_ERROR){
			printf("UNMATCHED TOKEN at line number: %d | text: %s\n",i,yytext);
			i -= 1; // Decrement for newline
		}
		else {
			printf("line number: %d | token: %s  | text: %s\n",i,token_names[t],yytext);
			i -= 1; // Decrement for newline
		}
	}
}
