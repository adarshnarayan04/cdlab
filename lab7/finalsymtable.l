/* C declarations */
%{
#include "symtable.c"
extern int yylineno, yychar;
void yyerror(char *);
int yylex();
int dcount = 0;
int size = 50; // Size of symbol table
int idx=0;
struct element *symbol_table=NULL;
%}

/* YACC Declarations */
%union {
    char* name;
    struct attr {
        char *type;
        int width;
    } typeattr;
}

%token <name> ID
%token <typeattr> INT FLOAT
%type <typeattr> type decl

%%

prog    :   dlist
        ;

dlist   :   dlist decl ';' { dcount++; }
        |   decl ';'       { dcount++; }
        ;

decl    :   type ID {
                    $$ = $1;  // Set $$ to the type attributes from $1
                    $$ .type = $1.type;
                    $$ .width = $1.width;
                    symtab(&size, symbol_table, "Global", $2, $1.type, $1.width, &dcount, &idx);
                    idx++;
                 }
        |   decl ',' ID {
                    $$ = $1;  // Propagate the previous type information
                    $$ .type = $1.type;
                    $$ .width = $1.width;
                    symtab(&size, symbol_table, "Global", $3, $1.type, $1.width, &dcount, &idx);
                    idx++;
                 }
        ;

type    :   INT {
                    $$ = $1;  // Set $$ to type attributes for INT
                    $$ .type = $1.type;
                    $$ .width = $1.width;
               }
        |   FLOAT {
                    $$ = $1;  // Set $$ to type attributes for FLOAT
                    $$ .type = $1.type;
                    $$ .width = $1.width;
               }
        ;

%%

void yyerror(char *s) {
    printf(" %s  line number : %d near symbol %c  \n", s, yylineno, (char) yychar);
}

int main() {
    // Dynamically allocate memory for the symbol table
    symbol_table = (struct element*) malloc(size * sizeof(struct element));

    initialize(symbol_table, size);

    char *ptr = (char *)malloc(sizeof("Global"));
    ptr = symbol_table[0].name;
    strcpy(ptr, "Global");

    ptr = (char *)malloc(sizeof("Symbol Table"));
    ptr = symbol_table[0].type;
    strcpy(ptr, "Symbol Table");

    yyparse();
    printf(" Total no. of symbols read = %d lastindex %d \n", symbol_table[0].width, lastindex);
    display(symbol_table);
}
