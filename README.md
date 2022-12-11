# Laporan Praktikum 5

## Nomor 2
pada router strix, menggunakan command berikut untuk membolehkan tcp udp pada topologi (sesuai subnet yang sudah ditentukan) dan drop tcp udp lainnya  
```sh
iptables -A FORWARD -s 10.10.0.0/21 -j ACCEPT
iptables -A FORWARD -p tcp -j DROP
iptables -A FORWARD -p udp -j DROP
```
![](/img/2.1.png)  
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