echo '
nameserver 192.168.122.1
' > /etc/resolv.conf

# soal 1
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 192.168.122.2 -s 10.10.0.0/20

# A1
route add -net 10.10.6.128 netmask 255.255.255.248 gw 10.10.6.145
# A2
route add -net 10.10.6.0 netmask 255.255.255.128 gw 10.10.6.145
# A3
route add -net 10.10.0.0 netmask 255.255.252.0 gw 10.10.6.145
# A6
route add -net 10.10.4.0 netmask 255.255.254.0 gw 10.10.6.149
# A7
route add -net 10.10.6.136 netmask 255.255.255.248 gw 10.10.6.149
# A8
route add -net 10.10.7.0 netmask 255.255.255.0 gw 10.10.6.149

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

# soal 2
# iptables -A FORWARD -d 10.10.6.128 -i eth0 -p udp DROP
# iptables -A FORWARD -d 10.10.6.128 -i eth0 -p tcp -j DROP