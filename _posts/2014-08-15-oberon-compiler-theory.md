---
layout: post
title: "Oberon compiler theory"
modified: 2014-08-15 13:28:03 +0800
tags: [programming, oberon, compiler, llvm]
description: "Let's start with an overview of how compilation works. We start off with the source code, the code typed in by the user, in some text file. This looks, depending on the programming language, more or less similar to English language prose. Eventually we'll want to get machine code out of it, so the computer hardware can understand it."
image:
  feature: oberon.png
  credit:  Dani&euml;l Bos
  creditlink: http://blog.loadingdata.nl/daniel-bos/
comments: true
share:    true
---
Last night I finished writing the Lexer for my <a href="/tags/#oberon" target="_BLANK">Oberon compiler</a> project, and started working on the Parser. I'd
like to try documenting my progress on my blog here, and maybe share some of the things I learn along the way.

**What is a Lexer**

Let's start with an overview of how compilation works. We start off with the source code, the code typed in by the user, in some text file. This looks,
depending on the programming language, more or less similar to English language prose. Eventually we'll want to get machine code out of it, so the
computer hardware can understand it.

The first step in this process is called *Lexing*. It takes the text that was typed in by the user, chops it into small pieces (*Tokens*), and assigns categories to
each piece. Examples of these categories are: "Number", "String", "Keyword", "Operator", "Bracket", etc.

**Next step: Parser**

The second step is called *Parsing*. It reads the Tokens following the language syntax, and issues warnings or errors when it encounters unexpected Tokens. The
syntax of a language is usually expressed in <a href="http://www.wikiwand.com/en/Extended_Backus%E2%80%93Naur_form" target="_BLANK">EBNF form</a>. For example:

{% highlight ebnf %}
Module     = MODULE ident ";" [ImportList] DeclSeq [BEGIN StatementSeq] END ident ".".
ImportList = IMPORT [ident ":="] ident {"," [ident ":="] ident} ";".
{% endhighlight %}

The meaning of these syntax rules are:

There is something called a "Module" in this language, which starts with the keyword "MODULE" followed by an identifier (a name) and a semicolon. This module
further optionally contains an "ImportList", followed by a "DeclSeq", possibly the keyword "BEGIN" followed by a "StatementSeq" and finally the keyword "END"
followed by another identifier and a period.

Try to figure out for yourself what the second statement "ImportList" means (hint: the curly braces indicate that what's included within them can be repeated
zero or more times)

Following these language rules, the Parser constructs a new tree-like data structure called an *Abstract Syntax Tree* (AST). This transforms the original program
(in the form of Tokens) into a Tree, with each symbol (on the left of the EBNF forms) as a Node, and the stuff on the right as the properties and branches of
that node.

For example, the "Module" Node will have a property "ident" and a branch for the "ImportList" and "StatementSeq" (I'm skipping the "DeclSeq" here, as that
one is a bit more complicated). The ImportList will have a list of (key, value) pairs, where some of the values may be empty.

**Semantic Analysis**

The next steps includes *Semantic Analysis* of the AST. In this step you will verify the semantics of the source program. For example, if you're building a
compiler for the English language, the Parser checks if a sentence follows the language rules. The Semantic Analyser would check if the sentence actually
makes sense (<a href="http://www.wikiwand.com/en/Jabberwocky" target="_BLANK">Jabberwocky</a>) Usually in the same step you build up the symbol table, a
table that contains all variables, constants and methods that are visible from each Node, and verify that all identifiers in the AST can be resolved.

**Intermediate Representation**

Since I'm building a front-end compiler, my next step will be generating the *Intermediate Representation* (IR) for LLVM. This is a kind of Assembly Language
for an imaginary architecture that LLVM understands. All optimizations and further machine-code generation is handled by LLVM based on this *IR*. This is shows
the power of splitting a compiler into a front-end, an optimizer and a back-end.

I, as a front-end compiler developer, only need to know about the language I'm trying to compile and the LLVM Intermediate Representation. Other developers,
way smarter than me, can take that IR and transform it into something efficient, and still other developers take the optimized IR and translate it into
machine code for the various different platforms.