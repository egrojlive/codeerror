#!/usr/bin/env bash
if [[ "$USER" != 'root' ]]; then
  echo "Este Script Solo Funciona Para Usuarios root"
  rm $0 > /dev/null 2>&1
  exit
fi

if [ $(which stunnel) ]; then
echo
else
echo 'Es Necesario Que Primero Instales Stunnel'
rm $0 > /dev/null 2>&1
exit 0
fi

ip=$1;
puerto=$2;

if [ $ip ]; then
echo;
else
echo "No Se Recibio La Ip Y Puerto"
rm $0 > /dev/null 2>&1
exit 0;
fi

if [ $puerto ]; then
escuchar=$puerto;
else
escuchar=442;
fi

mkdir /etc/code > /dev/null 2>&1;
echo "[stunnelcode5]
client = no
cert = /etc/stunnel/stunnel.pem
accept = $escuchar
connect = $ip
" > /etc/code/stunnelcode.conf
echo "[Unit]
Description=SSL StunnelCode 5
After=network.target
After=syslog.target

[Install]
WantedBy=multi-user.target
Alias=stunnel.target

[Service]
Type=forking
ExecStart=/usr/bin/stunnel /etc/code/stunnelcode.conf
ExecStop=/usr/bin/pkill stunnel

TimeoutSec=600

Restart=always
PrivateTmp=false" > /etc/systemd/system/stunnel5.service;

chmod +x /etc/systemd/system/stunnel5.service > /dev/null 2>&1;
systemctl daemon-reload > /dev/null 2>&1;
systemctl enable stunnel5.service > /dev/null 2>&1;
systemctl restart stunnel5.service > /dev/null 2>&1;
echo "Redireccionado Puerto $puerto Para Ssl tls tunnel"
echo "Ahora Puedes Usar Tu Vpn En Ssl En Puerto: $puerto"
echo "Para Conectarte a $ip"
echo
rm $0 > /dev/null 2>&1;
