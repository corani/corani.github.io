---
layout: post
title: "Sorted Linked List"
modified: 2014-06-09 22:04:05 +0800
tags: [programming,linked list,search,insert]
image:
  feature: linked-list.jpg
  credit:  Unknown
  creditlink:
comments: true
share:    true
---
I spent some time today coming up with a simple algorithm for traversing of; and inserting in a sorted linked list. I'm posting this here in case
I ever need it again.

{% highlight java %}
public class Container {
    private static class Node {
        int key;
        WeakReference wr;
        Node next;

        Node() {
            key  = 0;
            next = this;
        }

        Node(int key, Object o, Node next) {
            this.key  = key;
            this.wr   = new WeakReference(o);
            this.next = next;
        }
    }

    public void add(int key, Object o) {
        Node node = head;
        while (node.next.key < key && node.next != head) {
            node = node.next;
        }

        // Don't overwrite existing values, to avoid an object allocation
        if (node.next.key != key) {
            node.next = new Node(key, o, node.next);
        }
    }

    public Object find(int key) {
        Node node = head;
        while (node.next.key < key && node.next != head) {
            node = node.next;
        }

        Object o = null;
        if (node.next != head && node.next.key == key
                && (o = node.next.wr.get()) == null) {
            // Object GCd, remove the node
            node.next = node.next.next;
        }
        return o;
    }

    private Node head = new Node();
}
{% endhighlight %}

Note that I'm using a sentinel Node at the head. This avoids a lot of null checks and makes the algorithm much simpler. When adding a Node, it's
always added _after_ something and _before_ something, even if those two happen to be the same sentinel. By the same logic, when removing a Node,
there is always a _previous_ and a _next_ node, so we simply link them. In all these cases we don't need to think about nulls.
