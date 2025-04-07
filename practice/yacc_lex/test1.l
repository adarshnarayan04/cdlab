%option noyywrap
%{
#include "y.tab.h"
void yyerror(char *);
%}

ws [\t\n]+
digit [0-9]

%%
ws       ;
{digit}+ {return NUM;}
[+] {return plus;}
[*] {return mult;}
.   {yyerror("Invalid character\n");}

%%