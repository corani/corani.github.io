---
layout: post
title: "Object inheritance"
modified: 2014-06-18 21:31:50 +0800
tags: [programming,object,class]
image:
  feature: objects.jpg
  credit:  Unknown
  creditlink: 
comments: true
share: true
---
At my dayjob I write most of my code using a somewhat esoteric language. This language supports Objects, but has no Classes. To create an Object,
you use a constructor method that returns a new instance of the Object. Think: a function that returns an anonymous function.

I recently came to realize that this model allows for all kinds of awesomeness. For example I was refactoring some code, and found that a large
piece of code was duplicated between two separate object trees (no common ancesters). Since I'm working with Objects, instead of Classes, I am
able to inject an intermediate object in the inheritance chain.

I realize this may be a bit hard to understand, so I simulated this using JavaScript. This is obviously a kludge in JavaScript, but it works, and
helps to illustrate what I'm talking about. In the language I'm using it is much more elegant.

First a utility method that will create an empty Child object that inherits from a given parent, and then extends it with the Child methods;

{% highlight javascript %}
function inherit(parent, obj) {
    Child = function() {};
    Child.prototype = parent;
    instance = new Child();
    instance.prototype = parent;
    for (var i in obj) {
        instance[i] = obj[i];
    }
    return instance;
}
{% endhighlight %}

Two example base classes. Note that I'm mirroring the constructor-method idiom.

{% highlight javascript %}
function createFoo() {
    return inherit(null, {
        doFoo: function() {
            return "some";
        }
    });
}

function createBar() {
    return inherit(null, {
        doBar: function() {
            return "other";
        }
    });
}
{% endhighlight %}

Then the intermediate object, we'll insert this into both (separate) inheritance trees.

{% highlight javascript %}
function createIntermediate(parent) {
    return inherit(parent, {
        stuff: false,
        setStuff: function(stuff) {
            this.stuff = stuff;
        },
        getStuff: function() {
            return this.stuff;
        }
    });
}
{% endhighlight %}

And finally the two child-classes. Originally these inherited directly from Foo and Bar and duplicated the get/setStuff methods.

{% highlight javascript %}
function createMyFoo() {
    foo = createFoo();
    return inherit(createIntermediate(foo), {
        moreFoo: function() {
            return "more";
        }
    });
}

function createMyBar() {
    bar = createBar();
    return inherit(createIntermediate(bar), {
        doBaz: function() {
            return "baz";
        }
    });
}
{% endhighlight %}

By using objects instead of classes, it is possible to build the inheritance chain dynamically, which allows you to separate duplicated functionality
in orthogonal inheritance trees. Pretty cool!
