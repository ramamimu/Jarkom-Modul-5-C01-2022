# eth0
auto eth0
iface eth0 inet static
	address 192.168.122.2
	netmask 255.255.255.252
    gateway 192.168.122.1


# eth1 A5
auto eth1
iface eth1 inet static
	address 10.10.6.150
	netmask 255.255.255.252

# eth2 A4
auto eth2
iface eth2 inet static
	address 10.10.6.146
	netmask 255.255.255.252
