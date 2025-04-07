%{
#include <stdio.h> 
int yylex(void); //yylex is lex function used to tokenisze the input( can see in only lex , we call while(yylex()))
void yyerror(char *);
%}

%token NUM plus mult
%left plus mult

%%

E: E plus T {printf(" Reduced E + T to E \n");} 
   | T  {printf(" Reduce T to E \n");}
   ;
T: T mult F {printf(" Reduce T * F to T \n");}
   |F {printf(" Reduce F to T \n");}
;
F: NUM {printf(" Reduce NUM to F \n");}
   ;
%%

void yyerror (char* mess)
{ fprintf(stderr, "%s\n", mess); }

int main()
{ 
  yyparse(); 
  return 0;
}
