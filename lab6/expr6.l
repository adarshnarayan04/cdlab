/* lex script to extract arithmetic operators and number as operands  from i/p
   and communicate the same to yacc */
%option noyywrap 
%{
void yyerror(char*);
#include "y.tab.h"
int yylval;
%}
ws [ \t]+
digit  [0-9]
newline [\n]
%%
{ws}        ;
{digit}+ { yylval = atoi(yytext); return NUM;}
"("      {return '(';}
")"      {return ')';}
"+"      {return '+';}
"*"      {return '*';}
{newline} {return '\n';}
.        {yyerror("invalid character\n");}
%%

