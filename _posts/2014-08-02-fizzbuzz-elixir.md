---
layout: post
title: "Fizzbuzz in Elixir"
modified: 2014-08-02 09:24:03 +0800
tags: [fizzbuzz, programming, elixir]
description: "Over the last week, I've started learning the exciting new Elixir language. Last night I was thinking about what Fizzbuzz would look like in Elixir, and couldn't fall asleep until I got it out of my head, so here it is."
image:
  feature: elixir.jpg
  credit:  David Monniaux
  creditlink: http://commons.wikimedia.org/wiki/User:David.Monniaux
comments: true
share:    true
---
Over the last week, I've started learning the exciting new <a href="http://elixir-lang.org/getting_started/1.html" target="_BLANK">Elixir language</a>.
This is a language that combines the best of Ruby (an easy to read syntax) with the best of Erlang (Low cost scalability and distributability and hot
code swapping)

Last night I was thinking about what Fizzbuzz would look like in Elixir, and couldn't fall asleep until I got it out of my head, so here it is:

{% highlight ruby %}
Enum.map(1..100, fn
  _n when rem(_n, 15) == 0 -> "Fizzbuzz"
  _n when rem(_n,  5) == 0 -> "Buzz"
  _n when rem(_n,  3) == 0 -> "Fizz"
   n -> n
end)
{% endhighlight %}

It maps over the range of numbers from 1 to 100, and invokes a lambda function for each number, then collects the results in a list. The lambda has
four forms, the first three guarded with a "remainder" expression, the last one a catch-all that simply returns the number.

Much like languages such as Haskell and Erlang (on which this is based), Elixir works with pattern matching. This means each function can have
multiple implementations (forms), and the compiler/runtime will pick the right one based on the pattern of the invocation. For example: If "n" is
15, the first implementation will be picked, since the remainder of 15 over 15 is 0. This implementation simply returns "Fizzbuzz".

You can do the same with named functions, as you can see in this example that will (recursively) iterate over a list:

{% highlight ruby %}
def loop([]), do: []

def loop([h|t] do
  [do_something(h) | loop(t)]
end
{% endhighlight %}

The first form will be invoked when the list is empty, and simply returns an empty list. In other cases, the second form will be invoked, which splits
the head off from the list, does something with it, and concatenates it to the result of the recursive invocation of the function with the tail of the
list.
