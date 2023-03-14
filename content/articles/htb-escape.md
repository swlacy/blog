---
draft: true

author: 'Sid Lacy'
title: 'HackTheBox – Escape'
description: 'Complete walkthrough of the Escape Windows machine on HackTheBox'
tags: ['ctf']
date: '2023-03-14'
lastmod: '2023-03-14T'

cover:
    path: '/media/'
    alt: ''
    caption: 'Name (Publisher, YYYY)'

show:
    meta: true
    contents: true
    footnote: true
---

I haven't posted here for a while – to commemorate the visual facelift I've recently given my site, and to jump-start some new activity, I decided to dive right back into some classic CTFs. The last time I seriously played a security CTF was during [NahamCon 2022](/nahamcon-ctf-2022), which feels like forever ago. For what it's worth, I'll also be rejoining AWS as a security engineer this summer, and I also need to reach Hacker rank on HTB to play the AWS lab set, which is a goal of mine I'd like to achieve before I'm employed again.

Finally, as of now, I have not yet completed any Windows boxes on HTB; what better idea, then, is there than to tackle all these objectives at once via [HTB 531: Escape](https://app.hackthebox.com/machines/531)? Escape is a a medium-difficulty Windows machine with 4.9 stars as of the date of playing, with about 1,300 user owns and about 1100 system owns, released 16 days ago.

But this isn't a recipe blog with a novel before any relevant content, so I'll start off right now.

## Enumeration and Reconnaissance

### Connectivity Check
As always, I started off with a simple connectivity test to ensure I could reach the box:

```
$ echo '10.10.11.202 escape.htb' >> /etc/hosts
$ ping escape.htb
PING escape.htb (10.10.11.202) 56(84) bytes of data.
64 bytes from escape.htb (10.10.11.202): icmp_seq=1 ttl=127 time=76.4 ms
64 bytes from escape.htb (10.10.11.202): icmp_seq=2 ttl=127 time=80.9 ms
64 bytes from escape.htb (10.10.11.202): icmp_seq=3 ttl=127 time=76.4 ms
^C
--- escape.htb ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2003ms
rtt min/avg/max/mdev = 76.379/77.914/80.935/2.136 ms
```

### Nmap Scan

Then, since that worked without issue, I started off with my usual Nmap scan to see what's open:

```
$ nmap -sC -sV -oA escape escape.htb
Starting Nmap 7.92 ( https://nmap.org )
Note: Host seems down. If it is really up, but blocking our ping probes, try -Pn
Nmap done: 1 IP address (0 hosts up) scanned in 4.43 seconds
```

That didn't work, so I tried again with the `-Pn` flag:

```
$ nmap -sC -sV -Pn -oA escape escape.htb
Starting Nmap 7.92 ( https://nmap.org )
Nmap scan report for escape.htb (10.10.11.202)
Host is up (0.079s latency).
Not shown: 988 filtered tcp ports (no-response)
PORT     STATE SERVICE       VERSION
53/tcp   open  domain        Simple DNS Plus
88/tcp   open  kerberos-sec  Microsoft Windows Kerberos (server time: 2023-03-14 15:29:16Z)
135/tcp  open  msrpc         Microsoft Windows RPC
139/tcp  open  netbios-ssn   Microsoft Windows netbios-ssn
389/tcp  open  ldap          Microsoft Windows Active Directory LDAP (Domain: sequel.htb0., Site: Default-First-Site-Name)
|_ssl-date: 2023-03-14T15:30:38+00:00; +8h00m28s from scanner time.
| ssl-cert: Subject: commonName=dc.sequel.htb
| Subject Alternative Name: othername:<unsupported>, DNS:dc.sequel.htb
| Not valid before: 2022-11-18T21:20:35
|_Not valid after:  2023-11-18T21:20:35
445/tcp  open  microsoft-ds?
464/tcp  open  kpasswd5?
593/tcp  open  ncacn_http    Microsoft Windows RPC over HTTP 1.0
636/tcp  open  ssl/ldap      Microsoft Windows Active Directory LDAP (Domain: sequel.htb0., Site: Default-First-Site-Name)
|_ssl-date: 2023-03-14T15:30:38+00:00; +8h00m28s from scanner time.
| ssl-cert: Subject: commonName=dc.sequel.htb
| Subject Alternative Name: othername:<unsupported>, DNS:dc.sequel.htb
| Not valid before: 2022-11-18T21:20:35
|_Not valid after:  2023-11-18T21:20:35
1433/tcp open  ms-sql-s      Microsoft SQL Server 2019 15.00.2000.00; RTM
|_ssl-date: 2023-03-14T15:30:38+00:00; +8h00m28s from scanner time.
| ssl-cert: Subject: commonName=SSL_Self_Signed_Fallback
| Not valid before: 2023-03-14T15:06:24
|_Not valid after:  2053-03-14T15:06:24
| ms-sql-ntlm-info: 
|   Target_Name: sequel
|   NetBIOS_Domain_Name: sequel
|   NetBIOS_Computer_Name: DC
|   DNS_Domain_Name: sequel.htb
|   DNS_Computer_Name: dc.sequel.htb
|   DNS_Tree_Name: sequel.htb
|_  Product_Version: 10.0.17763
3268/tcp open  ldap          Microsoft Windows Active Directory LDAP (Domain: sequel.htb0., Site: Default-First-Site-Name)
| ssl-cert: Subject: commonName=dc.sequel.htb
| Subject Alternative Name: othername:<unsupported>, DNS:dc.sequel.htb
| Not valid before: 2022-11-18T21:20:35
|_Not valid after:  2023-11-18T21:20:35
|_ssl-date: 2023-03-14T15:30:38+00:00; +8h00m28s from scanner time.
3269/tcp open  ssl/ldap      Microsoft Windows Active Directory LDAP (Domain: sequel.htb0., Site: Default-First-Site-Name)
|_ssl-date: 2023-03-14T15:30:38+00:00; +8h00m28s from scanner time.
| ssl-cert: Subject: commonName=dc.sequel.htb
| Subject Alternative Name: othername:<unsupported>, DNS:dc.sequel.htb
| Not valid before: 2022-11-18T21:20:35
|_Not valid after:  2023-11-18T21:20:35
Service Info: Host: DC; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: mean: 8h00m27s, deviation: 0s, median: 8h00m27s
| ms-sql-info: 
|   10.10.11.202:1433: 
|     Version: 
|       name: Microsoft SQL Server 2019 RTM
|       number: 15.00.2000.00
|       Product: Microsoft SQL Server 2019
|       Service pack level: RTM
|       Post-SP patches applied: false
|_    TCP port: 1433
| smb2-security-mode: 
|   3.1.1: 
|_    Message signing enabled and required
| smb2-time: 
|   date: 2023-03-14T15:29:59
|_  start_date: N/A

Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 93.83 seconds
```

### Next Steps

It looked like, unless there were hidden services on ports outside the scan range, Escape was hosting a DNS server, a Kerberos server, RPC, NetBIOS, an LDAP server for AD, and an MSSQL server, and maybe a few other things. Since I'm used to CTFs centered around web exploitation, these results were a little outside my comfort zone; regardless, since the attack surface seemed so large, I pushed forward.

One of the benefits of being in a lab environment too, from an attacker's perspective, is that it is simply known some elements of the lab will, without any doubt, be utilized. In this case, I believed that to be the MSSQL server. The same stood for the LDAP server on tpc/389. Further, I saw some references to SMB in the scan results (and tcp/445 open). With that in mind, I decided to begin infiltration by exploring any available SMB shares. The obvious tool to do so was [SMBMap](https://github.com/ShawnDEvans/smbmap), as shown below. But first, I decided to gather more information about the host.

```
smbmap -H escape.htb -v     
[+] escape.htb:445 is running Windows 10.0 Build 17763 (name:DC) (domain:sequel)
```

SMBMap reported the host as [Windows 10 build 17763](https://learn.microsoft.com/en-us/windows/uwp/whats-new/windows-10-build-17763) (released in late 2022), which was very helpful, assuming accuracy.

## SMB Exploration

