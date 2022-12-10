echo '
nameserver 192.168.122.1
' > /etc/resolv.conf

apt-get install netcat -y

iptables -F

# soal 4
iptables -A INPUT -d 10.10.6.138/29 -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -d 10.10.6.138/29 -j REJECT

iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A OUTPUT -j LOGGING
iptables -A LOGGING -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
iptables -A LOGGING -j DROP