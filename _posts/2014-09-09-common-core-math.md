---
layout: post
title: "Common Core Math"
modified: 2014-09-09 13:28:53 +0800
tags: [common core,math,programming]
description: "When I watched it, and especially after hearing others comment on it, I was surprised at how much sense it makes. Most people, however, are baffled by the terminology used and the strange ways of solving such a simple problem."
image:
  feature: common-core.jpg
  credit:  Unknown
  creditlink: 
comments: true
share:    true
---
The video below has been doing the round, showing how ludicrous and overly complicated the Common Core Mathematics are. Go ahead and have a look at it before reading on, it's only 80 seconds.
(For those in China, I put up a <a href="http://v.youku.com/v_show/id_XNzc3NzIzMjky.html" target="_BLANK">mirror on Youku</a>)

<iframe width="640" height="360" src="//www.youtube.com/embed/g2QGiGqz-xs" frameborder="0" allowfullscreen></iframe>

When I watched it, and especially after hearing others comment on it, I was surprised at how much sense it makes. Most people, however, are baffled by the terminology used and the strange
ways of solving such a simple problem. This got me thinking, *why* it made sense to me. Let's start with some of the terminology:

**Base-10** I, as a software engineer, deal with Base-2 (Binary), Base-16 (Hexadecimal) and even Base-64 as opposed to Base-10 (Decimal) all the time. They're fundamental in the way
computers work, and in how we deal with them.

**Decomposing** This is, in computer science, the fundamental technique of breaking a large problem down into smaller and smaller pieces, until you reach components that can either be found
in a library of existing functions, or can be solved within a couple of hours. Software engineering *is* decomposing, solving the parts and assembling them back together.

And for the technique showed graphically to solve the problem: These are exactly the basic binary-tree manipulations that are used in many computer algorithms: Splitting, Rotating and Merging.
To illustrate this, see the awesome drawing below. This drawing looks almost identical to the one in the video, but more uniform. Operations are shown in a circle, like &oplus; and numbers
are shown as "leafs" of the (upside-down) tree.

<img src="/images/split-rotate-merge.png">

Step one is to "split" the leaf "6" by replacing it with a new &oplus; operation which result equals to "6". There are many such operations, in this example we are working towards "10", so we
choose "1" and "5".

Step two is to "rotate" the tree around the our newly created &oplus; operation. This will move the operation up, making it the "root" of the tree. We do this using four sub-steps:
a. Disconnect the "right" branch of the topmost operation.
b. Move the leaf from the "left" branch of the new operation to the "right" branch of the topmost one.
c. Connect the "left" branch of the new operation to the topmost one.
d. "Pull" the new operation up, above the previously topmost one.

Step three (and four) "merge" branches, by solving them. We first solve "9 + 1" and replace the operation for a new leaf containing the result: "10". We then solve "10 + 5" and again
replace the operation for a new leaf "15". This is how we reach our solution.

Without having looked at how to solve bigger numbers using the Common Core method, I came up with the following way that follows the same principle (I'm not going to draw it):

{% raw %}
308 + 457 = 3&#x7c;0&#x7c;8 + 4&#x7c;5&#x7c;7 = 3&#x7c;0&#x7c;(8+7) + 4&#x7c;5&#x7c;0 = 3&#x7c;0&#x7c;(8+(2+5)) + 4&#x7c;5&#x7c;0 = 3&#x7c;0&#x7c;((8+2)+5) + 4&#x7c;5&#x7c;0 = 3&#x7c;1&#x7c;5 + 4&#x7c;5&#x7c;0 = 3&#x7c;(1+5)&#x7c;5 + 4&#x7c;0&#x7c;0 = 3&#x7c;6&#x7c;5 + 4&#x7c;0&#x7c;0 = (3+4)&#x7c;6&#x7c;5 + 0&#x7c;0&#x7c;0 = 7&#x7c;6&#x7c;5 + 0&#x7c;0&#x7c;0 = 765
{% endraw %}

Basically we first split each number into decimal boxes, then solve each box following the split => rotate => merge algorithm outlined above.

I think this clearly shows that the Common Core Mathematics were designed by a programmer, not by an educator, and I'm dubious about their intentions. I see three possible reasons:
 1. Someone thinks that programmers are better mathematicians than, well, a few millennia of mathematical practice;
 2. Someone is trying to train code monkeys;
 3. Someone is under the misguided impression that *anyone* can learn to become a software engineer.

I'm not sure which of these is worse...