%{
#include <stdio.h>
int yylex(void);
void yyerror(char *);
int temp = 1;
int line = 10;
%}

%union
{
    int intval;
    float realval;
    char* name;
    struct attr
    {
        char *place; // Temp var to store current temporary variable name
        char *code; // Subsequent TAC being generated
    } twoattr;
}

%right '='
%left  '+' '-'
%left  '*' '/' '%'
%token <name> ID
%token <intval> INT //INT is NUM ( as in lex we return INT , but should be NUM (as easier to read))
%token <realval> REAL
%type  <twoattr> E
%type  <twoattr> F 
%type  <twoattr> T 

%%

S: ID '=' E ';' { printf("%d: %s := %s\n", line++, $1, $3.place); }
   ;

E: E '+' F  {
       printf("%d: t%d := %s + %s\n", line, temp, $1.place, $3.place);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | E '-' F  {
       printf("%d: t%d := %s - %s\n", line, temp, $1.place, $3.place);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | F { $$.place = strdup($1.place); }
   ;

F: F '*' T  {
       printf("%d: t%d := %s * %s\n", line, temp, $1.place, $3.place);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | F '/' T  {
       printf("%d: t%d := %s / %s\n", line, temp, $1.place, $3.place);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | F '%' T  {
       printf("%d: t%d := %s mod %s\n", line, temp, $1.place, $3.place);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | T { $$.place = strdup($1.place); }
   ;

T: ID { $$.place = strdup($1); }
 | INT { sprintf($$.place, "%d", $1); }
   ;

%%

void yyerror (char* mess)
{
    fprintf(stderr, "%s\n", mess);
}

int main()
{
    yyparse();
    return 1;
}