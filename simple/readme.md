```bash
jflex -d output simple.jflex
Reading "simple.jflex"
Constructing NFA : 165 states in NFA
Converting NFA to DFA : 
...........................................................................
79 states before minimization, 48 states in minimized DFA
Writing code to "output/Yylex.java"
```

```
javac -cp .:java/* output/Yylex.java
```
Most important is to complile the java files to class file and place them in the same directory as the java file created by jflex. This makes setting the classpath easier. It was a source of much despair for me.

```
cd java/
javac -d ../output Yytoken.java
javac -d ../output Utility.java 
``` 

This creates the class files where we need them. Now we can compile the java files create by jflex.

```
javac -cp . Yylex.java
```
Additionally we could add ``-d bin`` to output the compiled file, in essence the executable, to a dedicated directory.

New we can run the scanner:
```
java Yylex ../test.code
```
Note that there is no *.class file ending required.
Executing from another location requires extending the classpath. 
```
java -cp output/ Yylex test.code
```