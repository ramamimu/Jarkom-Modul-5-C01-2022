# eth0
auto eth0
iface eth0 inet static
    address 10.10.6.149
    netmask 255.255.255.252
    gateway 10.10.6.150

# eth1
auto eth1
iface eth1 inet static
    address 10.10.4.1
    netmask 255.255.254.0

# eth2
auto eth2
iface eth2 inet static
    address 10.10.6.137
    netmask 255.255.255.248

# eth3
auto eth3
iface eth3 inet static
    address 10.10.7.1
    netmask 255.255.255.0
