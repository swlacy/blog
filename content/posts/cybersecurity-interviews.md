---
slug: cybersecurity-interviews
title: Cybersecurity Interviews
authors: [sid]
keywords: ['sid', 'lacy', 'blog', 'website', 'cybersecurity', 'security', 'computer', 'interview', 'questions', 'tech', 'networking']
tags: [career]
description: Common cybersecurity interview questions and answers, plus some tips
summary: Common cybersecurity interview questions and answers, plus some tips
date: 2022-03-16
showtoc: true
cover:
    image: "/media/cybersecurity-interviews-cover.jpg"
    alt: "@homajob, (Unsplash, 2016)"
    caption: "@driaug, Unsplash"
draft: false
---

> **job in·ter·view** [ /ˈjäb ˈin-tər-ˌvyü/ ]  *noun*: a performance art piece in which you, the *interviewee*, are invited to humiliate yourself for the pleasure and delight of the *interviewer(s)*, those in attendance.

Alright, perhaps the above definition is somewhat more dramatic than reality. Starting out though, interviews can certainly feel that way, but they don't have to. This post contains common junior-level cybersecurity interview questions and my answers to them, among other tips. Projecting confidence is an important element of the interview process; my hope is that this page can serve as a handy study guide or cheat sheet for those preparing for their next introductory cybersecurity position. You've got this!

*Did I miss a question you think should be on this page? Please [email it to me](mailto:contact@swlacy.com?subject=Interview%20Question%20Suggestion) and I'll add it here.*

## Technical Questions

In the context of job interviews, I define a *technical question* as a problem or set of problems regarding the implementation or maintenance of business procedures with one or more definitive "correct answers." That is, there must be one or more sets of clearly defined steps which will effectively solve the issue at hand. Technical questions have answers that employers can expect relativly consistant responses to; they are "study problems."

### Describe the steps which occur when a user visits a website in their browser, assuming HTTP.

*Asked by Amazon for the role "Security Engineer Internship - Summer 2022 (US)" in March of 2022*.

1. The user types the URL of the website, such as `http://example.com` into their browser's address bar and presses ENTER.

2. The browser sends a *DNS lookup* to yield a DNS record for the domain name `example.com`. To facilitate fast speeds and minimal network resource usage, DNS records are cached at several locations. In order, DNS lookups are sent as follows:
     - Towards the browser's own DNS cache; if no matching record is found there, another request is sent...
     - Towards the operating system's DNS cache; if no matching record is found there, another request is sent...
     - Towards the connected router's DNS cache; if no matching record is found there, another request is sent...
     - Towards the configured external DNS server, such as the DNS server of the ISP; if no matching record is found, a *recursive DNS request* is sent...
     - Towards DNS servers out on the Internet, which each send their DNS requests to other DNS servers until the IP address of `example.com` is found (hence "recursive"). The browser will wait a preset amount of time for a response, usually about ten seconds — if no response is received by then, the browser displays a message to the user that `example.com` cannot be found, and the process terminates here.

3. The DNS server returns the IP address of `example.com` to the browser, after which the browser initiates a TCP connection with `example.com`. The TCP handshake process takes place in the form of three steps, like so:
     - The user's device asks whether the server at `example.com` can accept new connections with a `SYN` (synchronize) packet.
     - If the server at `example.com` *can* accept new connections, it responds yes with an `SYN/ACK` (synchronize acknowledgment) packet. Otherwise, it responds with a `FIN` packet.
     - If the server at `example.com` responds with a `SYN/ACK` packet, the browser acknowledges the response with an `ACK` packet, and the TCP tunnel is established. Otherwise, if either no packet is received or a `FIN` packet is received, the browser displays an error to the user accordingly, and the process terminates here.
4. The browser uses the established TCP tunnel to send an HTTP `GET` request to the server at `example.com`, requesting the web resource at `example.com`.

5. The server at `example.com` receives the HTTP `GET` request from the client's device and passes it to the appliance that serves the web resource, such as Apache, NGINX, or Miscoroft IIS. Then, the following chain of events occur:
     - The web appliance passes the HTTP `GET` request to a *request handler*, a function or set of functions integrated into the web appliance.
     - The request handler constructs an HTTP response based on the infomation contained within the HTTP `GET` request and passes the response back to the web appliance.
     - The web appliance passes the response back to the server, which then sends it back to the user's device.

6. The client device receives the response from the server at `example.com` and uses that response to render web resources and/or display information to the user. Here are some examples of what types of information might be displayed:
     - The server at `example.com` responds with HTTP code `200`, which means OK (success), and an HTML file. The browser renders the HTML in the file onto the user's screen, sending additional requests as necessary.
     - The server at `example.com` responds with HTTP code `302`, which means that the resource has been found, but it is located at a different location and the address of that resource. The browser sends a duplicate HTTP `GET` request towards that location instead.
     - The server at `example.com` responds with HTTP code `404`, which means that the resource cannot be found, and an HTML page that says as much. The browser renders the HTML in the file onto the user's screen.
     - The server at `example.com` responds with HTTP code `404`, which means that the resource cannot be found, and typically an HTML page that says as much. The browser renders the HTML in the file onto the user's screen.
     - The server at `example.com` responds with HTTP code `500`, which means that an undisclosed issue is occurring on the server's end; thus, the requested resource cannot be served. The browser displays this information to the user's screen.

The process is now complete.

### You need to offer services to remote (WFH) employees over the Internet but do not want those services facing the Internet. Why would you want to do this? How would you accomplish this task?

*Asked by Amazon for the role "Security Engineer Internship - Summer 2022 (US)" in March of 2022*.

Employees often need access to corporate resources while not attached to the corporate network, such as SQL backends, RDP, storage servers, and more. However, exposing direct access to these resources widens the attack surface of the corporate network to malicious actors online. Thus, providing direct, Internet-facing access to these resources is typically not the best solution.

The use of client-server VPN technology is the best way to provide remote employees access to on-site network resources. To that end, I would deploy either OpenVPN or WireGuard. A client-server VPN provides an encrypted, end-to-end tunnel between connected employees and all internal network resources; thus, only the VPN service needs to be exposed to the Internet. Further, the VPN architecture can provide simple access auditing, logging connectivity times, and uniquely identifying connections by the VPN profiles of each employee, providing a trail of activity should anything go awry.

### What does a VPN provide? How does it work?

*Asked by Amazon for the role "Security Engineer Internship - Summer 2022 (US)" in March of 2022*.

A VPN, or a *Virtual Private Network*, provides an end-to-end, encrypted channel of communication between two points. Anyone in-between the endpoints can see the destination, origin, and size of traffic, but not the contents. Thus, VPNs enhance security between the endpoints by way of not allowing third parties to inspect the contents of the traffic. VPNs can also act as an anonymizing network hop when accessing resources, as the resource host will only see the client at one end of the VPN tunnel. Here are some enterprise and consumer examples of the benefits of VPNs:

 - A work-from-home developer needs access to Example Corporation's application development build server. Instead of exposing the application build server to the Internet, where it may be taken advantage of by malicious actors, Example Corporation provides the developer with an OpenVPN profile which can be used to establish a secure connection from the developer's device directly to Example Corporation's internal network. By using the virtual tunnel adapter crated by OpenVPN, the developer can securely interface with Example Corporation's network resources as if directly connected to their internal network.

 - Example corporation has two central offices, one in New York and the other in Seattle. Both offices need to share resources. A site-to-site VPN tunnel can be established between the internal networks of both offices to provide for a secure logical network link.

 - A fan of the television series *The Office* lives within the Crimean Peninsula, one of the regions that Netflix does not serve. By connecting to `netflix.com` from an IP address registered in the Crimean Peninsula, this user will not be allowed to stream content from Netflix. If, however, this user connects to a consumer client-server VPN service hosted in neighboring Romania and uses that encrypted tunnel to access Netflix, Netflix will only be able to identify Romania as the content endpoint. Since Netflix serves Romania, Netflix will stream *The Office* to the Romanian VPN provider, which will then forward that traffic back through the encrypted VPN tunnel to the user in the Crimean Peninsula. By way of that process, regional content restrictions can be circumvented.


## Culture Questions

*Culture questions* are a bit different, as they largely depend on the background of the prospective employee. These are not questions that anyone but you can make a guide for. Regardless, while they do not include answers, some culture questions I have been asked are below.