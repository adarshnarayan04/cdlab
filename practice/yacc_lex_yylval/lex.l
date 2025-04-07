%option noyywrap
%{
void yyerror(char *);
#include "y.tab.h"
%}

ws [ \t\n]+
digit  [0-9]

%%
{ws} ;
{digit}+ {yylval=atoi(yytext);return NUM;}
"+"      {return '+';}
"*"      {return '*';}
.  {yyerror("Invalid \n");}
%%