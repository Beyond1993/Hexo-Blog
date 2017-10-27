---
title: Python-Snippet
date: 2017-10-16 06:52:04
categories: Python
tags:
---

Print type of an Object

```python
print(type(your_object))
```
Print an Object
```pyton
from pprint import pprint
pprint (vars(your_object))
```
Use PDB
```python
import pdb
pdb.set_trace()
```
便捷输出到文件
```python
debug_file = open('debug_file.txt','w')
print >>debug_file, results
```

利用迭代协议让for循环自动调用next从而前进到文件的下一行，而不是直接把文件读取到内存中,

有三点原因：写法简单，运行速度快，节省内存。示例如下：
```python
for line in open('myfile.py'):
...print line.upper()
```
而不是使用readlines方法：
```java
for line in open('myfile.py').readlines():
...print line.upper()
```


selenium
```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
driver = webdriver.Firefox()
driver.get("http://www.google.com")
input_element = driver.find_element_by_name("q")
import time
time.sleep(5)  
input_element.send_keys("python")
import time
time.sleep(5)
input_element.submit()
RESULTS_LOCATOR = "//div/h3/a"

WebDriverWait(driver, 10).until(EC.visibility_of_element_located((By.XPATH, RESULTS_LOCATOR)))
    page1_results = driver.find_elements(By.XPATH, RESULTS_LOCATOR)

    for item in page1_results:
    	print(item.text)
```

pip install selenium-requests

# Import any WebDriver class that you would usually import from
# selenium.webdriver from the seleniumrequests module
from seleniumrequests import Firefox

# Simple usage with built-in WebDrivers:
webdriver = Firefox()
response = webdriver.request('GET', 'https://www.google.com/')
print(response)


# More complex usage, using a WebDriver from another Selenium-related module:
from seleniumrequests.request import RequestMixin
from someothermodule import CustomWebDriver


class MyCustomWebDriver(CustomWebDriver, RequestMixin):
    pass


custom_webdriver = MyCustomWebDriver()
response = custom_webdriver.request('GET', 'https://www.google.com/')
print(response)


Python 2: Bytes 8-bits byte, str Unicode

Python 3: str 8-bits byte,  Unicode Unicode



Software should only work with Unicode strings internally, converting to a particular encoding on output.



为了应对复杂的编码环境，我们应该优先使用Unicode,  而不是8-bits 的 ASCII string。 



def read_file(filename, encoding):
    if '/' in filename:
        raise ValueError("'/' not allowed in filename")
    unicode_name = filename.decode(encoding)
    f = open(unicode_name, 'w')
    f.write('hack way')
    f.close()
read_file('Li90ZXN0Lm1k', 'base64')
# Li90ZXN0Lm1k is the UTF-8 base64 of ./test.md





Wrap the data in a class and override __cmp__ to return what you'd like for your comparison. E.g.
```python
class PQEntry:

    def __init__(self, priority, value):
        self.priority = priority
        self.value = value    
    
    def __cmp__(self, other):
         return cmp(self.priority, other.priority)
         
 if __name__ == '__main__':
```
