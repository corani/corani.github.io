---
layout: post
title: "Swift Programming Language"
modified: 2014-06-09 22:04:05 +0800
tags: [programming,apple,swift,objective-c]
image:
  feature: programming.jpg
  credit:  Alexandre Buisse
  creditlink: http://www.alexandrebuisse.org/
comments: true
share:    true
---
When Apple announced their new <a href="https://developer.apple.com/library/prerelease/ios/documentation/Swift/Conceptual/Swift_Programming_Language/BasicOperators.html#//apple_ref/doc/uid/TP40014097-CH6-XID_73" target="_BLANK">
Swift Programming Language</a>, I had to check it out. Initially it looks good, much better than the archaic mess that is Objective-C. After reading through the online
documentation, however, I have a "few" comments.

*Comment 1*
Hmmm.. great idea Apple, redefining the modulo "%" operator as a remainder, which also works on floats.

{% highlight java %}
8 % 2.5 = 0.5
{% endhighlight %}

In any language I've ever seen the following holds:

{% highlight java %}
  A / B = C
  A % B = D
  (B * C) + D = A
{% endhighlight %}

But in Swift this works differently for integers and floats.

*Comment 2*
Also, why didn't you get rid of "&&" and "||" and use "and" and "or" instead, like Python does? This increases the readability and reduces the risk of mixing them up
with the binary "and" and "or".

*Comment 3*
Argh! Operator overloading :-( and making up your own operators :-(

*Comment 4*
And they muddied Generics even more. Behold an example from the official documentation:

{% highlight java %}
func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, anotherContainer: C2) -> Bool {
  //...
}
{% endhighlight %}

*Comment 5*
WTF, you can assign to "self" (this) from within an instance method?

*Comment 6*
And open classes through the use of extensions and protocols. And the canonical example in the documentation: let's add a bunch of functions to numbers.

*Comment 7*
Built-in support for lazy initializers and observers for properties. I'm beginning to suspect they just put everything they could think of in this language...
They're certainly not followers of the "less is more" principle!

*Comment 8*
They're mixing up closures, function references and lambda's... And many, many ways to write the same code. From the document:

{% highlight java %}
func reverse(s1: String, s2: String) -> Bool {
    return s1 > s2
}
sort(names, reverse)
sort(names, { (s1: String, s2: String) -> Bool in return s1 > s2 })
sort(names, { s1, s2 in return s1 > s2 })
sort(names, { s1, s2 in s1 > s2 })
sort(names, { $0 > $1})
sort(names, >)
sort(names) { $0 > $1 }
{% endhighlight %}

(That last one is no mistake, you can append a lambda to a function, and it'll be passed as the last argument)

*Comment 9*
Seriously?

{% highlight java %}
switch point {
    case let (x, y) where x == y:
        // ...
}
{% endhighlight %}

*Comment 10*
*Seriously?*

{% highlight java %}
enum SomeEnum {
    Option1(Int, Int),
    Option2(String)
}
switch someEnum {
    case .Option1(let x1, let x2):
        ;; ...
    case .Option2(let s)
        ;; ...
}
{% endhighlight %}

*Comment 11*
**Seriously?**

{% highlight java %}
Any thing = 1.1
switch thing {
    case let d as Double where d > 1.0:
        ;; ...
}
{% endhighlight %}

*Comment 12*
They do Automatic Reference Counting, but no proper garbage collection. I.e. islands-of-reference can't be garbage collected. You need to handle this manually by
using weak references.

An island-of-refence is:
{% highlight java %}
A -> B
B -> A
{% endhighlight %}
but there are no external references to either A or B. It looks like they were so busy adding unneeded features they had no time to implement proper garbage
collection...

*Comment 13*
Exponents and decimals in hexadecimal literals? Sure!

{% highlight java %}
0xC.3p0
{% endhighlight %}
is clear for anyone... right? (It's 12.1875. Apparently)?

*Update*
Here's good discussion on <a href="http://stackoverflow.com/questions/24101718/swift-performance-sorting-arrays" target="_BLANK">Stackoverflow</a> about the performance of Swift.
Basically, it's 100x slower than Java, and 400x slower than C++. Even PyPy turns out to be an order of magnitude faster...

With -O1 Swift is about 1000x slower than good-old C, only with -Ofast is it getting comparable performance -- but in that case all the checks that make Swift safe are turned off.
With -Ofast a simple loop takes 5 machine instructions, with -O3 it takes almost 100, with 26 subroutine calls...
