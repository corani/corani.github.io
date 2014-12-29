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
Here's a write-up of the setup I've been using for 1TB of data for 5 $/mo:

1. Get a <a href="http://www.digitalocean.com/?refcode=dcdcc49d2169" target="_BLANK">Digital Ocean account</a>. (If you use my referral link, you'll get 10 $ free credit, enough for two months!)
2. Create a Droplet using the smallest VPS and the default Ubuntu install (I'm using Amsterdam data center), this will take a minute.
3. Connect to your server using the web-console, or an SSH client. Run:
{% highlight bash %}
  sudo apt-get update
  sudo apt-get install python-pip python-m2crypto supervisor
  sudo pip install shadowsocks
{% endhighlight %}
4. Run "ifconfig eth0" and note the IP address
5. Create "/etc/shadowsocks.json" with the following contents:
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
6. Create "/etc/supervisor/conf.d/shadowsocks.conf" with the following contents:
{% highlight ini %}
  [program:shadowsocks] 
  command=ssserver -c /etc/shadowsocks.json
  autorestart=true
  user=nobody
{% endhighlight %}
7. Edit "/etc/default/supervisor" with the following contents:
{% highlight bash %}
  DAEMON_OPTS="ulimit -n 51200"
{% endhighlight %}
8. Run:
{% highlight bash %}
  sudo service supervisor start
  sudo supervisorctl reload
{% endhighlight %}

Install the <a href="https://play.google.com/store/apps/details?id=com.github.shadowsocks" target="_BLANK">ShadowSocks client for Android</a>,
or <a href="http://shadowsocks.org/en/download/clients.html" target="_BLANK">check here for other platforms</a>.

Enter the server IP address, password and encryption method and make sure to select "Bypass LAN & China" under "Route". Flip the switch, and you're over the wall!