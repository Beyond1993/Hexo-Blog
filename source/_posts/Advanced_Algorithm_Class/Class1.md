---
title: Class1
date: 2018-01-30 07:20:36
categories: Advanced_Algorithm_Class
tags:
---

// subarray:    0 1 3  6  3  2 -> 6
                     0 1 4 10 13 15
                     
                      
  map: <0, 1>, <1, 1> <4, 1> <10, 1> <13,1> <15, 1> 
   sum = 4 + 6 = 10 + 3 = 13 + 2 = 15
   count = check(15 - 6) = 0
   result = 1


  
public int countOfSubArraySum(int[] array, int target) {
   if (array == null || array.length < 2) return 0;
   int sum = 0, result = 0;
   Map<Integer, Integer> preSum = new HashMap<>();
   preSum.put(0, 1);  // init

   for (int num : array) {
       sum += num;
       int count = preSum.getOrDefault(sum - target, 0);
       result += count;
       preSum.put(sum, count + 1);
   }

   return result;
}



// 2 sum,   List<Int[]> , unsorted, all unique results
//  1 1 1 2 2 2 3 3  ->  3
//  List<int[]> getAllUiquepar()e
public List<int[]> allAllPairs(int[] array, int target) {
  List<int[]> result = new LinkedList<>();
if (array == null || array.length < 2) return result;

// <element, index of the key element>
Map<Integer, Integer> visitedMap = new HashMap<>();
for (int i = 0; i < array.length; ++i) {
   // step 1: check the new target
   int newTarget = target - array[i];
   if (visitedMap.containsKey(newTarget)) {
       result.add(new int[]{visitedMap.get(newTarget), i});
   }
   // step 2: save the current index
   if (visitedMap.containsKey(array[i])) {
       visitedMap.put(array[i], i);
   }
}
return result;
}


public List<int[]> findAllPairs(int[] array, int target) {
List<int[]> reslist=new ArrayList<>();
                       if(arr.length<2) return reslist;
int left = 0, right = A.length - 1;
  while(left < right) {
    int sum = A[left] + B[right];
    if(sum == target) {
         Int[] res=new int[2];
   res[0]=left;
   res[1]=right;
   reslist.add(res);
   Map 
  } else if(sum > target) right--;
    else left++;
}
return reslist ;

}

// 2 sum, sorted
public int closestSum(int[] array, int target) {
   if(array == null || array.length < 2) throw new NoSuchElementException();
   Arrays.sort(array);

   int left = 0, right = array.length - 1;
   int offset = Integer.MAX_VALUE;

   while (left < right) {
      // can = candidate
       int can = array[left] + array[right] - target;
       offset = Math.abs(can) < Math.abs(offset) ? can : offset;
       if(offset == 0) break;

       int can1 = array[left + 1] + array[right] - target;
       int can2 = array[left] + array[right - 1] - target;

       if(Math.abs(can1) >= Math.abs(offset) && Math.abs(can2) >= Math.abs(offset)) break;
       if(Math.abs(can1 - offset) > Math.abs(can2 - offset)) left++;
       else right--;
   }

   return target + offset;
}


Public int closeSum(int[] array, int target) {
  Arrays.sort(array);
  Int left = 0;
  Int right = array.length - 1;
  Boolean 
  While (left < right) {
      Int sum = array[left] + array[right];
      If（sum == target) {
           Return sum;
      } else if (sum > target) {
          Right --;
         
      } else {
          Left++;
     }


  } 

}

isLarger

Sum > target left right
Sum < target left right




Int delta = Integer.MAX_VALUE;
   *************************
left
                                  Right
1,2,3,4,5     3.6 
i 
  I  j
A[i] + A[j] ?? 
candidates: [i +1, j +1], [i -1 ,j -1], [i, j], [i, j + 1], [i, j - 1], [i + 1,j],[i - 1,j]

Boolean isLarger

sum = A[left] + A[right]
sum ? target
case 1: ==, return target
case 2: >, right--
case 3: <, left++
left >= right
while(left < right)

return A[left] + A[right] ?

// 4 sum =  2 sum + 2 sum
//    ************  ***********
//   a + b -> set
//   target - (c + d) is exist in set: a !=c && a!=d&& b!=c && b !=d 

[1,3,2,2];

Key : 4, 0 ,1
Key : 4: 2, 3



public boolean fourSum(int[] A, int target) {
   if (A == null || A.length < 3) return false;

   Map<Integer, int[]> sumMap = new HashMap<>();
   for (int i = 0; i < A.length; i++) {  // a + b
       for (int j = i + 1; j < A.length; j++) {
           sumMap.put(A[i] + A[j], new int[]{i, j});
       }
   }

   for (int i = 0; i < A.length; i++) {
       for (int j = i + 1; j < A.length; j++) {
           int newTarget = target - A[i] - A[j];  // e - c - d
           int[] ints = sumMap.get(newTarget);
           if (ints == null) continue;
           if (ints[0] != i && ints[0] != j  && ints[1] != i && ints[1] != j) return true;
       }
   }
   return false;
}





// unsorted, set  a + b + c = d
// Set<Integer>: a = 1 element + 2 sum
                    a + b = 2 sum + 1 element
//                     b + c = d

//   *******  *********
//   set         b + c = d - a
// set: a + b
public boolean threeSum2(int[] A, int target) {
   if (A == null || A.length < 3) return false;
  //  ******** |  *********
 // 
 //    a + b       c
   Set<Integer> visitedSet = new HashSet<>();
   for (int i = 1; i < A.length - 1; i++) {
       for (int j = 0; j < i; j++) {
           int newTarget = target - A[i + 1]; //c
           if (visitedSet.contains(newTarget)) return true;
           visitedSet.add(A[i] + A[j]);
       }
   }

   return false;
}

A[i]  A[i +1]  A[j]  要把数组分成两部分, 左右两部分

public boolean threeSum(int[] A, int target) {
  // set: a + b
  Set<Integer> visitedSet = new HashSet<>();   // a的集合
           // b, c
   for ( int i = 0; i < A.length; i ++) {  // a
    for (int j = i + 1; j < A.length; j++) {  // b
                             Int sum = A[i] + A[j];    A[i]
                                           If (visitedSet.contains(target - A[i]) return true;       
visitedSet.add(sum);  // a + b
}
}
}


public boolean threeSum(int[] A, int target) {
  Set<Integer> visitedSet = new HashSet<>();   // a的集合
           // b, c
   for ( int i = 0; i < A.length; i ++) {  // b
    for (int j = i + 1; j < A.length; j++) {  // c
      int sum = A[i] + A[j];  // b + c
      int newTarget = target - sum;
      if(visitedSet.contains(newTarget)) return ture;
}
visitedSet.add(A[i]);
}
return false;
}
public boolean threeSum(int[] A, int target) {
    // set: a
    for ( int i = 0; i < A.length; i ++) {
       Set<Integer> set = new HashSet<Integer>();
       for (int j = i; j < A.length; j++) {
             int value =  target - A[i] - A[ j ]; 
             If (set.contains(value)) return true;
             set.add(A[i]);  //  i  n ^ 2
       }

   }
   Return false;

}

