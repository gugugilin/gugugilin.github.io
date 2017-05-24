yacc yacctemplate.y -d
lex hw2.l
yacc yacctemplate.y -d
g++ y.tab.c -o a1.out
