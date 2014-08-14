---
layout: post
title: "Oberon report"
modified: 2014-08-14 13:38:03 +0800
tags: [programming, oberon, compiler]
description: "I came across a cool website today that provides programming challenges in several languages. This is a great resource for preparing for a technical interview. "
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

I'll try to share some more regular status updates here, and put the code up on Github when I get the chance. Last night I wrote most of the lexer, in my
next post I'll share some more details on the design. Commonly the lexer is very thin, it strips comments and divides the rest of the code into identifiers,
literals (numbers, strings, etc) and characters. I like my lexers to do a little more work and basically give me back as much information as possible, without
depending on some external state or model. More on that in the next update!