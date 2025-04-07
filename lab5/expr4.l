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
{digit}+ {return NUM;} //yacc not about about NUM , so need to add in %token NUM
"+"      {return '+';} //if we return a single character ( then yacc know about it (as assco character) , no need to define in )
"*"      {return '*';}
"-"      {return '-';}
"/"      {return '/';}
"%"      {return '%';}
"<"      {return '<';}
.        {yyerror("invalid character\n");}
%%
