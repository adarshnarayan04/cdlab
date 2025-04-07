%{
#include<stdio.h>   
int yylex(void);
void yyerror(char *);
%}

%token NUM plus mult

%%
E : E plus T {printf("Reduced E+T to E \n");}
   | T {printf("Reduced T to E \n");}
   ;

T : T mult F {printf("Reduced T*F to T \n");}
   | F {printf("Reduced F to T \n");}
   ;
F: NUM {printf(" Reduce NUM to F \n");}
   ;

%%

void yyerror(char * mess){
    fprintf(stderr,"%s\n",mess);
}

int main(){
    yydebug=1;
    yyparse();
    return 0;
}