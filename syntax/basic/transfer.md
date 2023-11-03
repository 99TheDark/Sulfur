# Transfer
Transfering data, such as functions, classes, enums, and constants, can be done through `import` and `export` statements.

There are three ways of importing: importing the namespace, certain values, or all the values. 

Most commonly, you might want to import everything you can from a module under a certain name. To do this, you simply write the `import` keyword, followed by a string containing the module name. For example, to import the `math` module, you would write `import "math"`. Multiple modules can be imported by seperating each with commas. You can then access values, like functions, using dot notation, like `math.sin()`.

Next, to import only certain values globally, write the `import` keyword followed by a comma-delimited list of names, the `from` keyword, and finally the module name as a string. For example, using the `math` module again, you could write `import cos, sin from "math"`, and then use `cos()` and `sin()` without dot notation. `math` will be undefined in this case.

Finally, to import everything globally, simply use an asterisk (`*`) instead of a list. For example, `import * from "math"`.

For exporting, you simply add the `export` keyword before any function, variable, enum, class, etc declaration. For example:
```
// example.su
mod example

// Can be accessed from different modules
export func add(int a, int b) (int) {
    return a + b
}

// Cannot be accessed from different modules
func formatName(string firstName, string lastName) (string) {
    return lastName + ", " + firstName
}

// importing.su
import "example"

// prints "31"
println(example.add(12, 19))
```