---
layout: post
title: "Oberon report"
modified: 2014-08-14 13:38:03 +0800
tags: [programming, oberon, compiler]
description: "Some of you may know I was working on implementing an Oberon-2 compiler from scratch in Python. While I had a large part of the front-end (lexing, parsing, symbol-table, AST, analyzer, etc) working for most of the language, the back-end turned out to be ... challenging."
image:
  feature: oberon.png
  credit:  Dani&euml;l Bos
  creditlink: http://blog.loadingdata.nl/daniel-bos/
comments: true
share:    true
---
Some of you may know I was working on implementing an <a href="http://www.wikiwand.com/en/Oberon-2_(programming_language)" target="_BLANK">Oberon-2</a>
compiler from scratch in Python. While I had a large part of the front-end (lexing, parsing, symbol-table, AST, analyzer, etc) working for most of the
language, the back-end turned out to be ... challenging.

A few weeks ago I came across the <a href="http://llvm.org/docs/index.html" target="_BLANK">LLVM programming manual</a> and tutorials and was surprised by
the high quality and depth of the materials. After reading through some of the documents and implementing and extending the toy language from the tutorial
(and bludgening it into shape), I decided to pick up my Oberon project again, in modern C++ this time.

**Why Oberon?**
When I first started writing code, it was in BASIC (on the <a href="http://www.wikiwand.com/en/Philips_P2000" target="_BLANK">Philips P2000-T</a>). That was,
I can hardly believe it, a quarter of a century ago. I went through various platforms and various flavours of BASIC after that, but when I seriously started
programming in school, the language that was taught was Pascal.

Although today I write most of my code in Java and C++ (and Scheme, but that's a different story), I have fond memories of writing Turbo/Borland Pascal. It
had a great IDE (those were still the DOS days), blazingly fast compilation and build times and was very easy to use. It is a real pity that, eventually, it
lost from the C-like family of languages.

So when I began thinking about writing my own compiler, Pascal was a natural choice. Pascal, however, had its idiosyncrasies. For example, the semicolon was
a statement *separater*, not a statement *terminator*. This ment that the last statement in a block *couldn't* have a semicolon. And, although Borland added
first Units and later Objects, it was purely procedural, with no separate compilation units.

First Module-2 and subsequently Oberon-2 fixed this, while at the same time making the language much more regular. In fact, the entire language syntax can be
expressed in just 33 eBNF forms. This makes it an easy to lex and parse language.

**What's next?**
I'll try to share some more regular status updates here, and put the code up on Github when I get the chance. Last night I wrote most of the lexer, in my
next post I'll share some more details on the design. Commonly the lexer is very thin, it strips comments and divides the rest of the code into identifiers,
literals (numbers, strings, etc) and characters. I like my lexers to do a little more work and basically give me back as much information as possible, without
depending on some external state or model. More on that in the next update!