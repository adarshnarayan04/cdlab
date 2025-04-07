/* lex script to extract arithmetic operators and number as operands  from i/p
   and communicate the same to yacc */
%option noyywrap 
%{
void yyerror(char*);
#include "y.tab.h"
int yylval;
%}
ws [ \t\n]+
digit  [0-9]
%%
{ws}        ;
{digit}+ { yylval = atoi(yytext); return NUM;}
"("      {return '(';}
")"      {return ')';}
"+"      {return '+';}
"*"      {return '*';}
.        {yyerror("invalid character\n");}
%%

