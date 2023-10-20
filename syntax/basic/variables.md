## Variables
A variable is a value that can change over time. Any time you want to change or store anything, you need to use variables. 

In sulfur, you can declare variables in two ways. Standard declaration is created by writing the type the variable stores, the name of the variables, and what it equals. For example:
```
int x = 5
string greeting = "Hey there!"
float combination = 2.3 ^ 2 + 1
```
Another way of creating a variable is with implicit declaration, created by omitting the type and using the implicit declaration operator for assigning its value.
```
x := 5
greeting := "Hey there!"
combination := 2.3 ^ 2 + 1
```
When you want to change a variable, you must reassign it. This can be done by writing the name of the variable followed by its new value, like so:
```
myNumber := -23
myNumber = 7

// Prints "7"
println(myNumber)
```
When you want to change a variable by some amount, you may begin by writing `variable = variable + amount`. However, there is a shortcut. Whenever you want to apply a binary operator, an operator that takes two inputs like addition (`+`) or exponentiation (`^`), you can write an operation assignment, like as follows:
```
num := 25

// Changes num by 2
num = num + 2

// Also changes num by 2
num += 2

// Divides num by 3
num /= 3

// Prints "9"
println(num)
```
Commonly in loops, like a for loop, you want to increase of decrease a counter by one every iteration. Instead of writing `i += 1` or `i -= 1`, you can use the increment operator (`++`) or the decrement operator (`--`). For example:
```
// Bad
for i := 0; i < 10; i += 1 {
    // Code omitted
}

// Good
for i := 0; i < 10; i++ {
    // Code omitted
}

x := 5
if x % 5 == 0 {
    // Decrease x by one
    x--
}
```