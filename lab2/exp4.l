%option noyywrap
%{
int count=1;
%}

%%
a*b  {printf("Token %d found:%s \n",count,yytext);count++;return 1;}
c+   {printf("Token %d found:%s \n",count,yytext);count++;return 2;}
[^abc]+   {printf("Token not found:%s \n",yytext);count++;return 4;}
.    {printf("No Token Found:%s \n",yytext);return 3;}
%%
 int main()
 { while(yylex());}
