---
slug: discord-beta
title: DiscordSetup.zip
authors: [sid]
keywords: ['sid', 'lacy', 'blog', 'website', 'cybersecurity', 'security', 'computer', 'discord', 'malware', 'tech', 'network']
tags: [discord, 'phishing', 'scam']
description: 'The phishers are improving: a brief analysis of a rudimentary "Discord Beta" scam'
summary: 'The phishers are improving: a brief analysis of a rudimentary "Discord Beta" scam'
cover:
    image: "/media/discord-beta-cover.jpg"
    alt: "@jjying, (Unsplash, 2020)"
    caption: "@jjying, (Unsplash, 2020)"
date: 2022-05-23
showtoc: true
draft: true
---
> Discord Beta just came out! It's invite-only; I got personally selected by Discord staff! Are you using it yet?!

Well, first of all, *Discord Beta* has already existed for years as [Discord Canary/PTB](https://support.discord.com/hc/en-us/articles/360035675191-Discord-Testing-Client) -- but what am I even talking about?

Over the past week, I have been trying to work past COVID sickness -- as it appears, however, another virus was also floating around online (yes, funny because pun; you may now laugh).

## Discord Message

On Sunday, May 22nd, 2022, my [friend](https://twitter.com/AlbinoGazelle) received three identical messages on Discord at 5:31 PDT, originating from three separate Discord accounts, `Discord#9527`, `Discord#5298`, and `Discord#0519`.

### Body

The body of the message reads:

> Hi,
> 
> Your account is receiving this notice due to your approval as a Discord Beta user.
>
> Specifically, Discord Beta has been released to a few users and you have been selected.
>
> Please be aware to follow all Discord Beta rules. See the Discord Beta rules here: h[xx]ps://invite-beta[.]com/guidelines 
>
> Discord Beta has some extra features, if you share this invite with another user you will miss your chance!
>
> Discord Beta Invite: h[xx]ps://invite-beta[.]com/
>
> Sincerely,  
> Discord Trust and Safety

### Screenshot

A screenshot of the message is below (courtesy of [@AlbinoGazelle](https://twitter.com/AlbinoGazelle)).

![Screenshot of Discord Message](/media/discord-beta-1.png)

### Initial Indicators of Illegitimacy

it is painfully clear that the message is not legitimate, from several telltale signs:

 - The message originated from a standard Discord user account (just called Discord)
 - Several copies of the message were sent at once, all from different accounts
 - The message notes that "Your account is receiving this notice due to your approval as a Discord Beta user," whereas *Discord Beta* does not exist; only the stable version, PTB, and Canary do
 - The included link, `invite-beta.com` is not affiliated with Discord
 - The message states that "if you share this invite with another user you will miss your chance," but there is no invite token attached to the link

### More Spam

Overall, the most significant element to me is the link, which directs to a mostly legitimate-looking webpage. This is unusual to me -- my university, for instance, is no stranger to phishing scams, but most are very poorly written, like this one from last week:

![Screenshot of WWU Scam Message](/media/discord-beta-2.jpg)

The link directed to the page shown below, which -- come on, now -- isn't even emulating the correct university (I attend WWU, not SPU).

![Screenshot of WWU Scam Message Redirect](/media/discord-beta-3.png)

## invite-beta[.]com

### Home Page

Considering the phishing attempts I am most familiar with, I was pleasantly surprised, in a morbid sense, to see that the scam artists behind "Discord Beta" appear to have spent more than a few minutes crafting a convincing landing page for their attack.

![Screenshot of invite-beta[.]com](/media/discord-beta-4.png)

### Immediate Issues

It's far from perfect -- for instance, browsing to `invite-beta[.]com/nitro.html` from the `Nitro` ref in the banner displays a clear error, already revealing more information than necessary.

![Screenshot of Browsing to invite-beta[.]com/nitro.html](/media/discord-beta-5.png)

That said, most users who fall for the scam will likely be drawn instead to the large `Download` button to get their copy of "Discord beta" as fast as possible. *Sigh.* I assume that, ultimately, creating several mediocre false pages pays off better in most cases than spending a significant amount of time polishing one.

### Registration Information

Looking at the WHOIS records for invite-beta[.]com revealed a variety of interesting pieces of information:

 - It was last registered for one year only three days ago: `Created on 2022-05-19`
 - The webserver is hosted behind Cloudflare in Florida: `AS13335 CLOUDFLARENET`
 - The domain name was registered with Google Domains: `Registrar Google LLC `
 - The registrant contact is listed as Toronto, Canada: `Tech Contact Contact Privacy Inc. Customer 7151571251 96 Mowat Ave, Toronto, ON, M4K 3K1, CA`

### Webserver Headers

As shown before, the webserver is running on Apache version 2.4.53 on Windows, but since the site is hosted on Cloudflare infrastructure, I see little point in poking around for any other holes.

### Exploring the Site

Certain other links redirect to the genuine Discord website (`discord.com`), whereas still others, such as the `Login` button, simply download a ZIP archive. This ZIP archive, `DiscordSetup.zip` is the most interesting element of this operation at large, in my opinion.

It is obvious that this website was simply cloned from Discord, and that, in the absence of any login-stealing forms or other sorts of malicious components, the entire website was created and Discord messages propagated to promote users downloading the archive.

## DiscordSetup.zip

### Meta
 - File: `Zip archive data, at least v2.0 to extract`
 - SHA256 sum: `e149c1289a238865316b0975b7f42633560c0a5e1f8f9c3284a63f759109bf4a`
 - Size: `~94M`
 - Source: `h[xx]ps://invite-beta[.]com/DiscordSetup.zip`
 - Timestamp:  `Sun 22 May 2022 07:35:53 PM PDT`

[VirusTotal report](https://www.virustotal.com/gui/file/e149c1289a238865316b0975b7f42633560c0a5e1f8f9c3284a63f759109bf4a) as of Sun 22 May 2022 06:03:52 PM PDT (6/57 detections).

### Contents

Upon extracting `DiscordSetup.zip`, the following file is returned:
```
$ unzip DiscordSetup.zip
Archive:  DiscordSetup.zip
  inflating: DiscordSetup.exe
$
```

## DiscordSetup.exe

### Meta
 - File: `PE32 executable (GUI) Intel 80386, for MS Windows`
 - SHA256 sum: `0e0dc45a765d14c82a7a846ec8ac670d412ce8b46bb12a586ab5fa0d8d2ca56a`
 - Size: `~94M`
 - Source: `h[xx]ps://invite-beta[.]com/DiscordSetup.zip`
 - Timestamp:  `Sun 22 May 2022 07:35:53 PM PDT`

[VirusTotal report](https://www.virustotal.com/gui/file/https://www.virustotal.com/gui/file/0e0dc45a765d14c82a7a846ec8ac670d412ce8b46bb12a586ab5fa0d8d2ca56a) as of Sun 22 May 2022 07:35:53 PM PDT (6/63 detections).

Only the following engines detected malicious behaviour:
 - Gridinsoft as `Trojan.Win32.Gen.ko!s1`
 - Jiangmin as `Trojan.Qhost.it`
 - Rising as `Trojan.Generic@AI.89 (RDML:TqI8kmX6B/oYiq+ghxtHAQ)`
 - Trellix (FireEye) as `Generic.mg.72eb44cb51ce92a9`
 - VBA32 as `BScope.Trojan.Qhost`
 - Zillya as `Trojan.SchoolGirl.Win32.86`

The absence of Microsoft Defender is especially intriguing, considering that is the AV engine most Windows users employ and is the platform this malicious package targets. If I had to guess, this operation has already been quite successful.

I couldn't use `unzip`, `7z`, or `unrar` to extract the executable, so let's pivot to Windows. Bringing the file into my test environment (Windows Server 2022 Standard build 20348.643), we can also see more sloppy work on the part of the attackers in the Windows Properties metadata box.

![Screenshot of DiscordSetup.exe Metadata](/media/discord-beta-6.png)

For reference, the metadata for a legitimate Discord build looks like this:

![Screenshot of Actual DiscordSetup.exe Metadata](/media/discord-beta-7.png)

### Execution

IMPORTANT: Before continuing, I would like to note that what follows is *not* a "proper" threat modeling/detection or forensics approach. I am simply taking a cursory glance at obvious malware for fun. To effectively discover the scope of the malicious operations performed by the executable, a much more thorough and analytical approach must be taken to properly document each step instead of just disabling the NIC in one of my old Windows VMs and running the package.

Unsurprisingly, the application is not signed, so SmartScreen complains upon launch. A few seconds post-execution, a CLI window pops up running something called `Louisiana.exe`; clearly., the attackers do not care whatsoever about subtlety, which is mildly disappointing.

![Screenshot of Running DiscordSetup.exe](/media/discord-beta-8.png)

Navigating to the parent directory of the console window process, two new files are visible:

 - `BetterDiscord-Windows.exe`
	- File: `PE32 executable (GUI) Intel 80386, for MS Windows, Nullsoft Installer self-extracting archive`
	- SHA256 sum: `50ed26767c4866ebd94f76d23cb1c535df16d3f87840fb3dba3fd77409f00d0b`
	- Size: `~64M`
	- Source: `DiscordSetup.zip`
	- [VirusTotal report](https://www.virustotal.com/gui/file/50ed26767c4866ebd94f76d23cb1c535df16d3f87840fb3dba3fd77409f00d0b) (0/64 detections)

 - `Louisiana.exe`
	- File: `PE32+ executable (console) x86-64, for MS Windows`
	- SHA256 sum: `afb6ed839ba60e6975a4e7a220cea27e129695c057e8fef6b90d2b1bc86569d0ca56a`
	- Size: `~67M`
	- Source: `DiscordSetup.zip`
	- [VirusTotal report](https://www.virustotal.com/gui/file/afb6ed839ba60e6975a4e7a220cea27e129695c057e8fef6b90d2b1bc86569d0) (2/65 detections)

![Screenshot of Parent Directory of Executable Contents](/media/discord-beta-9.png)

Note that [over 100 other files] were also dropped, but none seemed particularly interesting.

### BetterDiscord-Windows.exe

Better Discord is a legitimate open-source project; the SHA256 sum of `BetterDiscord-Windows.exe` even matches the hash for Better Discord v1.5.3 from the official project website, ([betterdiscord.app/](https://betterdiscord.app/)).

I feel comfortable disregarding `BetterDiscord-Windows.exe` as simply a wrapper of false legitimacy employed by the attacker(s).

### Louisiana.exe

As a reminder, `Louisiana.exe` is the suspicious Node package that made itself visible via the console window upon elexution of `DiscordSetup.zip`. Avast and AVG both flag `Louisiana.exe` as`Win64:PWSX-gen [Trj]` (a trojan). `Louisiana.exe` also got flagged by the following rulesets:

#### YARA: INDICATOR_SUSPICIOUS_EXE_References_CryptoWallets

```
rule INDICATOR_SUSPICIOUS_EXE_References_CryptoWallets {
    meta:
        author = "ditekSHen"
        description = "Detects executables referencing many cryptocurrency mining wallets or apps. Observed in information stealers"
    strings:
        $app1 = "Ethereum" nocase ascii wide
        $app2 = "Bitcoin" nocase ascii wide
        $app3 = "Litecoin" nocase ascii wide
	...
        $app70 = "Blockstream\\" ascii wide
        $app71 = "GreenAddress Wallet\\" ascii wide
        $app72 = "bitpay\\" ascii wide

        $ne1 = "C:\\src\\pgriffais_incubator-w7\\Steam\\main\\src\\external\\libjingle-0.4.0\\talk/base/scoped_ptr.h" fullword wide
        $ne2 = "\"%s\\bin\\%slauncher.exe\" -hproc %x -hthread %x -baseoverlayname %s\\%s" fullword ascii
    condition:
        uint16(0) == 0x5a4d and (not any of ($ne*) and 6 of them)
}
```

#### Sigma (HIGH): Suspicious Script Execution From Temp Folder

```
title: Suspicious Script Execution From Temp Folder
id: a6a39bdb-935c-4f0a-ab77-35f4bbf44d33
description: Detects a suspicious script executions from temporary folder
status: experimental
references:
    - https://www.microsoft.com/security/blog/2021/07/13/microsoft-discovers-threat-actor-targeting-solarwinds-serv-u-software-with-0-day-exploit/
author: Florian Roth, Max Altgelt
date: 2021/07/14
modified: 2021/11/11
tags:
    - attack.execution
    - attack.t1059
logsource:
    category: process_creation
    product: windows
detection:
    selection:
        Image|endswith:
            - '\powershell.exe'
            - '\mshta.exe'
            - '\wscript.exe'
            - '\cscript.exe'
        CommandLine|contains: 
            - '\Windows\Temp'
            - '\Temporary Internet'
            - '\AppData\Local\Temp'
            - '\AppData\Roaming\Temp'
            - '%TEMP%'
            - '%TMP%'
            - '%LocalAppData%\Temp'
    filter:
        CommandLine|contains: 
            - ' >'
            - 'Out-File'
            - 'ConvertTo-Json'
            - '-WindowStyle hidden -Verb runAs'  # VSCode behaviour if file cannot be written as current user
    condition: selection and not filter
falsepositives:
    - Administrative scripts
level: high
```

#### Sigma (HIGH): Suspicious Script Execution From Temp Folder