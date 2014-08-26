---
layout: post
title: "Oberon Anagrams"
modified: 2014-08-26 16:35:53 +0800
tags: [programming, oberon, anagram, puzzler]
description: ""
image:
  feature: anagrams.jpg
  credit:  Unknown
  creditlink: 
comments: true
share:    true
---
To get a feel of what programming in Oberon-2 is like, I installed the <a href="http://spivey.oriel.ox.ac.uk/corner/Oxford_Oberon-2_compiler" target="_BLANK">Oxford Oberon-2 compiler</a> and
wrote a simple Anagram application.

The simplest way to find if two words are anagrams is to sort the characters in each of them and then compare them. The application I wrote allows you to add words to a "dictionary".
Internally, for each word the sorted characters are used as a hash, words with the same hash are put in the same bucket. When we later ask for the anagrams of a search word, we simply
get the hash and return all the words in the corresponding bucket.

You can find my first attempt on <a href="https://gist.github.com/corani/8f29689d3a5fa05a6948" target="_BLANK">GitHub</a>. You'll notice there is a lot of code for such a simple application,
and that much of it is pointer manipulation. I had to implement a Hashmap and a Vector from scratch and deal with raw, fixed-length character arrays. Obviously not a very pleasant experience.

It is clear that what Oberon sorely needs is a standard library. <a href="https://github.com/corani/oberon-stdlib" target="_BLANK">So I started writing one</a>. So far I've implemented a
basic String, Vector and Map. This allowed me to write a <a href="https://gist.github.com/corani/21017c1b02e43a7cb123" target="_BLANK">much nicer version</a>.