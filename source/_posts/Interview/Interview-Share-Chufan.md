---
title: Interview Share Chufan
date: 2020-07-02 08:39:20
categories: Interview
tags:
---

import java.io.*;
import java.util.*;

/*

 
 You are provided with a set of APIs for reading an XML document. You’re tasked with designing and implementing an API to represent the hierarchical structure of XML. Your API should capture all the values found in an XML document, including tag names and texts.
 
 
 

<a>
  <b>
    <c>foo</c>
    <c></c>
  </b>
  <d>blah</d>
</a>


interface Tokenizer {
  Token nextToken();
}

interface Token {
  String value();
  TokenType type();
}

enum TokenType {
  BEGIN,
  END,
  TEXT,
}


 * Each call to tokenzer.nextToken() returns:
 * {
 *   value: 'a',
 *   type: 'BEGIN'
 * }
 * {
 *   value: 'b',
 *   type: 'BEGIN'
 * }
 * {
 *   value: 'c',
 *   type: 'BEGIN'
 * }
 * {
 *   value: 'foo',
 *   type: 'TEXT'
 * }
 * {
 *   value: 'c',
 *   type: 'END'
 * }
 * {
 *   value: 'c',
 *   type: 'BEGIN'
 * }
 * {
 *   value: 'c',
 *   type: 'END'
 * }
 * {
 *   value: 'b',
 *   type: 'END'
 * }
 * {
 *   value: 'd',
 *   type: 'BEGIN'
 * }
 * {
 *   value: 'blah',
 *   type: 'TEXT'
 * }
 * {
 *   value: 'd',
 *   type: 'END'
 * }
 * {
 *   value: 'a',
 *   type: 'END'
 * }

 
 
 */

// {a begin}, b begin, c begin, foo text, e end b end d begin blah text, d end, a end

"
<a>
   <b> 
     <c> text </c>
  
   </b>
   
"  
  
      a
    /   \
  b     d
  /      
c (foo)  


class TreeNode {
    String tag;
    String text;
    List<TreeNode> children;
}


a 0
  
b 1
  
c 2
  
d 1
  
m 2

a 3  
  
parent 

Map<String, String> fatherMap;

<a ,a>

<b, a>
<c, b>
  
<d, a>

<m, d>
  
previous node:

a begin

b begin 

a-> b

b -> 
  
c end : update previous b 

b end : update previus a

m begin: a -> m

m end: update previous a


stack:

a b c

stack top




public static TreeNode parseXml(Tokenizer t) {
    
    int level = 0;
  
    
    

      
    }
  
    

}

class Solution {
  public static void main(String[] args) {
    ArrayList<String> strings = new ArrayList<String>();
    strings.add("Hello, World!");
    strings.add("Welcome to CoderPad.");
    strings.add("This pad is running Java " + Runtime.version().feature());

    for (String string : strings) {
      System.out.println(string);
    }
  }
  
  
}




