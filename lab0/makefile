all: hello writeText compareText

hello: hello.o
	ld -m elf_i386 -s -o hello hello.o

writeText: writeText.o
	ld -m elf_i386 -s -o writeText writeText.o

compareText: compareText.o
	ld -m elf_i386 -s -o compareText compareText.o

hello.o: hello.s
	as --32 -o hello.o hello.s

writeText.o: writeText.s
	as --32 -o writeText.o writeText.s

compareText.o: compareText.s
	as --32 -o compareText.o compareText.s

