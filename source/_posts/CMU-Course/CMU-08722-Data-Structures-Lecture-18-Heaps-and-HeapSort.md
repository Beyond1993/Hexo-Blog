---
title: CMU-08722-Data-Structures-Lecture-18-Heaps-and-HeapSort
date: 2017-12-12 07:12:09
categories: CMU
tags:
---

手写一个heap 已经成了面试中必考题。

Heap 
1. 完全二叉树。
2. 用数组存储.
3. 节点i的左孩子 2i + 1， 右孩子 2i + 2
4. 节点i的parent (i - 1) / 2 
5. 插入一个元素, 先加到数组末尾，再往上爬
6. 删除一个元素，数组末尾的元素覆盖第一个元素，往下调整

```java
import java.util.Arrays;
import java.util.NoSuchElementException;

/**
 * 08722 Data Structures for Application Programmers.
 * Lecture 18 Heaps and Heap Sort
 *
 * A very simple and naive MaxHeap implementation
 *
 * @author Terry Lee
 */
public class MaxHeap implements MaxHeapInterface {
    /**
     * An array of Node.
     */
    private Node[] heapArray;
    /**
     * current size of heap array.
     */
    private int currentSize;

    /**
     * Constructs max heap with initial capacity.
     * precondition : initialCapacity > 0 and reasonably large enough
     * @param initialCapacity initial capacity of heap array
     */
    public MaxHeap(int initialCapacity) {
        heapArray = new Node[initialCapacity];
        currentSize = 0;
    }

    /**
     * Inserts a new key into a heap.
     * @param key key to insert
     * @return boolean to check whether it is successfully inserted or not
     */
    @Override
    public boolean insert(int key) {
        // array is full
        if (currentSize == heapArray.length) {
            return false;
        }

        // insert into the next available index position
        // to make sure the heap is complete
        heapArray[currentSize] = new Node(key);
        // then restore heap-order property
        percolateUp(currentSize);
        currentSize++;
        return true;
    }

    /**
     * Helper method to percolate up for insert operation.
     * to restore heap-order property of Max-Heap
     * @param index starting index
     */
    private void percolateUp(int index) {
        Node bottom = heapArray[index];
        int parent = (index - 1) / 2;

        // compare with parent and move it down if necessary
        while (index > 0 && heapArray[parent].key < bottom.key) {
            heapArray[index] = heapArray[parent]; // move node down
            index = parent; // move index upward
            parent = (parent - 1) / 2; // parent also moves upward
        }

        // and put bottom node into the right position
        heapArray[index] = bottom;
    }

    /**
     * Removes the highest priority key value (maximum key for max heap).
     * @return removed key
     * @throws NoSuchElementExcpetion when there is nothing to remove (empty heap)
     */
    @Override
    public int removeMax() {
        if (currentSize == 0) {
            throw new NoSuchElementException("The heap is empty");
        }

        Node root = heapArray[0];
        currentSize--;
        // massive promotion of the last node to the root
        // to make sure the heap is complete
        heapArray[0] = heapArray[currentSize];
        // actually removes the last node
        heapArray[currentSize] = null;
        // and restore heap-order property
        percolateDown(0);
        return root.key;
    }

    /**
     * Helper method to percolate down for remove max operation.
     * to restore the heap-order property of Max-Heap
     * @param index starting index
     */
    private void percolateDown(int index) {
        Node top = heapArray[index];
        // need to keep track of larger child
        int largerChild;

        // while there is at least left child
        // in other words, about the half of the nodes should be leaves
        while (index < (currentSize / 2)) {
            int leftChild = (index * 2) + 1;
            int rightChild = leftChild + 1; // or (index + 1) * 2;

            // check rightChild is within the boundary of current size
            // and compare left and right to find larger child
            if (rightChild < currentSize && heapArray[leftChild].key < heapArray[rightChild].key) {
                largerChild = rightChild;
            } else {
                largerChild = leftChild;
            }

            // no need to go down any more
            if (heapArray[largerChild].key <= top.key) {
                break;
            }

            // largerChild's node moves up
            heapArray[index] = heapArray[largerChild];
            // index goes down toward largerChild
            index = largerChild;
        }

        // finally, insert top node into the right position
        heapArray[index] = top;
    }

    /**
     * Returns the current size of heap array.
     * @return current size
     */
    public int size() {
        return currentSize;
    }

    /**
     * static nested class for Node.
     *
     * Free lunch: No references to left and right children
     * because heap is a complete binary tree
     */
    private static class Node {
        /**
         * Key of node.
         */
        private int key;

        /**
         * Constructs a new node with key.
         * @param k key
         */
        Node(int k) {
            key = k;
        }
    }

    /**
     * A few simple test cases.
     * Building a max heap and use it to sort in descending order (heap sort)
     * @param args arguments
     */
    public static void main(String[] args) {
        MaxHeap theHeap = new MaxHeap(20);

        // initial removeMax method should throw NoSuchElementException
        // theHeap.removeMax();

        // build a max heap
        theHeap.insert(24);
        theHeap.insert(5);
        theHeap.insert(45);
        theHeap.insert(10);
        theHeap.insert(45);
        theHeap.insert(56);
        theHeap.insert(17);
        theHeap.insert(24);
        theHeap.insert(19);
        theHeap.insert(20);

        // Now we can use the heap to sort (heap sort)
        int[] sorted = new int[theHeap.size()];
        for (int i = 0; i < sorted.length; i++) {
            sorted[i] = theHeap.removeMax();
        }

        System.out.println("Sorted in descending order: " + Arrays.toString(sorted));
    }

}
```


```cpp
// A C++ program to demonstrate common Binary Heap Operations
#include<iostream>
#include<climits>
using namespace std;
 
// Prototype of a utility function to swap two integers
void swap(int *x, int *y);
 
// A class for Min Heap
class MinHeap
{
    int *harr; // pointer to array of elements in heap
    int capacity; // maximum possible size of min heap
    int heap_size; // Current number of elements in min heap
public:
    // Constructor
    MinHeap(int capacity);
 
    // to heapify a subtree with root at given index
    void MinHeapify(int );
 
    int parent(int i) { return (i-1)/2; }
 
    // to get index of left child of node at index i
    int left(int i) { return (2*i + 1); }
 
    // to get index of right child of node at index i
    int right(int i) { return (2*i + 2); }
 
    // to extract the root which is the minimum element
    int extractMin();
 
    // Decreases key value of key at index i to new_val
    void decreaseKey(int i, int new_val);
 
    // Returns the minimum key (key at root) from min heap
    int getMin() { return harr[0]; }
 
    // Deletes a key stored at index i
    void deleteKey(int i);
 
    // Inserts a new key 'k'
    void insertKey(int k);
};
 
// Constructor: Builds a heap from a given array a[] of given size
MinHeap::MinHeap(int cap)
{
    heap_size = 0;
    capacity = cap;
    harr = new int[cap];
}
 
// Inserts a new key 'k'
void MinHeap::insertKey(int k)
{
    if (heap_size == capacity)
    {
        cout << "\nOverflow: Could not insertKey\n";
        return;
    }
 
    // First insert the new key at the end
    heap_size++;
    int i = heap_size - 1;
    harr[i] = k;
 
    // Fix the min heap property if it is violated
    while (i != 0 && harr[parent(i)] > harr[i])
    {
       swap(&harr[i], &harr[parent(i)]);
       i = parent(i);
    }
}
 
// Decreases value of key at index 'i' to new_val.  It is assumed that
// new_val is smaller than harr[i].
void MinHeap::decreaseKey(int i, int new_val)
{
    harr[i] = new_val;
    while (i != 0 && harr[parent(i)] > harr[i])
    {
       swap(&harr[i], &harr[parent(i)]);
       i = parent(i);
    }
}
 
// Method to remove minimum element (or root) from min heap
int MinHeap::extractMin()
{
    if (heap_size <= 0)
        return INT_MAX;
    if (heap_size == 1)
    {
        heap_size--;
        return harr[0];
    }
 
    // Store the minimum value, and remove it from heap
    int root = harr[0];
    harr[0] = harr[heap_size-1];
    heap_size--;
    MinHeapify(0);
 
    return root;
}
 
 
// This function deletes key at index i. It first reduced value to minus
// infinite, then calls extractMin()
void MinHeap::deleteKey(int i)
{
    decreaseKey(i, INT_MIN);
    extractMin();
}
 
// A recursive method to heapify a subtree with root at given index
// This method assumes that the subtrees are already heapified
void MinHeap::MinHeapify(int i)
{
    int l = left(i);
    int r = right(i);
    int smallest = i;
    if (l < heap_size && harr[l] < harr[i])
        smallest = l;
    if (r < heap_size && harr[r] < harr[smallest])
        smallest = r;
    if (smallest != i)
    {
        swap(&harr[i], &harr[smallest]);
        MinHeapify(smallest);
    }
}
 
// A utility function to swap two elements
void swap(int *x, int *y)
{
    int temp = *x;
    *x = *y;
    *y = temp;
}
 
// Driver program to test above functions
int main()
{
    MinHeap h(11);
    h.insertKey(3);
    h.insertKey(2);
    h.deleteKey(1);
    h.insertKey(15);
    h.insertKey(5);
    h.insertKey(4);
    h.insertKey(45);
    cout << h.extractMin() << " ";
    cout << h.getMin() << " ";
    h.decreaseKey(2, 1);
    cout << h.getMin();
    return 0;
}
```
