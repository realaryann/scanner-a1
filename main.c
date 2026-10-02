#include "token.h"
#include <stdio.h>

extern FILE *yyin;
extern int yylex();
extern char *yytext;

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
			printf("line number: %d | token: %d  | text: %s\n",i,t,yytext);
			i -= 1; // Decrement for newline
		}
	}
}
