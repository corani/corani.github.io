---
layout: post
title: "Programming challenges"
modified: 2014-08-14 13:08:03 +0800
tags: [programming, java]
description: "I came across a cool website today that provides programming challenges in several languages. This is a great resource for preparing for a technical interview. "
image:
  feature: reverse-sentence.jpg
  credit:  Dani&euml;l Bos
  creditlink: http://blog.loadingdata.nl/daniel-bos/
comments: true
share:    true
---
I came across a <a href="https://oj.leetcode.com/" target="_BLANK">cool website</a> today that provides programming challenges in several languages. This
is a great resource for preparing for a technical interview.

Here's my answer to the first assignment I clicked on (given a string like "the sky is blue", reverse it into "blue is sky the". Leading and trailing
whitespace should be removed, concurrent whitespace should be collaped into a single space):

{% highlight java %}
String[] parts = s.trim().split("\\s+");
String out = "";
if (parts.length > 0) {
    for (int i = parts.length - 1; i > 0; i--) {
        out += parts[i] + " ";
    }
    out += parts[0];
}
return out;
{% endhighlight %}

I'm splitting on the regex for one-or-more whitespace, this takes care of multiple spaces/tabs/newlines/etc in the input. Since the input could have
leading/trailing whitespace, which would result in empty matches, I first trim the input string.

Now there could be three possibilities:
1. The input is empty, return an empty string directly.
2. The input contains only one part, return that part.
3. The input contains multiple parts, reverse the order, making sure we don't end with a trailing space.

Obviously this is not the fastest or most memory efficient way to solve the problem, but optimizations should only be done when they are needed. Readable
code is usually more important than efficient code.

*How to make it efficient?*

- Use a StringBuilder to concatenate the string parts, instead of concatenating strings directly. This will (I assume) build something like a linked-list of
  string parts, and only allocate the new string when you need it, instead of on each concatenation.
- Iterate over the string, instead of using trim/split. Store the index of the last character in the word, when you find the first character, copy the
  substring to the output string.
- Instead of using substring, insert the word-characters directly in the StringBuilder. Assuming they're using a linked-list or tree, this could be a whole
  last faster.