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
