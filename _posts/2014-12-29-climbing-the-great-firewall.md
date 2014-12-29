---
layout: post
title: "Climb the Great Firewall with ease"
modified: 2014-12-29 10:48:00 +0800
tags: [china,technology,vps]
description: "Here's a write-up of the setup I've been using to be able to access the full internet from within China."
image:
  feature: gfw.jpg
  credit:  Unknown
  creditlink: 
comments: true
share:    true
---
Here's a write-up of the setup I've been using for 1TB of data for 5 $/mo.

## Server
* Get a <a href="http://www.digitalocean.com/?refcode=dcdcc49d2169" target="_BLANK">Digital Ocean account</a>. (If you use my referral link, you'll get 10 $ free credit, enough for two months!)
* Create a Droplet using the smallest VPS and the default Ubuntu install (I'm using Amsterdam data center), this will take a minute.
* Connect to your server using the web-console, or an SSH client. Run:

{% highlight bash %}
sudo apt-get update
sudo apt-get install python-pip python-m2crypto supervisor
sudo pip install shadowsocks
{% endhighlight %}

* Run "ifconfig eth0" and note the IP address.
* Create "/etc/shadowsocks.json" with the following contents, and "chmod 600" it:

{% highlight json %}
{
	"server":"<YOUR IP ADDRESS>",
	"server_port":8388,
	"local_address": "127.0.0.1",
	"local_port":1080,
	"password":"<YOUR-PASSWORD>",
	"timeout":600,
	"method":"aes-256-cfb",
	"fast_open": false,
	"workers": 1
}
{% endhighlight %}

* Create "/etc/supervisor/conf.d/shadowsocks.conf" with the following contents:

{% highlight ini %}
[program:shadowsocks] 
command=ssserver -c /etc/shadowsocks.json
autorestart=true
user=nobody
{% endhighlight %}

* Edit "/etc/default/supervisor" with the following contents:

{% highlight bash %}
DAEMON_OPTS="ulimit -n 51200"
{% endhighlight %}

* Run:

{% highlight bash %}
sudo service supervisor start
sudo supervisorctl reload
{% endhighlight %}

## Client
Install the <a href="https://play.google.com/store/apps/details?id=com.github.shadowsocks" target="_BLANK">ShadowSocks client for Android</a>,
or <a href="http://shadowsocks.org/en/download/clients.html" target="_BLANK">check here for other platforms</a>.

Enter the server IP address, password and encryption method and make sure to select "Bypass LAN & China" under "Route". Flip the switch, and you're over the wall!

## Endnotes
While using a full VPS just to climb the wall may be a bit overkill for some, it actually makes a lot of sense. Cost-wise it's similar, or even cheaper, than many VPN servers, but you have a lot more options. If
ShadowSocks doesn't suit your needs, you can easily install OpenVPN or other software. If you're a developer, you can even host your own website on the same VPS. And finally, since you'll be the only one using the
specific IP address, the chances of it getting blocked are much lower.