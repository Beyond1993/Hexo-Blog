---
title: Java-HashMap
date: 2017-09-28 16:44:57
categories: Java
tags:
---

Hash Map 是工作和面试中非常常见的数据结构。

如何自己实现Hash Map也是面试中的必考题。
要自己实现HashMap, 先必须要理解Hash的实现原理。

<!-- more -->
1. 数组实现
MyHTInterface.java
```java
/**
 * 08722 Data Structures for Application Programmers.
 *
 * Homework Assignment 4
 * HashTable Implementation with linear probing
 *
 * A simple HashTable interface that takes lowercase String values.
 * Assumption is that clients will always insert lowercase values.
 *
 * Do not change anything in this interface
 *
 * @author Terry Lee
 */
public interface MyHTInterface {

    /**
     * Inserts a new String value (word).
     * Frequency of each word to be stored too.
     * @param value String value to add
     */
    void insert(String value);

    /**
     * Returns the size, number of items, of the table.
     * @return the number of items in the table
     */
    int size();

    /**
     * Displays the values of the table.
     * If an index is empty, it shows **
     * If previously existed data item got deleted, then it should show #DEL#
     */
    void display();

    /**
     * Returns true if value is contained in the table.
     * @param key String key value to search
     * @return true if found, false if not found.
     */
    boolean contains(String key);

    /**
     * Returns the number of collisions in relation to insert and rehash.
     * When rehashing process happens, the number of collisions should be properly updated.
     *
     * The definition of collision is "two different keys map to the same hash value."
     * Be careful with the situation where you could overcount.
     * Try to think as if you are using separate chaining.
     * "How would you count the number of collisions?" when using separate chaining.
     * @return number of collisions
     */
    int numOfCollisions();

    /**
     * Returns the hash value of a String.
     * @param value value for which the hash value should be calculated
     * @return int hash value of a String
     */
    int hashValue(String value);

    /**
     * Returns the frequency of a key String.
     * @param key string value to find its frequency
     * @return frequency value if found. If not found, return 0
     */
    int showFrequency(String key);

    /**
     * Removes and returns removed value.
     * @param key String to remove
     * @return value that is removed
     */
    String remove(String key);

}
```

MyHashTable.java

```java
/**
 * 08722 Data Structures for Application Programmers.
 *
 * Homework Assignment 4
 * HashTable Implementation with linear probing
 *
 * Andrew ID: wfeng1
 * @author Wei Feng
 */
public class MyHashTable implements MyHTInterface {

    // TODO implement constructor with no initial capacity

    // TODO implement constructor with initial capacity

    // TODO implement required methods
    
    /**
     * Instead of using String's hashCode, you are to implement your own here.
     * You need to take the table length into your account in this method.
     *
     * In other words, you are to combine the following two steps into one step.
     * 1. converting Object into integer value
     * 2. compress into the table using modular hashing (division method)
     *
     * Helper method to hash a string for English lowercase alphabet and blank,
     * we have 27 total. But, you can assume that blank will not be added into
     * your table. Refer to the instructions for the definition of words.
     *
     * For example, "cats" : 3*27^3 + 1*27^2 + 20*27^1 + 19*27^0 = 60,337
     *
     * But, to make the hash process faster, Horner's method should be applied as follows;
     *
     * var4*n^4 + var3*n^3 + var2*n^2 + var1*n^1 + var0*n^0 can be rewritten as
     * (((var4*n + var3)*n + var2)*n + var1)*n + var0
     *
     * Note: You must use 27 for this homework.
     *
     * However, if you have time, I would encourage you to try with other
     * constant values than 27 and compare the results but it is not required.
     * @param input input string for which the hash value needs to be calculated
     * @return int hash value of the input string
     */
    private int size;
    
    private int length;
    
    private static final DataItem DELETED = new DataItem("-1");
    
    private DataItem[] hashArray;
    
    //private double loadFactor = 0.0;
    
    public MyHashTable() {
        hashArray = new DataItem[10];
        this.size = 0;
        this.length = 10;
    }
    
    public MyHashTable(int size) {
        if (size <= 0) {
            throw new RuntimeException("size less or equal to zero");
        }
        hashArray = new DataItem[size];
        this.size = 0;
        this.length = size;
    }
    
    private int hashFunc(String input) {
        String str = input.toLowerCase();
        //double result = 0.0;
        int result = 0;
        int len = str.length();
        StringBuilder sb = new StringBuilder(input);
        int var = (sb.charAt(0) - 'a' + 1);
        for (int i = 0; i < len - 1; i++) {
            var = var * 27 + (sb.charAt(i+1) - 'a' + 1);
            var = var % this.length;
            if (i == len - 2) {
                result = var;
            } else {
                result += var;
            }
            //result = result + ( sb.charAt(i) - 'a' + 1) * Math.pow(27, len - 1 - i); 
        }
        return result % this.length;
    }
   

    /**
     * doubles array length and rehash items whenever the load factor is reached.
     */
    private void rehash() {
        
        int oldLength = this.length;
        int length = getNewLength(this.length);
        
        this.length = length;
        
        DataItem[] oldHashArray = hashArray;
        hashArray = new DataItem[length];
        this.size = 0;
        for (int i = 0; i < oldLength; i++) {
            if (oldHashArray[i] != null && oldHashArray[i] != DELETED ) {
                for (int j = 0; j < oldHashArray[i].frequency; j++) {
                    insert(oldHashArray[i].value);
                }
            }
        }
        System.out.println("Rehashing " + this.size + " items, new size is " + this.length);
    }

    /**
     * private static data item nested class.
     */
    private static class DataItem {
        /**
         * String value.
         */
        private String value;
        /**
         * String value's frequency.
         */
        private int frequency;

        // TODO implement constructor and methods
        DataItem(String k) {
            value = k;
            frequency = 0;
        }
    }
    
    @Override
    public String remove(String key) {
        int hashVal = hashFunc(key);
        while (hashArray[hashVal] != null) {
            if (hashArray[hashVal].value.equals(key)) {
                String result = hashArray[hashVal].value;
                hashArray[hashVal] = DELETED;
                this.size--;
                return result;
            }
            hashVal++;
            hashVal = hashVal % hashArray.length;
        }
        return null;
    }
    
    @Override
    public void insert(String value) {
        //value = value.toLowerCase();
        if (value == null || value.isEmpty()) {
            return;
        }
        if (!isAllLowerCase(value)) {
            return;
        }
        if (contains(value)) {
            int hashVal = hashFunc(value);
            while( hashArray[hashVal] != null) {
                if (hashArray[hashVal].value.equals(value)) {
                    hashArray[hashVal].frequency++;
                }
                hashVal++;
                hashVal = hashVal % this.length;
            }
            return;
        }
        this.size++;
        
        DataItem item = new DataItem(value);
        item.frequency = 1;
        int hashVal = hashFunc(value);
        while(hashArray[hashVal] != null && (hashArray[hashVal] != DELETED)) {
            hashVal++;
            hashVal = hashVal % this.length;
        }
        
        hashArray[hashVal] = item;
        
        double loadFactor = getLoadFactor();
        
        if (loadFactor > 0.5) {
            rehash();
        }
    }

    @Override
    public int size() {
        return this.size;
    }

    @Override
    public void display() {
        for (int i = 0; i < this.length; i++) {
            if (hashArray[i] == null) {
                System.out.print("** ");
            } else if (hashArray[i] == DELETED ) {
                System.out.print("#DEL ");
            } else {
                System.out.print("[" + hashArray[i].value + ", " + hashArray[i].frequency + "] ");
            }
        }
        System.out.println();
    }

    @Override
    public boolean contains(String key) {
        int hashVal = hashFunc(key);
        while( hashArray[hashVal] != null) {
            if (hashArray[hashVal].value.equals(key)) {
                return true;
            }
            hashVal++;
            hashVal = hashVal % this.length;
        }
        return false;
    }

    @Override
    public int numOfCollisions() {
        
        String[] keys = new String[this.size];
        
        int k = 0;
        for (int i = 0; i < this.length; i++) {
            if (hashArray[i] != null && hashArray[i] != DELETED ) {
                keys[k] = hashArray[i].value;
                k++;
            }
        }
        
        DataItem[] hashArray1 = new DataItem[this.length];
        int numberOfCollisions = 0;
        for (int i = 0; i < keys.length; i++) {
            DataItem newItem = new DataItem(keys[i]);
            
            int hashVal = hashFunc(keys[i]);
            
            if (hashArray1[hashVal] == null) {
                hashArray1[hashVal] = newItem;
            } else {
                numberOfCollisions++;
            }
        }
        return numberOfCollisions;
    }

    @Override
    public int hashValue(String value) {
        return hashFunc(value);
    }

    @Override
    public int showFrequency(String key) {
        if (!isAllLowerCase(key)) {
            return 0;
        }
        int hashVal = hashFunc(key);
        while (hashArray[hashVal] != null) {
            if (hashArray[hashVal].value.equals(key)) {
                return hashArray[hashVal].frequency;
            }
            hashVal++;
            hashVal = hashVal % hashArray.length;
        }
        return 0;
    }

    
    
    private int getNewLength(int length) {
        length = length * 2;
        int i = length;
        while( !isPrime(i)) {
            i++;
        }
        return i;
    }
    
    private boolean isPrime(int a) {  
          
        boolean flag = true;  
  
        if (a < 2) {  
            return false;  
        } else {  
  
            for (int i = 2; i <= Math.sqrt(a); i++) {  
  
                if (a % i == 0) {  
  
                    flag = false;  
                    break;  
                }  
            }  
        }  
        return flag;  
    }
    private double getLoadFactor() {
        //System.out.println(this.size + "afas "+ this.length);
        double loadFactor = (double)this.size / this.length;
        //System.out.println("load is " + loadFactor);
        return loadFactor;
    }
    
    
    private boolean isAllLowerCase(String word) {
        StringBuilder sb = new StringBuilder(word);
        int len = sb.length();
        for (int i = 0; i < len; i++) {
            if (!(sb.charAt(i) >= 'a' && sb.charAt(i) <= 'z')) {
                return false;
            }
        }
        return true;
    }

    
}
```
myTest.java
```java
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class myTest {

    public static void main(String[] args) throws IOException {
        
        int size;
        System.out.print("Enter size of hash table (bigger than 0): ");
        size = getInt();
        MyHashTable theHashTable;
        if (size == 0) {
            theHashTable = new MyHashTable();
        } else {
            theHashTable = new MyHashTable(size);
        }

        theHashTable.insert("increase");
        theHashTable.insert("creeping");
        theHashTable.insert("everything");
        theHashTable.insert("ourselves");
        theHashTable.insert("himself");
        theHashTable.insert("finished");
        theHashTable.insert("seventh");
        theHashTable.insert("learned");
        theHashTable.insert("learned");
        theHashTable.insert("creeping");
        theHashTable.insert("receive");
        
        System.out.println("");
        System.out.println("Number of collisions: " + theHashTable.numOfCollisions());
        System.out.println("Number of items: " + theHashTable.size());
        System.out.println("");
        System.out.print("Table: ");
        theHashTable.display();
        
        String testValue = new String("finished");
        if (theHashTable.contains(testValue)) {
            System.out.println("Found: 'finished'");
        } else {
            System.out.println("Cannot find: 'finished'");
        }
        
        System.out.println("Frequency of 'learned': " + theHashTable.showFrequency("learned"));
        System.out.println("Frequency of 'Learned': " + theHashTable.showFrequency("Learned"));

    }
    
    public static int getInt() throws IOException {
        String s = getString();
        return Integer.parseInt(s);
    }
    
    public static String getString() throws IOException {
        InputStreamReader isr = new InputStreamReader(System.in);
        BufferedReader br = new BufferedReader(isr);
        String s = br.readLine();
        return s;
    }
}

```


2. 链表实现
```java
/**
 * @author Wei Feng wfeng1
 */
class MyHashMap<K, V> {
     
     private MyEntry<K,V>[] table;
     private int capacity= 57;
     
     static class MyEntry<K, V> {
         K key;
         V value;
         MyEntry<K,V> next;
     
         public MyEntry(K key, V value, MyEntry<K,V> next){
             this.key = key;
             this.value = value;
             this.next = next;
         }
     }
     
    @SuppressWarnings("unchecked")
    public MyHashMap(){
       table = new MyEntry[capacity];
    }

    /**
     * Method set value corresponding to key.
     * @param key key
     * @param value value
     */
    public void put(K key, V value){
       if(key == null) {
           return;    
       }
      
       int hash=hash(key);
       
       if(table[hash] == null){
            table[hash] = new MyEntry<K,V>(key, value, null);;
        } else {
           MyEntry<K,V> previous = null;
           MyEntry<K,V> current = table[hash];
           
           while(current != null){ 
               if(current.key.equals(key)){           
                   current.value = value;
                   return;
               }
               previous=current;
               current = current.next;
           }
              previous.next = new MyEntry<K,V>(key, value, null);;
        }
    }
 
    /**
     * Method returns value corresponding to key.
     * @param key key
     * @return value value
     */
    public V get(K key){
        int hash = hash(key);
        if(table[hash] == null){
         return null;
        }else{
         MyEntry<K,V> cur = table[hash];
         while(cur!= null){
             if(cur.key.equals(key))
                 return cur.value;
             cur = cur.next; //return value corresponding to key.
         }         
         return null;   //returns null if key is not found.
        }
    }
    /**
     * Method returns hashcode of key.
     * @param key
     * @return int hash code
     */
    private int hash(K key){
        return Math.abs(key.hashCode()) % capacity;
    }
    /**
     * Method returns whether contains the key.
     * @param key key
     * @return boolean whether
     */
    public boolean containsKey(K key) {
        int hash=hash(key);

        if(table[hash] == null){
            
            return false;
            
        }else{
           
           MyEntry<K,V> current = table[hash];
           
           while(current != null){ 
               if(current.key.equals(key)){           
                   return true;
               }
               current = current.next;
           }
           
        }
        return false;
    }
    @SuppressWarnings("unchecked")
    public void clear() {
        table = new MyEntry[capacity];
    }
}
``` 
 

3. 红黑树实现
