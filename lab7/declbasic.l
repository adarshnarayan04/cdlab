%{
#include <stdio.h>
#include "y.tab.h"
#include <stdlib.h>
#include <string.h>

%}

%option yylineno //to know line number
ws [ \t\n]+
letter [A-Za-z]
digit  [0-9]
id {letter}({letter}|{digit})*

%%

{ws}        ;
"int"       {yylval.typeattr.type = (char*)malloc(sizeof(yytext)); 
             strcpy(yylval.typeattr.type, yytext);yylval.typeattr.width=4;return INT;}
"float"     {yylval.typeattr.type = (char*)malloc(sizeof(yytext)); 
             strcpy(yylval.typeattr.type, yytext);yylval.typeattr.width=4;return FLOAT;}
{id}        {yylval.name=(char*)malloc(sizeof(yytext)); 
             strcpy(yylval.name, yytext); return ID;}
";"         {return ';';}
","         {return ',';;}
.           {printf("Unrecognized Character : %s \n", yytext);}
%%

int yywrap(void)
{
  return 1;// tells Flex "we're done, stop lexing"
}
