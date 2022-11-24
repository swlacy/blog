---
slug: macos-cybersecurity-student
title: Running macOS as a Cybersecurity Student
authors: [sid]
keywords: ['sid', 'lacy', 'blog', 'website', 'cybersecurity', 'student', 'security', 'computer', 'hackthebox', 'htb', 'tech', 'macos']
tags: [student, macos]
description: My personal perspective on running MacOS as a Cybersecurity student — not everyone's first choice
summary: My personal perspective on running MacOS as a Cybersecurity student — not everyone's first choice
date: 2022-01-08
---

I was recently in the position to buy a new laptop, an essential tool ever since my university transitioned back to in-person courses post-Covid lockdowns. No longer could I rely on being landlocked to my bulky desktop at home; while I already had an older netbook, it was slow and rather uncomfortable for extended use. We are nothing if not spoiled for choice in the laptop market today, however — deciding on what to purchase was not an easy choice for me, especially given that I am a student with limited spending power. 

So, given the myriad of powerful workstation-class, portable x86 machines for sale, why did I eventually land on an ARM-powered MacBook with comparatively poor software and virtualization support as a cybersecurity student? My intention here is not to sell anyone on my decisions, and what works well for me may not for another user, even one with a similar workflow. However, if another student encounters this post, I'd like to share my thoughts and experiences using macOS for the first time after a lifetime of Windows and Linux; to provide the perspective I wish I could have been exposed to before making the jump.

For the record, I purchased the [2020 M1 MacBook Air](https://support.apple.com/kb/SP825) for $976.31 after tax in early October of 2021, which is approximately three months before the publication of this post. I migrated all my work off of my Windows 10 desktop to the laptop shortly after its arrival — that way, I could transport my primary workstation between my house and my university campus.

## My Workflow

In all honesty, doing much of anything on a laptop, especially multitasking, is not comfortable to me — juggling windows and virtual desktops is tedious and, at times, frustrating, not to mention the lack of screen real estate in general. I much prefer the traditional desktop setup. My intention with any laptop as a workstation is to use it in its intended form while traveling but to plug it into a desktop-style configuration when possible.

I do all my cybersecurity homework in virtual machines and containers, which eases machine state management, provides for manipulatable environments, and abstracts my work from personal use. That includes using security tools: Nmap, Wireshark, Burp Suite, etc.; programming: C, Java, Python, PHP, JavaScript, etc.; mounting databases; executing Windows and Linux binaries, among other tasks. Therefore, I need access to a VMM and spare resources for VMs... an ill-supported ARM-based, fanless machine with only eight gigabytes of memory and less than 250 gigabytes of usable storage is not quite up to that task.

For that reason — and this is an important point — I have several virtual machines hosted on *separate servers* accessible over my LAN or remotely via an OpenVPN server I set up. I remote into these VMs for work; in that sense, my MacBook is but a thin client. I do not recommend replicating my purchase whatsoever if intending to use a single device as an all-in-one computing solution.

## Pain Points

Before proceeding, I feel it's important to note that many of my complaints are not slights against the MacBook or macOS; the most significant issues I have with the device are related to my prior experience with desktop computers in general. The most notable behavior includes that which is not bad, per se, just unexpected.

### Default macOS Shortcuts and Key Layout

The standard full-sized US keyboard layout dictates that the bottom left-hand side should consist of the keys control, OS modifier, and then alt, in that order, before space. The MacBook's built-in keyboard switches this up in radical fashion, replacing that order with function, control, alt, OS modifier, and then space. I rely primarily on the keyboard for all input using shortcuts in place of the mouse/touchpad, making the layout differences one of the most frustrating parts of transitioning between macOS and Windows/Linux. It is true that software such as [Karabiner Elements](https://karabiner-elements.pqrs.org) may be used to remap keys, but this requires tedious configuration, requires constantly-running software with access to all keyboard input, and doesn't change the physical layout of the buttons, which still differs from the standardized US keyboard.

Then, the shortcuts themselves are also quite different. For example, in Windows and most desktop Linux distributions I've used, control + Z and control + Y undo and redo a given action within an application that supports such interaction, respectively. In macOS, control + Z is still bound to undo, but control + shift + Z is the combination to redo, whereas control + Y typically does nothing. Disrupting such a frequently used shortcut with change feels cumbersome and unwelcome — again, however, these are not inherent issues with macOS, but simply troublesome inconsistencies resulting from different patterns of use.

### User Freedom and Customization 

Where Windows has PowerShell, and Linux has Bash, macOS has — well, macOS has Bash too (and Zsh by default now, a welcome change). On Windows, I can spawn an elevated PowerShell instance to get what I need, and on Linux, for better or worse, I can sudo myself into an unrecoverable state. Should I simply want to remove the Chess application on macOS, however, it is required to reboot into recovery mode and disable the system integrity protection (SIP) so that I am then *allowed to execute sudo* to remove Chess.app, which will be immediately reinstalled upon the next update. Sigh.

Instead, Apple would prefer users only modify the system to the extent advertised within the System Preferences app. While my previous example of removing a built-in game is ultimately insignificant and meaningless in terms of usability, the issue presented there extends into other areas of operation. Ultimately, these issues will not matter to most users, and neither do they significantly affect my workflow. That said, the level of user restriction stands out to me, as I prefer the Linux "you are the authority of your own system" approach on a philosophical level.

### Hardware Issues

The single most annoying hardware issue I have with the M1 Air is the back of native multi-monitor support. There are two Thunderbolt 3 ports, each supporting up to 40 gigabits per second data transfer. I have two 2560x1440 displays at 60 Hz, 8-bit color depth, which works out to a total data transfer requirement of a little over 13 gigabits per second to drive both simultaneously. Why Apple decided to limit the M1 SoC from supporting more than one external display out of the box is baffling to me. Instead, I had to pay 150 dollars for a special dock that required a third-party driver to work — but it did work, indicating that the hardware is perfectly capable of supporting more than one external display in extended mode.

Then, there is a strange compatibility issue between the macOS and my Logitech GPW mouse, which has not been present in any other machine I have used. Specifically, the mouse seems to "skip" across the screen ever so often. This problem doesn't impact my work but is relatively annoying.

## Saving Graces of the MacBook

Lots of negativity so far, so why didn't I return the machine and opt for something else? Despite the aforementioned issues — believe me, they are annoying — the new ARM-based MacBooks are very solid in nearly every other respect. I certainly don't believe the older x86-based models are worth buying, but Apple's new hardware, being under their control to a great degree, has allowed the creation of a tightly integrated, highly optimized experience. I won't preach every benefit in exhaustive detail (plenty of other resources for that), but I believe some things deserve mention here. Whereas the performance cannot come close to my desktop computer and the benefits of the UNIX environment can be easily replicated with Linux, the incredible battery life and fanless (and thus silent) operation have been consistently impressive. Power management is aggressive, and this writing this entire post, for example, has drained my battery from 100% to 97% thus far — just see below, with VS Code, Firefox, Spotify, Zoom, and many other apps open:

```
$ sudo powermetrics
...
ANE Power: 0 mW
DRAM Power: 18 mW
CPU Power: 282 mW
GPU Power: 3 mW
Package Power: 305 mW
```

## Conclusion
I intend for this post to provide another perspective on using macOS as a user of Windows and Linux, especially as a cybersecurity student. Is the M1 platform a reasonable all-in-one solution for my work? Certainly not. Operating as a thin-client, offloading computationally expensive or incompatible tasks, however, makes the base-model MacBook an exceptional tool. Disregarding raw performance and application compatibility allows issues such as battery life, display quality, etc., to gain pertinence; in those respects, the MacBook excels.