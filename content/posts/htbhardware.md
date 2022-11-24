---
title: HackTheBox — Hardware Challenges
description: Walkthroughs for the HackTheBox Hardware Challenge section — work in progress
keywords: ['sid', 'lacy', 'blog', 'website', 'cybersecurity', 'security', 'computer', 'hackthebox', 'htb', 'hardware']
hide_table_of_contents: false
ShowReadingTime: true
ShowBreadCrumbs: false
ShowPostNavLinks: false
summary: Walkthroughs for the HackTheBox Hardware Challenge section — work in progress
date: 2022-02-08
cover:
    image: "/documents/htbhardwarechallenges.png"
ShowToc: true
TocOpen: false
draft: true
---

Hello! This page documents my (ongoing) solutions to the [HackTheBox *Hardware* challenges](https://app.hackthebox.com/challenges/). I have done my best to explain the processes I used to resolve the challenge solutions, one step at a time. By doing so, I hope I can more effectively share my learning.

Am I missing an entry? Are my explanations confusing? Please [email me](mailto:contact@swlacy.com?subject=HTB%20Hardware%20Challenges) — I would love to hear from you.

## Debugging Interface

### Preliminary Information

 - Description: "We accessed the embedded device's asynchronous serial debugging interface while it was operational and captured some messages that were being transmitted over it. Can you decode them?"
 - Difficulty: *very easy*
 - Points: 10
 - Author: [diogt](https://app.hackthebox.com/users/1358)
 - Provided files and information:
    - Zip archive: `Debugging interface.zip`
    - SHA-256 hash: `98e289c5b0eec6e53a01e99bd4953c03020055e5990c7113c5634c6732103fd0`

### Walkthrough

Let's first download, verify, and unzip the provided archive, `Debugging interface.zip`.

```bash
$ ls
'Debugging Interface.zip'

$ sha256sum Debugging\ Interface.zip 
98e289c5b0eec6e53a01e99bd4953c03020055e5990c7113c5634c6732103fd0  Debugging Interface.zip

$ unzip Debugging\ Interface.zip 
Archive:  Debugging Interface.zip
[Debugging Interface.zip] debugging_interface_signal.sal password: hackthebox
  inflating: debugging_interface_signal.sal

$ file debugging_interface_signal.sal 
debugging_interface_signal.sal: Zip archive data, at least v2.0 to extract

$
```

Unzipping the archive reveals one file, `debugging_interface_signal.sal`. I was unfamiliar with the `.sal` file extension, so I had to perform some research to proceed. Eventually, I was led to [*Logic 2*](https://www.saleae.com/downloads/), a tool developed by Saleae (hence the extension). The tool claims to "effortlessly decode protocols like SPI, I2C, Serial, and many more" — promising, in the context of this challenge. Luckly, Saleae supports Linux; the AppImage of Logic 2 looks like this:

![Screenshot of Logic 2](/media/hardware1-1.png)

By opening `debugging_interface_signal.sal` as a capture in Logic 2 and selecting the Async Filter view from the right-hand sidebar, Terminal View can be expanded to show activity messages sent. Note that the default Async Filter settings can be used.

![Screenshot of Logic 2](/media/hardware1-2.png)

The last message has `HTB{}` in the stream, a convention used by HackTheBox machines and challenged to indicate flags; thus, the solution has been found! The full string has been censored to preserve the integrity of the challenge.

### Completion

*Debugging interface* was an easy yet quite interesting challenge overall. Thank you to [diogt](https://app.hackthebox.com/users/1358) for creating this box!

https://www.hackthebox.com/achievement/challenge/787255/207

![Proof of completion](/media/hardware1-3.png)

## The Needle

### Preliminary Information

 - Description: "As a part of our SDLC process, we've got our firmware ready for security testing. Can you help us by performing a security assessment?"
 - Difficulty: *very easy*
 - Points: 10
 - Author: [MrR3boot](https://app.hackthebox.com/users/13531)
 - Provided files and information:
    - Zip archive: `The Needle.zip`
    - SHA-256 hash: `535191a711ea95bf58a6d64f940f9409f3af272fcfd685d0e72971e0d55ea03c`

### Walkthrough

Let's first download, verify, and unzip the provided archive, `The Needle.zip`

```bash
$ ls
'The Needle.zip'

$ sha256sum The\ Needle.zip 
535191a711ea95bf58a6d64f940f9409f3af272fcfd685d0e72971e0d55ea03c  The Needle.zip

$ unzip The\ Needle.zip 
Archive:  The Needle.zip
[The Needle.zip] firmware.bin password: hackthebox
  inflating: firmware.bin

$ file firmware.bin 
firmware.bin: Linux kernel ARM boot executable zImage (big-endian)

$
```

Only one file, `firmware.bin`, was contained within the archive — it appearns to be an executable.

![Screenshot of Logic 2](/media/hardware1-1.png)

By opening `debugging_interface_signal.sal` as a capture in Logic 2 and selecting the Async Filter view from the right-hand sidebar, Terminal View can be expanded to show activity messages sent. Note that the default Async Filter settings can be used.

![Screenshot of Logic 2](/media/hardware1-2.png)

The last message has `HTB{}` in the stream, a convention used by HackTheBox machines and challenged to indicate flags; thus, the solution has been found! The full string has been censored to preserve the integrity of the challenge.

### Completion

*Debugging interface* was an easy yet quite interesting challenge overall. Thank you to [diogt](https://app.hackthebox.com/users/1358) for creating this box!

https://www.hackthebox.com/achievement/challenge/787255/207

![Proof of completion](/media/hardware1-3.png)

## MORE

Stay tuned; more challenges will be added in due time!

*Feedback? [I can be reached via email](mailto:contact@swlacy.com?subject=HTB%20Hardware%20Challenges).*
