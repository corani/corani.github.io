---
layout: post
title: "Java Generators"
modified: 2014-11-27 16:00:00 +0800
tags: [java,programming]
description: "In Java, Generators can be implemented using Iterators, however, those require a significant amount of boilerplate code, obscuring the meaning of the code. As a result, the pattern is not often used. Over the last couple of days, I've implemented a framework that makes creating Generators much easier."
image:
  feature: conveyor.jpg
  credit:  Unknown
  creditlink: 
comments: true
share:    true
---
A <a href="http://www.wikiwand.com/en/Generator_(computer_programming)" target="_BLANK">Generator</a> is a special routine that can be used to control the iteration behavior of a loop, however, instead of returning
all the values at once, a generator yields the values one at a time. This is useful when values take up a large amount of memory, or take a significant amount of time to compute. Using a generator, you can start
using the values immediately when they become available, instead of having to wait for all of them to be ready.

In Java, Generators can be implemented using Iterators, however, those require a significant amount of boilerplate code, obscuring the meaning of the code. As a result, the pattern is not often used. Over the last
couple of days, I've implemented a framework that makes <a href="https://github.com/corani/JavaGen" target="_BLANK">creating Generators</a> much easier. The framework takes care of all the boilerplate code and gives
the user the familiar "yield" method.

Here are some examples of how the Generator can be used:

{% highlight java %}
	// 1
	for (Integer i : Range.of(0, 100)) {
		System.out.println(i);
	}
	
	// 2
	Generator.create(gen -> {
		Range.of(0, 10)
			.forEach(i -> gen.yield(i * i));
	}).forEach(System.out::println);

	// 3
	Downloader.of(listOfUrls)
		.forEach(page -> save(page));
{% endhighlight %}

Example one yields a number at a time and prints it. Example two nests generators. The inner-most generates one number at a time, while the outer-most squares them one at a time and finally prints them. This also
demonstrates the use of lambda functions. While these examples are trivial, the last example shows a more reasonable use-case. It takes a list of URLs and downloads the associated content one page at a time. Each page
is them saved. Alternatively, more actions could be chained, e.g. parsing the page, extracting all the links and adding those to the listOfUrls to be downloaded.

The base Generator class implements the Iterator and Iterable interfaces, so you can iterate over the content using the standard Java idioms such as the "for" keyword and the "forEach" functional method. Concrete
Generators need only implement the "run" method, as in the following example:

{% highlight java %}
public class Fibo extends Generator<Integer> {
	@Override
	public void run() {
		int a=0, b=1, c=1;
		yield(c);
		while (true) {
			yield(c);
			a=b; b=c;
		}
	}
}
{% endhighlight %}

This implements an infinite Generator for <a href="http://www.wikiwand.com/en/Fibonacci_number" target="_BLANK">Fibonacci numbers</a> (Each number is the sum of the preceding two numbers, e.i. 1, 1, 2, 3, 5, 8, 13, 21, ...)
The concrete Generator will do its work in a separate thread, that will be blocked after each call to "yield". When the user consumes a value, the Generator is unblocked and the next value is yielded. As you can see,
there is unnecessary boilerplate code and the algorithm is clear to read.