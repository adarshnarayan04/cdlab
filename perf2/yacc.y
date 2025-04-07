%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int yylex();
void yyerror(char *mess);
int temp=1;
int line=25;
%}

%union
{
    char* name;
    int val;
}

%token <val> NUM
%token <name> ID
%token LOGAND
%type <name> S E F G H I

%left '%' LOGAND '-'
%right '!' '='

%%

S : ID '=' E ';' { printf("%d: %s := %s\n", line, $1, $3);line++; }
  ;

E : E LOGAND F { 
    printf("%d: t%d := %s && %s\n", line, temp, $1, $3);
    $$ = (char*)malloc(10); 
    sprintf($$, "t%d", temp); 
    line++; temp++; 
 }
  | F { $$ = strdup($1); }
  ;

F : F '-' G { 
    printf("%d: t%d := %s - %s\n", line, temp, $1, $3);
    $$ = (char*)malloc(10); 
    sprintf($$, "t%d", temp); 
    line++; temp++; 
 }
  | G { $$ = strdup($1); }
  ;

G : G '%' H { 
    printf("%d: t%d := %s %% %s\n", line, temp, $1, $3);
    $$ = (char*)malloc(10); 
    sprintf($$, "t%d", temp); 
    line++; temp++; 
 }
  | H { $$ = strdup($1); }
  ;

H : '!' H { 
    printf("%d: t%d := !%s\n", line, temp, $2);
    $$ = (char*)malloc(10); 
    sprintf($$, "t%d", temp); 
    line++; temp++; 
 }
  | I { $$ = strdup($1); }
  ;

I : '(' E ')' { $$ = strdup($2); }
  | ID { $$ = strdup($1); }
  | NUM { 
    printf("%d: t%d := %d\n", line, temp, $1);
    $$ = (char*)malloc(10);
    sprintf($$, "t%d", temp);
    line++; temp++;
 }
  ;

%%

void yyerror(char *mess)
{
    printf("Error: %s\n", mess);
}

int main()
{
    yyparse();
    return 0;
}