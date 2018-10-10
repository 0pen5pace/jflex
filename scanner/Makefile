

JFLEX      = jflex


all: clean compile output

compile: gen_jflex output/*.java
	javac -d output java/*.java
	javac -cp .:output -d output output/*.java

gen_jflex: scanner.jflex outdir
	$(JFLEX) -d output scanner.jflex


output: compile test.code outdir
	java -cp .:output scanner test.code > output/output.txt

clean:
	rm -rf output/

outdir:
	mkdir -p output
