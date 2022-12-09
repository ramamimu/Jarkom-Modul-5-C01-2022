echo '
nameserver 192.168.122.1
' > /etc/resolv.conf

apt-get install netcat -y

# soal 4
iptables -A INPUT -d 10.10.6.139/29 -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -d 10.10.6.139/29 -j REJECT