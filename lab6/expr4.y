%{
#include <stdio.h>
int yylex();
void yyerror(char *);
%}

%token NUM 

%%
E: E '+' E {printf(" Reduce E + E to E \n");} 
   | E '*' E  {printf(" Reduce E * E to E \n");}
   | NUM      {printf(" Reduce %d to E \n",$1);}
   ;
%%
#include "lex.yy.c"
void yyerror (char* mess)
{ fprintf(stderr, "%s\n", mess); }

int main()
{ yydebug = 1; 
  yyparse(); 
  return 0;
}

