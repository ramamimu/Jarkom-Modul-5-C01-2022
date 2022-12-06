# sebagai DHCP server
echo '
nameserver 192.168.122.1
' > /etc/resolv.conf

apt-get update
apt-get install isc-dhcp-server -y

echo '
INTERFACES="eth0"
' > /etc/default/isc-dhcp-server


echo '
# A1
subnet 10.10.6.128 netmask 255.255.255.248 {
}

# A2
subnet 10.10.6.0 netmask 255.255.255.128 {
    range 10.10.6.2 10.10.6.126;
    option routers 10.10.6.1;
    option broadcast-address 10.10.6.127;
    option domain-name-servers 10.10.6.130;
    default-lease-time 360;
    max-lease-time 7200;
}

# A3
subnet 10.10.0.0 netmask 255.255.252.0 {
    range 10.10.0.2 10.10.3.254;
    option routers 10.10.0.1;
    option broadcast-address 10.10.3.255;
    option domain-name-servers 10.10.6.130;
    default-lease-time 360;
    max-lease-time 7200;
}

# A6
subnet 10.10.4.0 netmask 255.255.254.0 {
    range 10.10.4.2 10.10.5.254;
    option routers 10.10.4.1;
    option broadcast-address 10.10.5.255;
    option domain-name-servers 10.10.6.130;
    default-lease-time 360;
    max-lease-time 7200;
}

# A8
subnet 10.10.7.0 netmask 255.255.255.0 {
    range 10.10.7.2 10.10.7.254;
    option routers 10.10.7.1;
    option broadcast-address 10.10.7.255;
    option domain-name-servers 10.10.6.130;
    default-lease-time 360;
    max-lease-time 7200;
}
' > /etc/dhcp/dhcpd.conf

service isc-dhcp-server restart