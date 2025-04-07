%{
#include <stdio.h>
void yyerror(char *);
int yylex();
%}
%token NUM
%left '+'
%left '*'

%%
E : E '+' E {printf("reduce E+E to E\n");}
   | E '*' E {printf("reduce E*E to E\n");}
   | NUM {printf("Reduced %d to E\n",$1);}
   ;
%%
void yyerror(char * mess)
{
    printf("%s\n",mess); //this also work
    //acutal fprintf(stderr, "%s\n", mess);
}

int main(){
    yyparse();
    return 0;
}