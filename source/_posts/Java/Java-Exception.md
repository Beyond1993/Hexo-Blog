---
title: Java-Exception
date: 2017-10-16 06:57:45
categories: Java
tags:
---

http://www.geeksforgeeks.org/checked-vs-unchecked-exceptions-in-java/

checked 是在编译时就check的，必须要 declaration.

uncheck 在编译时不检查，不必须 declaration. 除了 Error和 RuntimeException 其他都是checked.

```text

                   +-----------+
		   | Throwable |
                   +-----------+
                    /         \
		   /           \
          +-------+          +-----------+
          | Error |          | Exception |
          +-------+          +-----------+
	   /  |  \           / |        \
         \        /	  \______/    	 \
	  \      /	                +------------------+
	  unchecked	 checked	| RuntimeException |
					+------------------+
					  /   |    |      \
					 \_________________/
					   
					   unchecked



```


public long Factorial (int n) throws FactorialException {
	Int sign = 1;
	If (n < 0) {
	 throw new FactorialException(“the number is negtive!”);
	}
long result  = 1;
	For (int i = n; i >=1 ; i--) {
		Result *= i;
}
Return result * sign;
}


// must throw
Public class FactorialException extends Exception {
…
}
//don't have to throw
Public class FactorialException extends RuntimeException {
…
}



