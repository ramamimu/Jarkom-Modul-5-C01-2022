# eth0
auto eth0
iface eth0 inet static
    address 10.10.6.145
    netmask 255.255.255.252
    gateway 10.10.6.146

# eth1
auto eth1
iface eth1 inet static
    address 10.10.0.1
    netmask 255.255.252.0

# eth2
auto eth2
iface eth2 inet static
    address 10.10.6.1
    netmask 255.255.255.128

# eth3
auto eth3
iface eth3 inet static
    address 10.10.6.129
    netmask 255.255.255.248
