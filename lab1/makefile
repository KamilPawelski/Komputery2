all: hello writeText compareText

hello.o: hello.s
	as --32 -o hello.o hello.s

hello: hello.o
	ld -m elf_i386 -o hello hello.o

writeText.o: writeText.s
	as --32 -o writeText.o writeText.s

writeText: writeText.o
	ld -m elf_i386 -o writeText writeText.o

compareText.o: compareText.s
	as --32 -o compareText.o compareText.s

compareText: compareText.o
	ld -m elf_i386 -o compareText compareText.o




