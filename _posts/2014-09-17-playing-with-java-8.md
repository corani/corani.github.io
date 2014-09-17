---
layout: post
title: "Playing with Java 8"
modified: 2014-09-17 13:38:53 +0800
tags: [programming,java,functional]
description: "I've been playing some more with some of the Java 8 features in my toy message-bus. While the features may seem 'just syntax sugar' on the surface, I think it's a real game-changer for Java."
image:
  feature: coffee.jpg
  credit:  Unknown
  creditlink: 
comments: true
share:    true
---
I've been playing some more with some of the Java 8 features in my <a href="https://github.com/corani/minibus/" target="_BLANK">toy message-bus</a>. While the features may seem
"just syntax sugar" on the surface, I think it's a real game-changer for Java.

It takes some time to get your head around using them (though it certainly helps to have experience with other functional languages), but they can really help make your code more
concise and clear.

For example: I have an event queue (or rather, a bunch of them) that was basically a thin wrapper around a generic Java Queue. In various places I had code that would loop around
popping the head and dispatch it or waiting if the Queue was empty.

I refactored it in three steps:

 1. Use Optional instead of returning null. This allows you to simply chain an "ifPresent" and "orElse" lambda function.
 2. Move the wait into an iterator, so the iterator will return events for as long as the event queue is running.
 3. Move the loop into the event queue, and supply a lambda with what to do with each event. This also allowed me to make the iterator private to the event queue, improving the encapsulation.

These may sound like trivial changes, but it allowed me to cut the code down from something like:

{% highlight java %}
// event-loop:
while (running) {
    synchronized(queue) {
        event = queue.poll();
        if (event == null) {
            queue.wait();
        } else {
            dispatch(event);
        }
    }
}

// publish:
synchronized(queue) {
    queue.add(event);
    queue.notify();
}
{% endhighlight %}

to (all synchronization is internal to the queue):

{% highlight java %}
// event-loop:
queue.forEach(event -> dispatch(event));

// publish:
queue.add(event);﻿
{% endhighlight %}