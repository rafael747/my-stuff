#!/bin/bash

if [ -e "$1.asm" ]
then
	nasm -f elf $1.asm
	ld -m elf_i386 -s -o $1 $1.o
	rm $1.o
else
	echo "Arquivo $1.asm não existe!"
	echo "Informe o nome do arquivo sem a extenção!!"
fi
