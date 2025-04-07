%option noyywrap
%{
  // no C code is placed here
%}
  
ws [ \t\n]+                           
digit  [0-9]
octalnum 0[0-7]+
number {digit}+
delimiter ,|;
float [0-9]*[.][0-9]*e?E?[+]?[-]?[0-9]*
binary 0b[0-1]+|0B[0-1]+
char ['][^\'][']
hexa 0[xX][0-9a-fA-F]+
leftpar [({\[]
rightpar [)\]}]
keyword int|char|return
comment [/][/][^\t^\n]+
op [+]|[-]|[*]
assignop [=]
string ["][^\"]+["]
identifier [a-zA-z0-9]+
relop >|<|<=|>=

				 
%%

{ws}      {;}
{octalnum} {printf(" (Token, Lexeme) = (OCTAL NUMBER, %s)\n", yytext); return (3);}
{number}  {printf(" (Token, Lexeme) = (DECIMAL NUMBER, %s)\n", yytext); return (2);}
{delimiter} {printf(" (Token, Lexeme) = (DELIMITER, '%s')\n", yytext); return (5);}
{float} {printf(" (Token, Lexeme) = (FLOAT, %s)\n", yytext); return (3);}
{binary} {printf(" (Token, Lexeme) = (BIT STRING, %s)\n", yytext); return (3);}
{char} {printf(" (Token, Lexeme) = (CHAR LITERAL, %s)\n", yytext); return (3);}
{hexa} {printf(" (Token, Lexeme) = (HEXA NUMBER, %s)\n", yytext); return (3);}
{comment} {printf(" (Token, Lexeme) = (SINGLE LINE COMMENT, %s)\n", yytext); return (3);}
{leftpar} {printf(" (Token, Lexeme) = (LEFT PAR, %s)\n", yytext); return (3);}
{rightpar} {printf(" (Token, Lexeme) = (RIGHT PAR, %s)\n", yytext); return (3);}
{keyword} {printf(" (Token, Lexeme) = (KEYWORD, %s)\n", yytext); return (3);}
{op} {printf(" (Token, Lexeme) = (ARITH-OP, %s)\n", yytext); return (3);}
{assignop} {printf(" (Token, Lexeme) = (ASSIGN OP, %s)\n", yytext); return (3);}
{relop} {printf(" (Token, Lexeme) = (RELATIONAL OP, %s)\n", yytext); return (3);}
{string} {printf(" (Token, Lexeme) = (STRING, %s)\n", yytext); return (3);}
{identifier} {printf(" (Token, Lexeme) = (IDENTIFIER, %s)\n", yytext); return (3);}

%%
int main()
{ while(yylex()); 
  return 0;
}
