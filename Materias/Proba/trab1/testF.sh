#!/bin/bash

gcc insertion.c -o a.out
gcc selection.c -o b.out
gcc merge.c -o c.out
gcc shellsort.c -o d.out
gcc quicksort.c -o e.out


echo -e "\n\t\t\t Métodos de Ordenação\n"
echo "Quantidade de Testes: $1"
echo "Tamanho da Entrada: $2"

echo -e "\ninsertion\tselection\tmerge\t\tshell\t\tquick"

for n in `seq $1`
do
	
	echo $2 > "alea"
	seq 1 $2|sort -R >> "alea"
	

	ta=000000 #`./a.out < alea`
	tb=000000 #`./b.out < alea`
	tc=`./c.out < alea`
	td=`./d.out < alea`
	te=`./e.out < alea`
	
	#echo "$ta" >> ./saida/insertion_$2.txt
	#echo "$tb" >> ./saida/selection_$2.txt
	echo "$tc" >> ./saida/merge_$2.txt
	echo "$td" >> ./saida/shell_$2.txt
	echo "$te" >> ./saida/quick_$2.txt

	echo -e "$ta\t$tb\t$tc\t$td\t$te"

	rm alea
done


