echo '
nameserver 192.168.122.1
' > /etc/resolv.conf

#install DHCP Relay
apt-get update
apt-get install isc-dhcp-relay -y

echo '
# Defaults for isc-dhcp-relay initscript
# sourced by /etc/init.d/isc-dhcp-relay
# installed at /etc/default/isc-dhcp-relay by the maintainer scripts

#
# This is a POSIX shell fragment
#

# What servers should the DHCP relay forward requests to?
SERVERS="10.10.6.131"

# On what interfaces should the DHCP relay (dhrelay) serve DHCP requests?
INTERFACES="eth0 eth1 eth2 eth3"

# Additional options that are passed to the DHCP relay daemon?
OPTIONS=""' > /etc/default/isc-dhcp-relay

echo '
net.ipv4.ip_forward=1
' > /etc/sysctl.conf


service isc-dhcp-relay restart

# soal 5
iptables -t nat -A PREROUTING  -p tcp --dport 80 -d 10.10.6.139 -m state --state NEW -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.10.6.138
iptables -t nat -A PREROUTING  -p tcp --dport 80 -d 10.10.6.139 -j DNAT --to-destination 10.10.6.139

iptables -t nat -A PREROUTING  -p tcp --dport 443 -d 10.10.6.138 -m state --state NEW -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.10.6.138
iptables -t nat -A PREROUTING  -p tcp --dport 443 -d 10.10.6.138 -j DNAT --to-destination 10.10.6.139