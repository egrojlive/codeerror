#!/bin/bash
function ssl_info(){
	if [ -f /etc/stunnel/stunnel.conf ]; then
    puertosssl=$(cat /etc/stunnel/stunnel.conf | grep -i accept | awk '{print $3}' | sort)
    for p1 in $puertosssl
    do
    	echo "Servicio ssl Instalado"
    echo "puerto $p1"
	done
	else
		echo "Stunnel No Se Encuentra Instalado"
    fi
    unset puertosssl
    unset p1
}
function squid_info(){
if [ -f /etc/squid/squid.conf ]; then
	puertosquid=$(cat /etc/squid/squid.conf | grep -i http_port | awk '{print $2}' | sort)
for p2 in $puertosquid
do
	echo "Servicio squid Instalado"
echo "puerto $p2"
	done
elif [ -f /etc/squid3/squid.conf ]; then
			puertosquid=$(cat /etc/squid3/squid.conf | grep -i http_port | awk '{print $2}' | sort)
for p2 in $puertosquid
do
echo "puerto $p2"
	done
else
	echo "El Servicio Squid No Se Encuentra Instalado"
	return
fi
unset puertosquid
    unset p2
}
function dropbear_info(){
	if [ -f /etc/default/dropbear ]; then
	puertodropbear=$(cat /etc/default/dropbear | grep -i DROPBEAR_PORT)
	echo "Servicio Dropbear Instalado"
echo "$puertodropbear"
else
	echo "El Servicio Dropbear No Se Encuentra Instalado"
fi
unset puertodropbear
}
if [ $1 == "ssl" ]; then
    ssl_info
elif [ $1 == "squid" ]; then
	squid_info
elif [ $1 == "dropbear" ]; then
	dropbear_info
else
	echo "El Comando Es Incorrecto"
fi