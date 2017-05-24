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

Identifiers [a-zA-Z][a-zA-Z0-9]*
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

"true" {return token("true",TRUE);}
"false" {return token("false",FALSE);}

"bool" {return token("bool",BOOL);}
"break" {return token("break",BREAK);}
"case" {return token("case",CASE);}
"const" {return token("const",CONST);}
"continue" {return token("continue",CONTINUE);}
"default" {return token("default",DEFAULT);}
"else" {return token("else",ELSE);}
"for" {return token("for",FOR);}
"func" {return token("func",FUNC);}
"go" {return token("go",GO);}
"if" {return token("if",IF);}
"import" {return token("import",IMPORT);}
"int" {return token("int",INT);}
"nil" {return token("nil",NIL);}
"print" {return token("print",PRINT);}
"println" {return token("println",PRINTLN);}
"real" {return token("real",REAL);}
"return" {return token("return",RETURN);}
"string" {return token("string",STRING);}
"struct" {return token("struct",STRUCT);}
"switch" {return token("switch",SWITCH);}
"type" {return token("type",TYPE);}
"var" {return token("var",VAR);}
"void" {return token("void",VOID);}
"while" {return token("while",WHILE);}
"read" {return token("read",READ);}

{comma} {return token("comma",COMMA);}
{colon} {return token("colon",COLON);}
{semicolon} {return token("semicolon",SEMICOLON);}
{Leftparentheses} {return token("Leftparentheses",LEFTPARENTHESES);}
{Rightparentheses} {return token("Rightparentheses",RIGHTPARENTHESES);}
{Leftsquarebracket} {return token("Leftsquarebracket",LEFTSQUAREBRACKET);}
{Rightsquarebracket} {return token("Rightsquarebracket",RIGHTSQUAREBRACKET);}
{Leftbracket} {return token("Leftbracket",LEFTBRACKET);}
{Rightbracket} {return token("Rightbracket",RIGHTBRACKET);}

{addition} {return token("addition",ADDITION);}

{minus} {return token("minus",MINUS);}

{multiplication} {return token("multiplication",MULTIPLICATION);}
{division} {return token("division",DIVISION);}
{exponentiation} {return token("exponentiation",EXPONENTIATION);}
{remainder} {return token("remainder",REMAINDER);}
{lessthan} {return token("lessthan",LESSTHAN);}
{notmorethan} {return token("notmorethan",NOTMORETHAN);}
{notlessthan} {return token("notlessthan",NOTLESSTHAN);}
{morethan} {return token("morethan",MORETHAN);}
{equal} {return token("equal",EQUAL);}
{notequal} {return token("notequal",NOTEQUAL);}
{and} {return token("and",AND);}
{not} {return token("not",NOT);}
{or} {return token("or",OR);}

{assignment} {return token("assignment",ASSIGNMENT);}
{addassignment} {return token("addassignment",ADDASSIGNMENT);}
{minusassignment} {return token("minusassignment",MINUSASSIGNMENT);}
{mulassignment} {return token("mulassignment",MULASSIGNMENT);}
{divassignment} {return token("divassignment",DIVASSIGNMENT);}


{Identifiers} %{
	myhashtable.insert(yytext);
	return token("ID",IDENTIFIERS);
%}

{IntegerConstants} %{
	return token("Integer",INTEGERCONSTANTS);
%}


{RealConstants} %{
	return token("Real",REALCONSTANTS);
%}


\"	{
	BEGIN string;
	finalstring = "";
	LIST;
}

<string>\"	{
	BEGIN 0;
	return tokenString("String",STRINGCONSTANTS);
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

/*
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
*/

int yywrap()
{
	if(TokenFlag) printf("%d: %s\n", ++linenum, buf);
	printf("\n\n");
	printf("symbol table: \n");
	myhashtable.dump();
	return -1;
}