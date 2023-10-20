## Blocks
A block is any set of statements surrounded with curly braces (`{` and `}`), or a single statement connected with an arrow (`=>`).

Some examples of blocks are if statements and functions.
```
// This block uses an arrow, so it contains only one statement
if x > 5 => println("It's true!")

func something(int x, int y) (int) { 
    // This block containing two statements
    n := x * y
    return (x + y) ^ n
}
```

Blocks each have their own scope. A scope contains all the variables created within it. When you have duplicate naming, scope decides which to use.
```
// Define x to be 8 in the top scope
x := 8
if true {
    // Define x to be 3 in the if statement's scope
    x := -3
    
    // Prints "-3"
    println(x)
}
// Prints "8"
println(x)
```