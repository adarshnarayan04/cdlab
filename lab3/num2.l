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
				 
%%

{ws}      {;}
{octalnum} {printf(" (Token, Lexeme) = (OCTAL NUMBER, %s)\n", yytext); return (3);}
{number}  {printf(" (Token, Lexeme) = (DECIMAL NUMBER, %s)\n", yytext); return (2);}
{delimiter} {printf(" (Token, Lexeme) = (DELIMITER, '%s')\n", yytext); return (5);}
{float} {printf(" (Token, Lexeme) = (FLOAT, %s)\n", yytext); return (3);}
{binary} {printf(" (Token, Lexeme) = (BIT STRING, %s)\n", yytext); return (3);}
{char} {printf(" (Token, Lexeme) = (CHAR LITERAL, %s)\n", yytext); return (3);}
{hexa} {printf(" (Token, Lexeme) = (HEXA NUMBER, %s)\n", yytext); return (3);}


%%
int main()
{ while(yylex()); 
  return 0;
}
