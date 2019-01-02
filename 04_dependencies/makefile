all: bin/01.o bin/02.o
	ld -o bin/all bin/01.o bin/02.o

bin/01.o: 01.s
	mkdir -p bin
	as -o bin/01.o 01.s

bin/02.o: 02.s
	mkdir -p bin
	as -o bin/02.o 02.s

run: all
	./bin/all;\
	EXIT_CODE=$$?;\
	echo "app should exit with code 65. code is: $$EXIT_CODE";\

clean:
	rm bin -Rf

