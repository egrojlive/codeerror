#!/bin/bash
if [[ "$USER" != 'root' ]]; then
  echo "Este Script Solo Funciona Para Usuarios root"
  rm $0 > /dev/null 2>&1
  exit
fi
timedatectl set-timezone America/Mexico_City > /dev/null 2>&1;
ja="mi"
je="key"
opcion=$1
token=$2
fecha=$3
conexiones=$4
contra=$5
crownvpn(){
contra="mikey"
if [ $contra == "$ja$je" ]; then
echo "Primero Debes Generar La Key De Revendedor"
exit
fi
if [ $token ]; then
if [ $fecha ]; then
if chage -l $token > /dev/null 2>&1; then
pkill -u $token
chage -E $fecha $token
chfn -f $fecha -r $contra $token
echo "$token:$contra" | chpasswd
echo "TOKEN: $token MODIFICADO"
echo
echo "Vence El Dia $fecha"
pkill -u $token
else
useradd $token -s /bin/false
chage -E $fecha $token
chfn -f $fecha -r $contra $token
echo "$token:$contra" | chpasswd
echo "NUEVO TOKEN REGISTRADO : $token"
echo ""
echo "Vence El Dia $fecha"
fi
else
echo "FECHA VACIA"
fi
else
echo "TOKEN VACIO"
fi
}

codeerror(){
if [ $token ]; then
if [ $fecha ]; then
if [ -f /usr/bin/limitar ]; then
chmod +x /usr/bin/limitar
else
wget https://github.com/egrojlive/codeerror/raw/master/limit.sh -O /usr/bin/limitar > /dev/null 2>&1;
chmod +x /usr/bin/limitar
fi
if chage -l $token > /dev/null 2>&1; then
pkill -u $token
chage -E $fecha $token
chfn -f $fecha -r $contra -o $conexiones $token
limitar $token $conexiones
echo
echo "$token:$contra" | chpasswd
echo "USUARIO: $token MODIFICADO"
echo "Vence El Dia $fecha"
pkill -u $token
service dropbear restart > /dev/null 2>&1
service stunnel4 restart > /dev/null 2>&1
else
useradd $token -s /bin/false
chage -E $fecha $token
chfn -f $fecha -r $contra -o $conexiones $token
echo "$token:$contra" | chpasswd
limitar $token $conexiones
echo
echo "NUEVO USUARIO REGISTRADO"
echo "Vence El Dia $fecha"
fi
else
echo "FECHA VACIA"
fi
else
echo "TOKEN VACIO"
fi
}
if [ $1 == "crownvpn" ]; then
crownvpn
else
codeerror
fi
