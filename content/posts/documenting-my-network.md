---
slug: documenting-my-network
title: Documenting My Network
authors: [sid]
keywords: ['sid', 'lacy', 'blog', 'website', 'cybersecurity', 'security', 'computer', 'hackthebox', 'htb', 'tech', 'network', 'diagram']
tags: [networking, projects, homelab]
description: Running inventory for interviews
Summary: Running inventory for interviews
cover:
    image: "/media/netdiag.png"
    alt: "My home network"
    caption: "My home network"
date: 2022-01-03
---

I recently interviewed virtually for a remote junior sysadmin role at a local company. Ultimately, I was not extended an offer of employment; however, I feel I learned a lot from the interview process, especially considering the rather unconventional nature of the questions I was asked. I'll expand on this point in the future, as much of the discussion to be had there is outside the scope of this post.

One topic the company hiring manager and sysadmin team raised with me during the technical interview round was my network and home lab; specifically, if I could describe it in detail and what I might change about it given the opportunity. As I was sharing my screen at the time, what better to show than a plot of my network as I reviewed each component? Alas, what documentation I did have was poor quality and severely outdated — overall, not something of any genuine use.


I felt I should refresh my network diagram, both in case a similar situation arises and for my benefit. After all, it *is* perhaps ironic that, as invested as I am in the world of security and networking, I was still logging into my router's web interface to view devices in my DHCP pools each time I forgot the IP address of a machine I needed to connect to...

Further, I have arguably managed to be rather frugal while building my network and home lab. If you're reading this and have an interest in developing your network or home lab up from ground zero, stay with me; I'll show my hardware, machine configurations, and the services I host, and how it's possible to do the same without breaking the bank.

## Logical Topology: A Rough Draft

![Diagram of my home network](/media/netdiag_old.png)

**EDIT (2022.03.01): see an updated version of this diagram [*here*](/media/netdiag.png).**

Using [Lucid](https://lucid.app), I created an illustration of the significant devices within my network and how they relate to one another. Of significant note: the majority of client devices and the model of my edge router have been excluded, as the clients on my network have no significance as they relate to the architecture of the network and I have no intention of broadcasting what router I use in case somehow a related CVE is discovered and exploited faster than I can patch it. I recognize that security by obscurity is, of course, not a viable strategy, but my point stands.

In any case, what I have shown above highlights the important parts of my hardware. My Internet plan allows for maximum realistic throughout of 540/17 Mbps, and what I have installed provides for that without issue — all Ethernet cabling is a mixture of Cat 5E and Cat 6.

## Hardware

As it relates to designing a network, the physical topology of my residence is somewhat awkward: the house is not attached to the garage, and in turn, a studio-sized outbuilding branches off from the garage, though is similarly disconnected from the house. As a result, two wireless access points and two separate Ethernet runs from the garage are required to ensure LAN connectivity throughout the property.

### Routing & Switching
Since there are not many wired devices, I have managed to get away with only a few physical switches and my edge router for packet routing. All physical switches in question are [unmanaged, 5-port gigabit models from TP-Link](https://www.tp-link.com/us/home-networking/5-port-switch/tl-sg105/).

Interfaces `eth1` and `eth2` connect to a virtual switch on my router, which pulls IP addresses from a single DHCP pool.  `eth1` connects to the main house and `eth2` to the outbuilding.

### Wireless Access Points

Serving the main house is a retired Netgear Nighthawk [R6700v3](https://www.netgear.com/support/product/R6700v3.aspx) router/switch/AP combo unit. This used to be my main router and AP but now operates exclusively in AP mode. Side note: I resent the R6700v3, and I regret purchasing it. Perhaps it's better with [DD-WRT](https://wiki.dd-wrt.com/wiki/index.php/Netgear_R6700v3), but I haven't tried for myself; the stock Netgear firmware is terrible, however: very slow, buggy, and [vulnerable](https://securityaffairs.co/wordpress/126179/hacking/netgear-nighthawk-r6700v3-flaws.html). I'm glad it isn't exposed to the Internet any longer. Do yourself a favor and stay away from this product (and Netgear as a whole, [if you value your sanity](https://www.tomsguide.com/news/netgear-router-patches-nov21)).

The garage and outbuilding, conversely, are wirelessly supported with hardware I like quite a lot: Ubiquiti's [Access Point WiFi 6 Lite](https://store.ui.com/products/unifi-ap-6-lite). I haven't had any issues with Ubiquiti gear so far — admittedly, that means very little outside of an enterprise context.

## Services

### DHCP

My router serves IP addresses over two pools: `LAN` provides addresses to devices downstream of the aforementioned virtual switch. My server hardware rests in the garage, since it can be somewhat noisy, and gets addresses from `garage`.

### OpenVPN

My router also runs an OpenVPN server using interface `vtun0`. I was inclined to use WireGuard, but the WireGuard binary wasn't considered stable at the time I set up my VPN interface, so I stayed with OpenVPN.

I do all of my work on a MacBook, which essentially acts as a thin client to SSH/VNC into my Linux servers and VMs for the heavy-lifting on development and projects; in that respect, OpenVPN connectivity to my local network has been very useful when I'm away from home. Further, if I ever need files on local machines, my network is only a click (and a decent Internet connection) away.

I'll write a post in the future on my experience using macOS for school and projects related to my in-progress cybersecurity and political science degrees, since I know many tend to shy away from Apple products in the security field.

### DNS

My DHCP pools are configured to advertise the server on my network running [AdGuard Home](https://adguard.com/en/adguard-home/overview.html), a free DNS server centered around, as the name implies, blocking advertisements. While it's easy enough to run [uBlock](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/) on a desktop browser (or Firefox Mobile) to avoid the great majority of advertisements on the web, the same cannot be said when considering, for instance, Roku on the TV or apps on smartphones. AdGuard is a fantastic DNS server similar to [PiHole](https://pi-hole.net/) — host blacklist files can be easily installed, and when a device tries to connect to a domain in those blacklists, AdGuard won't resolve the IP, leading to a dropped connection.

> Why use AdGuard over PiHole?

No reason — both are fantastic appliances and serve the same purpose. Using the [OISD domain list](https://oisd.nl/), which works on both AdGuard and PiHole, ads are limited while not breaking any websites I use.

Running a local DNS server also has the advantage of being able to examine domain request statistics network-wide, which can lead to some interesting discoveries. My household typically makes between 40,000 and 50,000 DNS requests per any given 24-hour interval, about 40 percent of which are found on my loaded blacklists and subsequently dropped, which I find shocking. Further, it was only once I directed all of my devices towards my DNS server that I discovered the sheer volume of garbage requests sent by Roku and my Netgear router — a single Roku on my network alone sends about 7,000 requests per day to scribe.logs.roku.com and cloudservices.roku.com, collectively. I assume both are related to telemetry.

### VS Code Server

Using an M1 MacBook for work, I am locked out of running a great deal of software related to cybersecurity, either because ARM, macOS, or both aren't supported by the tools I need. To bypass this issue, I use VS Code's SSH extension to develop on x86 hardware running Linux. That way, I don't have to consider compatibility issues while writing code. The Markdown source file that contains the text on this page, as well as Node.js to build this website, are all accessed by my laptop remotely in this manner.

### Microsoft Key Management Service

Since I often work with Windows 10 VMs (in an educational context), I use [vlmcsd](https://hub.docker.com/r/mikolatero/vlmcsd/) to license new images. Note: I do not condone piracy — a third-party KMS server could be used for that purpose.

### Proxmox

I use [Proxmox VE](https://www.proxmox.com/en/proxmox-ve) as a bare-metal VMM, chosen over ESXi for its advanced feature set and as a learning experience. As it stands, my host Proxmox host is less-than-powerful. Linux guests perform acceptably, though Windows 10, given its graphical acceleration requirements, makes for a rough experience. Further, I only have 250 gigabytes of storage space, which severely limits the number of guests I can store.

## Next Steps

Reflecting on my current network configuration, my needs are served. However, my Proxmox host is sorely deserving of an upgrade. Looking towards the future, I'd like to purchase a few terabytes of solid-state storage and configure ZFS in RAID 1, just in case something goes wrong. Further, I have a spare Nvidia GT 1030 I'd like to try to configure for GPU passthrough to improve the desktop performance for Windows guests — whether I can avoid the dreaded [error code 43](https://mathiashueber.com/fighting-error-43-nvidia-gpu-virtual-machine/) on Pascal architecture remains to be seen.

As a student, I am not flush with money. Assuming that changed, I would like to build a powerful computer and virtualize everything off of it through Proxmox. In that sense, I suppose all-inclusive virtualization is my end goal.