---
layout: post
title: "Windows Proxy Configuration"
modified: 2015-01-15 14:11:00 +0800
tags: [windows,proxy,powershell]
description: "I wrote a quick script that purges the auto-conf and sets a fixed Europe proxy, so the internet is accessible again :-)"
image:
  feature: no_nuisance.jpg
  credit:  Unknown
  creditlink: 
comments: true
share:    true
---
The annoying IT department automatically pushes a proxy-configuration to all computers in my office. This doesn't sound to bad, until you find out that the specific proxy-conf they push routes sites blocked in China
through our Chinese connection, even though we're running through a VPN in Europe.

They used to just toggle the auto-conf setting, which was easy enough to undo, but now they delete all the user configured proxy settings.

I'm sure it's some kind of regulation, but still a major annoyance, since e.g. Google search is hardly usable in China (very slow and regularly dropped connections).

Powershell to the rescue! Finally a use for it :-) I wrote a quick script that purges the auto-conf and sets a fixed Europe proxy, so the internet is accessible again :-)

If anyone ever needs it:

{% highlight powershell %}
$flip = (Get-ItemProperty -Path 'registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections' -Name DefaultConnectionSettings).DefaultConnectionSettings
$flip[8] = "3"
Set-ItemProperty -Path 'registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections' -Name DefaultConnectionSettings -Value $flip
Set-ItemProperty -Path 'registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyEnable -Value 1
Set-ItemProperty -Path 'registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyOverride -Value "<local>"
Set-ItemProperty -Path 'registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -Value "<server>:<port>"﻿
{% endhighlight %}