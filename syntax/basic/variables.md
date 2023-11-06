## Variables
A variable is a value that can change over time. Any time you want to change or store anything, you need to use variables. 

In Sulfur, you can declare variables by writing a prefix, either `let`, `const` or `val`, the variables name, and its value. 
```
let x = 5
let greeting = "Hey there!"
let combination = 2.3 ^ 2 + 1
```
You can also add an optional type annotation, like so:
```
let x: int = 5
let greeting: string = "Hey there!"
let combination: float = 2.3 ^ 2 + 1
```
When you want to change a variable, you must reassign it. This can be done by writing the name of the variable followed by its new value, like so:
```
let myNumber = -23
myNumber = 7

// Prints "7"
println(myNumber)
```
When you want to change a variable by some amount, you may begin by writing `variable = variable + amount`. However, there is a shortcut. Whenever you want to apply a binary operator, an operator that takes two inputs like addition (`+`) or exponentiation (`^`), you can write an operation assignment, like as follows:
```
let num = 25

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
for let i = 0; i < 10; i += 1 {
    // Code omitted
}

// Good
for let i = 0; i < 10; i++ {
    // Code omitted
}

let x = 5
if x % 5 == 0 {
    // Decrease x by one
    x--
}
```
The three variable prefixes, `let`, `const` and `val` all give special meaning. The most common declaration you will use is `let`. Using `let` creates a variable that is mutable everywhere, meaning it is free to be changed. Using `const`, on the other hand, make a variable that is immutable everywhere, meaning it and its fields can never be changed. Finally, `val` creates a variable that is immutable at its root, meaning you cannot chanage its value, just the value's fields or contents. 
```
let otherPerson = new Person()

let x = new Person()
x = otherPerson // Legal
x.name = "Sam"  // Legal

const x = new Person()
x = otherPerson   // Illegal
x.name = "Olivia" // Illegal

val x = new Person()
x = otherPerson   // Illegal
x.name = "Jared"  // Legal
```