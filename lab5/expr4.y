%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
%}

%token NUM

%%

E: E PLUS T {printf(" Reduced E + T to E \n");} 
   | E SUB T  {printf(" Reduce E - T TO E \n");}
   | T {printf(" Reduced T to E \n");}
   ;
T: T MULT F {printf(" Reduce T * F to T \n");}
   | T DIV F {printf(" Reduce T / F to T \n");}
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
