## Functions
A function is a useful way to not repeat yourself. You can use functions to simplify tasks, including recursive ones. A function is defined by the `func` keyword, its name, its parameters, its return value and its contents.
```
// The function is named add, it takes in two integers, and returns an integer.
func add(int a, int b) (int) {
    // Returns the sum of its two parameters
    return a + b
} 
```
The `return` keyword is used to return what value you should get when calling the function. You can call a function by writing the name of the function followed by its parameters. For example, to call the `add` function from before, we would write something like this:
```
/* 
Returns a + b, where the first parameter a is set to 2, 
and the second parameter b is set to 5.

The resulting value of adding 2 and 5 is 7, so sum = 7
*/
sum := add(2, 5) 
```
Functions don't always have to return something; they can simply be called on their own. For example:
```
func doSomething(string greeting) { // No return value given
    println(greeting)
}

// Correct
doSomething("Hello, world!")

// Incorrect
x := doSomething("Heya")
```
Functions can also return *multiple* values, not just zero or one. Here's an example:
```
// Returns four values: three integers, and one string
func combos(int a, int b, int c) (int, int, int, string) {
    return a + b, a + c, b + c, "Combos of $(a), $(b), $(c)"
}
```
Finally, functions can have a varied number of arguments, or parameters, called varargs. Varargs are denoted by beginning the name with three dots. In the function, they are represented as an array of that type. An example of this would be:
```
// Function with varargs
func varargs(int x, int y, string ...names, float z) {
    for i := 0; i < names.length; i++ {
        println("$(names[i]) is a name")
    }
    println((x + y) ^ z)
}
```
You can call a function with varied arguments by including any number of that type of parameter at the correct location, as seen in the following:
```
// No names
varargs(-1, 5, 4.9)

// Three names
varargs(3, -7, "John", "Sarah", "Donald", 6.2)

// One name
varargs(9, 0, "Timmy", 0.4)
```
Varargs have a number of complicated rules to make them sensible.