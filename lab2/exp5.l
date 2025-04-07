%option noyywrap
%{
int count=1;
%}

%%
a*b  {printf("Token %d found:%s \n",count,yytext);count++;return 1;}
c+   {printf("Token %d found:%s \n",count,yytext);count++;return 2;}
.    {printf("No Token Found:%s \n",yytext);return 0;}
%%
 int main()
 { while(yylex());}
