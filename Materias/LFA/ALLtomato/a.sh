#!/bin/bash

exec 2>/dev/null  		#default: somente stdout
if [[ "$1" == "-v" ]];then	#verbose: stdout e stderr
	exec 2>&1
elif [[ "$1" == "-q" ]];then	#quiet: somente status
	exec >/dev/null
fi


e=`grep '^INICIAL:' d.txt|awk '{print $2}'` #estado inicial: INICIAL: ?? em  d.txt

#line=`cat e.txt` # lê a cadeia de um arquivo

read line	 # lê da entrada padrão
if [[ "$line" == "ALLtomato" ]];then
echo "Hell Yeah!"
fi

echo -e "\tAnalizando a cadeia: $line "
echo -ne "$e --" >&2

for i in `echo $line|grep . -o`
do
	e=`awk -v x=$e -v y=$i '$1 == x && $2 == y {print $3}' d.txt`
	if ! [ -n  "$e" ];then
		echo "> FAIL!"
		exit 1
	fi

	echo -ne " $i --> $e --" >&2
done

if (grep -E "^FINAL.*$e" d.txt ) &> /dev/null
then
	echo  "> OK!"
else
	echo  "> FAIL!"
	exit 1
fi
