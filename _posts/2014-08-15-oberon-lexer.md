---
layout: post
title: "Oberon lexer"
modified: 2014-08-15 14:41:14 +0800
tags: [programming, oberon, compiler, lexer, c++]
description: "Since my previous post turned into an introduction to compiler theory, this report on writing the Lexer may be pretty short. But since I'd already created the header image, here we go anyway :-)"
image:
  feature: lexer.png
  credit:  Dani&euml;l Bos
  creditlink: http://blog.loadingdata.nl/daniel-bos/
comments: true
share:    true
---
Since my <a href="/oberon-compiler-theory/" target="_BLANK">previous post</a> turned into an introduction to compiler theory, this report on writing the
*Lexer* may be pretty short. But since I'd already created the header image, here we go anyway :-)

Let me start off with a stable link to my <a href="https://github.com/corani/oberon/tree/1cb27a86afecaa4c37dfecdffd2dc826f8b47b65" target="_BLANK">code on
GitHub</a>, shortly after checking in the Lexer.

As you can see in lexer.h, the Lexer class is constructed with an istream, so you can easily pass in a source file, and has just one (public) method:
"nextToken". Every time you call this method, it will read from the istream and constructs the correct Token. Each token consists of a Kind that specifies
the category, the location where the token can be found in the source code (line and column) and optionally a String, Int or Float value.

As I've mentioned previously, some Lexers only return one of the categories: Number, String, Identifier and Symbol. I like my Lexers to do a little more work
though. Symbols such as "+, -, *, /" are returned as Operator, others "=, #, <, >" are returned as Relation and still others have their own categories. At the
same time, Identifiers that are Keywords are returned as their respective Keyword directly. All of this makes the resulting Tokens easier to parse, and makes
the Parsing code much easier to read.

Compare for example:

{% highlight c++ %}
// 1
if (currentToken.kind != IDENTIFIER || currentToken.text != "IF") {
    throw parse_exception();
}
accept();
parseRelation();
if (currentToken.kind != IDENTIFIER || currentToken.text != "THEN") {
    throw parse_exception();
}
accept();
// ...

// 2
accept(IF);
parseRelation();
accept(THEN);
// ...
{% endhighlight %}

Looking at the cpp code, you'll notice that I'll still create an Identifier Token for each Identifier, but in the constructor I check if the Identifier is
one of the reserved keywords, in which case I automagically upgrade the Token to the respective keyword type. I do the same for sthe operators and relations
that use Identifiers instead of Symbols.

The rest of the code in "nextToken" is fairly straightforward. I skip any whitespace, and when I encounter a comment (Indicated with "(* ... *)") I skip it
and call nextToken recursively. The function "take" simply consumes the next character from the istream and updates the current location.