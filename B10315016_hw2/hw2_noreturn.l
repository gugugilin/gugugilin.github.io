%{
#include "y.tab.h"
#include <string>
#include <map>
#include <iostream>
#include <list>
#define MAX_LINE_LENG 256
#define LIST     strcat(buf,yytext)
using namespace std;
int linenum = 0;
char buf[MAX_LINE_LENG];
bool TokenFlag = false;
string finalstring = "";

class hashtable {
	public:
		hashtable();
		int insert(string);
		int lookup(string);
		void dump();
	private:
		map<string,int> StrIntmap;
		map<int,string> IntStrmap;
		int SIindex;
		int ISindex;
};
hashtable myhashtable;

hashtable::hashtable()
{
	SIindex = 0;
	ISindex = 0;
}

hashtable create() 
{
	return hashtable();
}

int hashtable::insert(string temp) 
{
	if(StrIntmap.count(temp)>0) return StrIntmap.find(temp)->second;
	else
	{
		StrIntmap.insert(pair<string,int>(temp,SIindex++));
		IntStrmap.insert(pair<int,string>(ISindex++,temp));
		return SIindex-1;
	}
}

int hashtable::lookup(string temp) {
	if(StrIntmap.count(temp)>0)
		return StrIntmap.find(temp)->second;
	return -1;
}

void hashtable::dump(){
	map<int,string>::iterator it;
	for (it=IntStrmap.begin(); it!=IntStrmap.end(); ++it)
    	cout << it->first << " => " << it->second << "\n";
}

int tokenString(string s , int mytokenID) 
{
	LIST;
	TokenFlag = true;
	printf("<%s:%s>\n",s.c_str(),finalstring.c_str());
	return mytokenID;
}

int token(string t , int mytokenID) {
	LIST;
	TokenFlag = true;

	if(t=="Keywords" || t=="ID" || t=="Integer" || t=="Boolean" || t=="Real" || t=="String") 
		printf("<%s:%s>\n",t.c_str(),yytext);
	else 
		printf("<%s:'%s'>\n",t.c_str(),yytext);

	return mytokenID;
}

%}

%x string
%x comment

OneLineComments "//".*"\n"



comma "," 
colon ":" 
semicolon ";"
Leftparentheses "("
Rightparentheses ")"
Leftsquarebracket "["
Rightsquarebracket "]"
Leftbracket "{"
Rightbracket "}"

addition "+"
minus "-"
multiplication "*"
division "/"
exponentiation "^"
remainder "%"
lessthan "<"
notmorethan "<="
notlessthan ">="
morethan ">"
equal "=="
notequal "!="
and "&"
not "!"
or "|"

assignment "="  
addassignment "+="
minusassignment "-="
mulassignment "*="
divassignment "/="

Identifiers [a-zA-Z][a-zA-z0-9]*
digs [0-9]+
IntegerConstants {digs}
plain_real {digs}"."{digs}
expreal {digs}"."{digs}[Ee][+-]?{digs}
RealConstants {plain_real}|{expreal}
StringConstants \"[^\"]*\"

%%
[ \t]*  {
	LIST;
}

{OneLineComments} %{
	LIST;
    printf("%d: %s", ++linenum, buf);
    buf[0] = '\0';
%}

\n %{ 
	if(TokenFlag) TokenFlag = false;
	LIST;
    printf("%d: %s", ++linenum, buf);
    buf[0] = '\0';
%}

"true" {token("true",TRUE);}
"false" {token("false",FALSE);}

"bool" {token("bool",BOOL);}
"break" {token("break",BREAK);}
"case" {token("case",CASE);}
"const" {token("const",CONST);}
"continue" {token("continue",CONTINUE);}
"default" {token("default",DEFAULT);}
"else" {token("else",ELSE);}
"for" {token("for",FOR);}
"func" {token("func",FUNC);}
"go" {token("go",GO);}
"if" {token("if",IF);}
"import" {token("import",IMPORT);}
"int" {token("int",INT);}
"nil" {token("nil",NIL);}
"print" {token("print",PRINT);}
"println" {token("println",PRINTLN);}
"real" {token("real",REAL);}
"return" {token("return",RETURN);}
"string" {token("string",STRING);}
"struct" {token("struct",STRUCT);}
"switch" {token("switch",SWITCH);}
"type" {token("type",TYPE);}
"var" {token("var",VAR);}
"void" {token("void",VOID);}
"while" {token("while",WHILE);}

{comma} {token("comma",COMMA);}
{colon} {token("colon",COLON);}
{semicolon} {token("semicolon",SEMICOLON);}
{Leftparentheses} {token("Leftparentheses",LEFTPARENTHESES);}
{Rightparentheses} {token("Rightparentheses",RIGHTPARENTHESES);}
{Leftsquarebracket} {token("Leftsquarebracket",LEFTSQUAREBRACKET);}
{Rightsquarebracket} {token("Rightsquarebracket",RIGHTSQUAREBRACKET);}
{Leftbracket} {token("Leftbracket",LEFTBRACKET);}
{Rightbracket} {token("Rightbracket",RIGHTBRACKET);}

{addition} {token("addition",ADDITION);}
{minus} {token("minus",MINUS);}
{multiplication} {token("multiplication",MULTIPLICATION);}
{division} {token("division",DIVISION);}
{exponentiation} {token("exponentiation",EXPONENTIATION);}
{remainder} {token("remainder",REMAINDER);}
{lessthan} {token("lessthan",LESSTHAN);}
{notmorethan} {token("notmorethan",NOTMORETHAN);}
{notlessthan} {token("notlessthan",NOTLESSTHAN);}
{morethan} {token("morethan",MORETHAN);}
{equal} {token("equal",EQUAL);}
{notequal} {token("notequal",NOTEQUAL);}
{and} {token("and",AND);}
{not} {token("not",NOT);}
{or} {token("or",OR);}


{Identifiers} %{
	myhashtable.insert(yytext);
	token("ID",IDENTIFIERS);
%}

{IntegerConstants} %{
	token("Integer",INTEGERCONSTANTS);
%}


{RealConstants} %{
	token("Real",REALCONSTANTS);
%}


\"	{
	BEGIN string;
	finalstring = "";
	LIST;
}

<string>\"	{
	BEGIN 0;
	tokenString("String",STRINGCONSTANTS);
}

<string>\"\" {finalstring+="\""; LIST;}

<string>\n {
	LIST;
	printf("%d: %s", ++linenum, buf);
	printf("missing terminating \" character\n");
	exit(-1);
}

<string>. {finalstring+=yytext; LIST;}

"/*" {
	BEGIN comment;
	LIST;
}

<comment>"*/" {
	BEGIN 0;
	LIST;
}
<comment>\n {
	LIST;
    printf("%d: %s", ++linenum, buf);
    buf[0] = '\0';
}
<comment>. {
	LIST;
}


.	%{ 
	LIST;
	printf("%d:%s\n", ++linenum, buf);
	printf("bad character:'%s'\n",yytext);
	exit(-1);
%}

%%

int main()
{
    FILE *fp = fopen("HelloWorld.go", "r");
    
    if(fp == NULL) 
    {
		fprintf(stderr, "Can't Open File :( \n");
		exit(-1);
    }
    yyin = fp;

	myhashtable = create();
	yylex();
	
	return 0;
}

int yywrap()
{
	if(TokenFlag) printf("%d: %s\n", ++linenum, buf);
	printf("\n\n");
	printf("symbol table: \n");
	myhashtable.dump();
	return -1;
}