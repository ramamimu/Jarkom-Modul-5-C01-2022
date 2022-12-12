# Laporan Praktikum 5

## Nomor A

Tugas pertama kalian yaitu membuat topologi jaringan sesuai dengan rancangan yang diberikan Loid

![](/img/A.png)

## Nomor B

Untuk menjaga perdamaian dunia, Loid ingin meminta kalian untuk membuat topologi tersebut menggunakan teknik CIDR atau VLSM setelah melakukan subnetting.

**Membagi jaringan menjadi Subnet-subnet berdasarkan topologi VLSM**

![](/img/B.1.png)

**Membuat Tabel Pembagian Subnet**

![](/img/B.2.png)

**Membuat IP tree untuk pembagian IP subnet**

![](/img/B.3.png)

**Hasil Pembagian subnetting menggunakan VLSM**

![](/img/B.4.png)

## Nomor C

Anya, putri pertama Loid, juga berpesan kepada anda agar melakukan Routing agar setiap perangkat pada jaringan tersebut dapat terhubung.

**Tabel Routing**
![](/img/C.1.png)

**Strix**
Network Config

```sh
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

```

Routing

```sh
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
```

**Ostania**

Network Config

```sh
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
```

Routing

```sh
route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.10.6.150
```

**Westalis**

```sh
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
```

Routing

```sh
route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.10.6.146
```

## Nomor D

Tugas berikutnya adalah memberikan ip pada subnet Forger, Desmond, Blackbell, dan Briar secara dinamis menggunakan bantuan DHCP server. Kemudian kalian ingat bahwa kalian harus setting DHCP Relay pada router yang menghubungkannya.

**network config Forger, Desmond, blackbell, dan Briar**

```sh
auto eth0
iface eth0 inet dhcp
```

**Script DHCP relay pada router strix, ostania, dan westalis**

```sh
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

```

## Nomor 1

Agar topologi yang kalian buat dapat mengakses keluar, kalian diminta untuk mengkonfigurasi Strix menggunakan iptables, tetapi Loid tidak ingin menggunakan MASQUERADE.

```sh
iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 192.168.122.2 -s 10.10.0.0/20

```

![](/img/1.png)

## Nomor 2

pada router strix, menggunakan command berikut untuk membolehkan tcp udp pada topologi (sesuai subnet yang sudah ditentukan) dan drop tcp udp lainnya

```sh
iptables -A FORWARD -s 10.10.0.0/21 -j ACCEPT
iptables -A FORWARD -p tcp -j DROP
iptables -A FORWARD -p udp -j DROP
```

![](/img/2.1.png)

## Nomor 3

Loid meminta kalian untuk membatasi DHCP dan DNS Server hanya boleh menerima maksimal 2 koneksi ICMP secara bersamaan menggunakan iptables, selebihnya didrop.

**Garden dan SS Sukses mengeping Eden**

![](/img/3.1.png)

![](/img/3.2.png)

**Desmon Tidak berhasil mengeping Eden karena ping yang ke 3**

![](/img/3.3.png)

**Script pada eden dan wise**

```sh
iptables -A INPUT -p icmp -m connlimit --connlimit-above 2 --connlimit-mask 0 -j DROP
```

## Nomor 4

Akses menuju Web Server hanya diperbolehkan disaat jam kerja yaitu Senin sampai Jumat pada pukul 07.00 - 16.00.

**Script pada garden dan sss**

```sh
iptables -A INPUT -d 10.10.6.139/29 -m time --timestart 07:00 --timestop 16:00 --weekdays Mon,Tue,Wed,Thu,Fri -j ACCEPT
iptables -A INPUT -d 10.10.6.139/29 -j REJECT

```

**Desmon bisa Mengakses SSS pada 12 Des 2022 jam 13:03:37 akan tetapi tidak bisa mengakses pada jam 20:00:04**

![](/img/4.1.png)
![](/img/4.3.png)
![](/img/4.2.png)

## Nomor 5

Menggunakan module statistic untuk melakukan prerouting ke SSS dan Gardem secara bolak balik.

```sh
iptables -t nat -A PREROUTING  -p tcp --dport 80 -d 10.10.6.139 -m state --state NEW -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.10.6.138
iptables -t nat -A PREROUTING  -p tcp --dport 80 -d 10.10.6.139 -j DNAT --to-destination 10.10.6.139

iptables -t nat -A PREROUTING  -p tcp --dport 443 -d 10.10.6.138 -m state --state NEW -m statistic --mode nth --every 2 --packet 0 -j DNAT --to-destination 10.10.6.138
iptables -t nat -A PREROUTING  -p tcp --dport 443 -d 10.10.6.138 -j DNAT --to-destination 10.10.6.139
```

![](/img/5.1.png)  
![](/img/5.2.png)  
![](/img/5.3.png)  
![](/img/5.4.png)  
![](/img/5.5.png)  
![](/img/5.6.png)  
![](/img/5.7.png)  
![](/img/5.8.png)

## Nomor 6

Membuat chain baru untuk logging dan menggunakan job LOG, log level standard adalah log level 4 yaitu warning

```sh
iptables -N LOGGING
iptables -A INPUT -j LOGGING
iptables -A OUTPUT -j LOGGING
iptables -A LOGGING -j LOG --log-prefix "IPTables-Dropped: " --log-level 4
iptables -A LOGGING -j DROP
```

![](/img/6.1.png)

## Kendala

- Kendala pada nomor 6 tidak dapat melakukan writefile log
