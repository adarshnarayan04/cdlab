/* lex script to extract arithmetic operators and number as operands  from i/p
   and communicate the same to yacc */
%option noyywrap 
%{
void yyerror(char*);
#include "y.tab.h"
%}
ws [ \t\n]+
digit  [0-9]
%%
{ws}        ;
{digit}+ {return NUM;}
"+"      {return PLUS;}
"*"      {return MULT;}
"/"      {return DIV;}
"-"      {return SUB;}
.        {yyerror("invalid character\n");}
%%
