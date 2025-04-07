%{
#include <stdio.h>//always add these three
#include <string.h> 
#include <stdlib.h>
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
       $$.place = (char*)malloc(10); //use this alos
       sprintf($$.place, "t%d", temp); // sprintf is like $$.place=printf("t%d",temp) , it store the result of printg in this the variable ( but in actullay do not print anything)
       line++; temp++; 
   }
 | E '-' F  {
       printf("%d: t%d := %s - %s\n", line, temp, $1.place, $3.place);
       $$.place = (char*)malloc(10);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | F { $$.place = strdup($1.place); } //directky dumped the value, as not nned to to create t5,t4  , F has alredy variable in $1.place
   ;

F: F '*' T  {
       printf("%d: t%d := %s * %s\n", line, temp, $1.place, $3.place);
       $$.place = (char*)malloc(10);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | F '/' T  {
       printf("%d: t%d := %s / %s\n", line, temp, $1.place, $3.place);
       $$.place = (char*)malloc(10);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | F '%' T  {
       printf("%d: t%d := %s mod %s\n", line, temp, $1.place, $3.place);
       $$.place = (char*)malloc(10);
       sprintf($$.place, "t%d", temp);
       line++; temp++; 
   }
 | T { $$.place = strdup($1.place); }
   ;

T: ID { $$.place = strdup($1); }
 | INT { $$.place = (char*)malloc(10);sprintf($$.place, "%d", $1); } //as place store char* not int , so convert to char by printf ( we treating 20 as an variable, instead of creating a new t1=20 , we created 20 as variable name) --> as here we dont have to evaluted the value , just print intermeditate code
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