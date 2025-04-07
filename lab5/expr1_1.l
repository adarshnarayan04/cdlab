/* lex script to extract arithmetic operators and number as operands  from i/p
   and communicate the same to yacc */
%option noyywrap 
%{
void yyerror(char*);  //should have ; here
#include "y.tab.h"
%}
ws [ \t\n]+
digit  [0-9]
%%
{ws}        ;  //dont write {;} here
{digit}+ {return NUM;}
"+"      {return plus;} //can also write \+ or [+]
"*"      {return mult;}
.        {yyerror("invalid character\n");}
%%
