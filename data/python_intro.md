# Python 101

This is an optional notebook to get you up to speed with Python in case you are new to Python or need a refresher. The material here is a crash course in Python; I highly recommend the [official Python tutorial](https://docs.python.org/3/tutorial/) for a deeper dive. Consider reading [this page](https://docs.python.org/3/tutorial/appetite.html) in the Python docs for background on Python and bookmarking the [glossary](https://docs.python.org/3/glossary.html#glossary).

## Basic data types
### Numbers
Numbers in Python can be represented as integers (e.g. `5`) or floats (e.g. `5.0`). We can perform operations on them:


```python
5 + 6
```




    11




```python
2.5 / 3
```




    0.8333333333333334



### Booleans

We can check for equality giving us a Boolean:


```python
5 == 6
```




    False




```python
5 < 6
```




    True



These statements can be combined with logical operators: `not`, `and`, `or`


```python
(5 < 6) and not (5 == 6)
```




    True




```python
False or True
```




    True




```python
True or False
```




    True



### Strings
Using strings, we can handle text in Python. These values must be surrounded in quotes &mdash; single (`'...'`) is the standard, but double (`"..."`) works as well:


```python
'hello'
```




    'hello'



We can also perform operations on strings. For example, we can see how long it is with `len()`:


```python
len('hello')
```




    5



We can select parts of the string by specifying the **index**. Note that in Python the 1<sup>st</sup> character is at index 0:


```python
'hello'[0]
```




    'h'



We can concatentate strings with `+`:


```python
'hello' + ' ' + 'world'
```




    'hello world'



We can check if characters are in the string with the `in` operator:


```python
'h' in 'hello'
```




    True



## Variables
Notice that just typing text causes an error. Errors in Python attempt to clue us in to what went wrong with our code. In this case, we have a `NameError` exception which tells us that `'hello'` is not defined. This means that [the Python interpreter](https://docs.python.org/3/tutorial/interpreter.html) looked for a **variable** named `hello`, but it didn't find one.


```python
hello
```


    ---------------------------------------------------------------------------

    NameError                                 Traceback (most recent call last)

    <ipython-input-13-f572d396fae9> in <module>
    ----> 1 hello
    

    NameError: name 'hello' is not defined


Variables give us a way to store data types. We define a variable using the `variable_name = value` syntax:


```python
x = 5
y = 7
x + y
```




    12



The variable name cannot contain spaces; we usually use `_` instead. The best variable names are descriptive ones:


```python
book_title = 'Hands-On Data Analysis with Pandas'
```

Variables can be any data type. We can check which one it is with `type()`, which is a **function** (more on that later):


```python
type(x)
```




    int




```python
type(book_title)
```




    str



If we need to see the value of a variable, we can print it using the `print()` function:


```python
print(book_title)
```

    Hands-On Data Analysis with Pandas


## Collections of Items

### Lists
We can store a collection of items in a list:


```python
['hello', ' ', 'world']
```




    ['hello', ' ', 'world']



The list can be stored in a variable. Note that the items in the list can be of different types:


```python
my_list = ['hello', 3.8, True, 'Python']
type(my_list)
```




    list



We can see how many elements are in the list with `len()`:


```python
len(my_list)
```




    4



We can also use the `in` operator to check if a value is in the list:


```python
'world' in my_list
```




    False



We can select items in the list just as we did with strings, by providing the index to select:


```python
my_list[1]
```




    3.8



Python also allows us to use negative values, so we can easily select the last one:


```python
my_list[-1]
```




    'Python'



Another powerful feature of lists (and strings) is **slicing**. We can grab the middle 2 elements in the list:


```python
my_list[1:3]
```




    [3.8, True]



... or every other one:


```python
my_list[::2]
```




    ['hello', True]



We can even select the list in reverse:


```python
my_list[::-1]
```




    ['Python', True, 3.8, 'hello']



Note: This syntax is `[start:stop:step]` where the selection is inclusive of the start index, but exclusive of the stop index. If `start` isn't provided, `0` is used. If `stop` isn't provided, the number of elements is used (4, in our case); this works because the `stop` is exclusive. If `step` isn't provided, it is 1.

We can use the `join()` method on a string object to concatenate all the items of a list into single string. The string we call the `join()` method on will be used as the separator, here we separate with a pipe (|):


```python
'|'.join(['x', 'y', 'z'])
```




    'x|y|z'



### Tuples
Tuples are similar to lists; however, they can't be modified after creation i.e. they are **immutable**. Instead of square brackets, we use parenthesis to create tuples:


```python
my_tuple = ('a', 5)
type(my_tuple)
```




    tuple




```python
my_tuple[0]
```




    'a'



Immutable objects can't be modified:


```python
my_tuple[0] = 'b'
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-31-f792d047bcee> in <module>
    ----> 1 my_tuple[0] = 'b'
    

    TypeError: 'tuple' object does not support item assignment


### Dictionaries
We can store mappings of key-value pairs using dictionaries:


```python
shopping_list = {
    'veggies': ['spinach', 'kale', 'beets'],
    'fruits': 'bananas',
    'meat': 0    
}
type(shopping_list)
```




    dict



To access the values associated with a specific key, we use the square bracket notation again:


```python
shopping_list['veggies']
```




    ['spinach', 'kale', 'beets']



We can extract all of the keys with `keys()`:


```python
shopping_list.keys()
```




    dict_keys(['veggies', 'fruits', 'meat'])



We can extract all of the values with `values()`:


```python
shopping_list.values()
```




    dict_values([['spinach', 'kale', 'beets'], 'bananas', 0])



Finally, we can call `items()` to get back pairs of (key, value) pairs:


```python
shopping_list.items()
```




    dict_items([('veggies', ['spinach', 'kale', 'beets']), ('fruits', 'bananas'), ('meat', 0)])



### Sets
A set is a collection of unique items; a common use is to remove duplicates from a list. These are written with curly braces also, but notice there is no key-value mapping:


```python
my_set = {1, 1, 2, 'a'}
type(my_set)
```




    set



How many items are in this set?


```python
len(my_set)
```




    3



We put in 4 items but the set only has 3 because duplicates are removed:


```python
my_set
```




    {1, 2, 'a'}



We can check if a value is in the set:


```python
2 in my_set
```




    True



## Functions
We can define functions to package up our code for reuse. We have already seen some functions: `len()`, `type()`, and `print()`. They are all functions that take **arguments**. Note that functions don't need to accept arguments, in which case they are called without passing in anything (e.g. `print()` versus `print(my_string)`). 

*Aside: we can also create lists, sets, dictionaries, and tuples with functions: `list()`, `set()`, `dict()`, and `tuple()`*

### Defining functions

We use the `def` keyword to define functions. Let's create a function called `add()` with 2 parameters, `x` and `y`, which will be the names the code in the function will use to refer to the arguments we pass in when calling it:


```python
def add(x, y):
    """This is a docstring. It is used to explain how the code works and is optional (but encouraged)."""
    # this is a comment; it allows us to annotate the code
    print('Performing addition')
    return x + y
```

Once we run the code above, our function is ready to use:


```python
type(add)
```




    function



Let's add some numbers:


```python
add(1, 2)
```

    Performing addition





    3



### Return values
We can store the result in a variable for later:


```python
result = add(1, 2)
```

    Performing addition


Notice the print statement wasn't captured in `result`. This variable will only have what the function **returns**. This is what the `return` line in the function definition did:


```python
result
```




    3



Note that functions don't have to return anything. Consider `print()`:


```python
print_result = print('hello world')
```

    hello world


If we take a look at what we got back, we see it is a `NoneType` object:


```python
type(print_result)
```




    NoneType



In Python, the value `None` represents null values. We can check if our variable *is* `None`:


```python
print_result is None
```




    True



*Warning: make sure to use comparison operators (e.g. >, >=, <, <=, ==, !=) to compare to values other than `None`.*

### Function arguments

*Note that function arguments can be anything, even other functions. We will see several examples of this in the text.* 

The function we defined requires arguments. If we don't provide them all, it will cause an error:


```python
add(1)
```


    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-49-2558a051bacf> in <module>
    ----> 1 add(1)
    

    TypeError: add() missing 1 required positional argument: 'y'


We can use `help()` to check what arguments the function needs (notice the docstring ends up here):


```python
help(add)
```

    Help on function add in module __main__:
    
    add(x, y)
        This is a docstring. It is used to explain how the code works and is optional (but encouraged).
    


We will also get errors if we pass in data types that `add()` can't work with:


```python
add(set(), set())
```

    Performing addition



    ---------------------------------------------------------------------------

    TypeError                                 Traceback (most recent call last)

    <ipython-input-51-9c946942295c> in <module>
    ----> 1 add(set(), set())
    

    <ipython-input-41-e34d07952248> in add(x, y)
          3     # this is a comment; it allows us to annotate the code
          4     print('Performing addition')
    ----> 5     return x + y
    

    TypeError: unsupported operand type(s) for +: 'set' and 'set'


We will discuss error handling in the text.

## Control Flow Statements
Sometimes we want to vary the path the code takes based on some criteria. For this we have `if`, `elif`, and `else`. We can use `if` on its own:


```python
def make_positive(x):
    """Returns a positive x"""
    if x < 0:
        x *= -1
    return x
```

Calling this function with negative input causes the code under the `if` statement to run:


```python
make_positive(-1)
```




    1



Calling this function with positive input skips the code under the `if` statement, keeping the number positive:


```python
make_positive(2)
```




    2



Sometimes we need an `else` statement as well:


```python
def add_or_subtract(operation, x, y):
    if operation == 'add':
        return x + y
    else:
        return x - y
```

This triggers the code under the `if` statement:


```python
add_or_subtract('add', 1, 2)
```




    3



Since the Boolean check in the `if` statement was `False`, this triggers the code under the `else` statement:


```python
add_or_subtract('subtract', 1, 2)
```




    -1



For more complicated logic, we can also use `elif`. We can have any number of `elif` statements. Optionally, we can include `else`.


```python
def calculate(operation, x, y):
    if operation == 'add':
        return x + y
    elif operation == 'subtract':
        return x - y
    elif operation == 'multiply':
        return x * y
    elif operation == 'division':
        return x / y
    else:
        print("This case hasn't been handled")
```

The code keeps checking the conditions in the `if` statements from top to bottom until it finds `multiply`:


```python
calculate('multiply', 3, 4)
```




    12



The code keeps checking the conditions in the `if` statements from top to bottom until it hits the `else` statement:


```python
calculate('power', 3, 4)
```

    This case hasn't been handled


## Loops
### `while` loops
With `while` loops, we can keep running code until some stopping condition is met:


```python
done = False
value = 2
while not done:
    print('Still going...', value)
    value *= 2
    if value > 10:
        done = True
```

    Still going... 2
    Still going... 4
    Still going... 8


Note this can also be written as, by moving the condition to the `while` statement:


```python
value = 2
while value < 10:
    print('Still going...', value)
    value *= 2
```

    Still going... 2
    Still going... 4
    Still going... 8


### `for` loops
With `for` loops, we can run our code *for each* element in a collection:


```python
for i in range(5):
    print(i)
```

    0
    1
    2
    3
    4


We can use `for` loops with lists, tuples, sets, and dictionaries as well:


```python
for element in my_list:
    print(element)
```

    hello
    3.8
    True
    Python



```python
for key, value in shopping_list.items():
    print('For', key, 'we need to buy', value)
```

    For veggies we need to buy ['spinach', 'kale', 'beets']
    For fruits we need to buy bananas
    For meat we need to buy 0


With `for` loops, we don't have to worry about checking if we have reached the stopping condition. Conversely, `while` loops can cause infinite loops if we don't remember to update variables.

## Imports
We have been working with the portion of Python that is available without importing additional functionality. The Python standard library that comes with the install of Python is broken up into several **modules**, but we often only need a few. We can import whatever we need: a module in the standard library, a 3rd-party library, or code that we wrote. This is done with an `import` statement:


```python
import math

print(math.pi)
```

    3.141592653589793


If we only need a small piece from that module, we can do the following instead:


```python
from math import pi

print(pi)
```

    3.141592653589793


*Warning: anything you import is added to the namespace, so if you create a new variable/function/etc. with the same name it will overwrite the previous value. For this reason, we have to be careful with variable names e.g. if you name something `sum`, you won't be able to add using the `sum()` built-in function anymore. Using notebooks or an IDE will help you avoid these issues with syntax highlighting.* 

## Installing 3rd-party Packages
**NOTE: We will cover the environment setup in the text; this is for reference.**

We can use [`pip`](https://pip.pypa.io/en/stable/reference/) or [`conda`](https://docs.conda.io/projects/conda/en/latest/commands.html) to install packages, depending on how we created our virtual environment. The text walks through the commands to create virtual environments with `venv` and `conda`. The environment **MUST** be activated before installing the packages for this text; otherwise, it's possible they interfere with other projects on your machine or vice versa.

To install a package, we can use `pip3 install <package_name>`. Optionally, we can provide a specific version to install `pip3 install pandas==0.23.4`. Without that specification, we will get the most stable version. When we have many packages to install (as we do for this book), we will typically use a `requirements.txt` file: `pip3 install -r requirements.txt`. 

*Note: running `pip3 freeze > requirements.txt` will send the list of packages installed in the activate environment and their respective versions to the `requirements.txt` file.*


## Classes
*NOTE: We will discuss this further in the text in chapter 7. For now, it is important to be aware of the syntax in this section.*

So far we have used Python as a functional programming language, but we also have the option to use it for **object-oriented programming**. You can think of a `class` as a way to group similar functionality together. Let's create a calculator class which can handle mathematical operations for us. For this, we use the `class` keyword and define **methods** for taking actions on the calculator. These methods are functions that take `self` as the first argument. When calling them, we don't pass in anything for that argument (example after this):


```python
class Calculator:
    """This is the class docstring."""
    
    def __init__(self):
        """This is a method and it is called when we create an object of type `Calculator`."""
        self.on = False
        
    def turn_on(self):
        """This method turns on the calculator."""
        self.on = True
    
    def add(self, x, y):
        """Perform addition if calculator is on"""
        if self.on:
            return x + y
        else:
            print('the calculator is not on')
```

In order to use the calculator, we need to **instantiate** an instance or object of type `Calculator`. Since the `__init__()` method has no parameters other than `self`, we don't need to provide anything:


```python
my_calculator = Calculator()
```

Let's try to add some numbers:


```python
my_calculator.add(1, 2)
```

    the calculator is not on


Oops!! The calculator is not on. Let's turn it on:


```python
my_calculator.turn_on()
```

Let's try again:


```python
my_calculator.add(1, 2)
```




    3



We can access **attributes** on object with dot notation. In this example, the only attribute is `on`, and it is set in the `__init__()` method:


```python
my_calculator.on
```




    True



Note that we can also update attributes:


```python
my_calculator.on = False
my_calculator.add(1, 2)
```

    the calculator is not on


Finally, we can use `help()` to get more information on the object:


```python
help(my_calculator)
```

    Help on Calculator in module __main__ object:
    
    class Calculator(builtins.object)
     |  This is the class docstring.
     |  
     |  Methods defined here:
     |  
     |  __init__(self)
     |      This is a method and it is called when we create an object of type `Calculator`.
     |  
     |  add(self, x, y)
     |      Perform addition if calculator is on
     |  
     |  turn_on(self)
     |      This method turns on the calculator.
     |  
     |  ----------------------------------------------------------------------
     |  Data descriptors defined here:
     |  
     |  __dict__
     |      dictionary for instance variables (if defined)
     |  
     |  __weakref__
     |      list of weak references to the object (if defined)
    


... and also for a method:


```python
help(my_calculator.add)
```

    Help on method add in module __main__:
    
    add(x, y) method of __main__.Calculator instance
        Perform addition if calculator is on
    


##### END
