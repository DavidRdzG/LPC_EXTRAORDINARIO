#!/bin/bash

echo "	>>>MENU DE SELECCION<<<"
echo "1. Netdiscover"
echo "2. Portscan"
echo "3. Info sistema"
echo "4. Salir"

read -p 'INGRESAR OPCION: ' opcion

#echo "hola "$opcion

function netdis(){
	direccion_ip=`ip addr show |grep inet |grep -v "127.0.0.1" |grep -v inet6 |awk '{print $2}' |awk -F. '{print $1"."$2"."$3"."$4}'`;
	subred=`ip addr show |grep inet |grep -v "127.0.0.1" |grep -v inet6 |awk '{print $2}' |awk -F. '{print $1"."$2"."$3"."}'`;
	echo ">>>DIRECCION IP: "$direccion_ip;
	echo ">>>SUBRED: "$subred;

	for ip in {1..254}
	do
		ping -q -c 4 ${subred}${ip} > /dev/null
		if [ $? -eq 0 ]
		then
		    echo ">>>RESPUESTA HOST: " ${subred}${ip}
		else
		    echo ">>>SIN RESPUESTA  : "${subred}${ip}
		fi
	done
}

function info_sistema(){
	echo "[INFO SISTEMA]";
	echo ">>>USERNAME: "$USER;
	echo ">>>HOSTNAME: "$HOSTNAME;
	#$os=`cat /proc/version`
	echo ">>>S.O     : "
	cat /etc/os-release
}

function portscan(){
	#direccion=$1
	puertos="20,21,22,23,25,50,51,53,80,110,119,135,136,137,138,139,143,161,162,389,443,445,636,1025,1443,3389,5985,5986,8080,10000"
	echo ">>INGRESE IP: "
	read ${dir};
	#nc -nvz $dir 1-1024 > ${dir}.txt 2>&1
	#echo "ESCANEO REALIZADO. RESULTADOS EN "${dir}".txt";
	for port in $puertos
	do
		timeout 1 bash -c "echo > /dev/tcp/$dir/$port > /dev/null 2>$1" &&\
		echo $dir": "$port" is open"\
		||\
		echo $dir": "$port" is closed"
	done

}

case $opcion in
	 1)
		echo "[NETDISCOVER]"
		netdis
	 ;;
	 2)
		echo "opcion dos [PORTSCAN]"
		portscan
	 ;;
	 3)
		echo "opcion tres [INFO]"
		info_sistema
	 ;;
	 4)
		echo "opcion cuatro [SALIR]"
		$dowhile=0
	 ;;
	 *)
		echo "default???"
	 ;;
esac
