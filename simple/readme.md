jflex -d output simple.jflex
Reading "simple.jflex"
Constructing NFA : 165 states in NFA
Converting NFA to DFA : 
...........................................................................
79 states before minimization, 48 states in minimized DFA
Writing code to "output/Yylex.java"

javac -cp .:java/* output/Yylex.java

