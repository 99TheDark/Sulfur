## Type Conversion
Many things, such as enums, classes, and primitives have type conversions. There are two types of type conversions: implicit, or automatic type conversions, and explicit type conversions. 

The latter is written similarly to a function, yet distinct with the use of the exclamation mark (`!`). To convert from an integer with the value of `-4012` to a string, for example, you would write `string!(-4012)`. Explicit type conversions are written by starting with the type you want to cast to, an exclamation mark, and parentheses surrounding the value to be converted.

Automatic type conversions, on the other hand, are a little more complex. They occur whenever two types that do not match are used as one in the same. For example, when adding the integer `6` to the float `9.5`, ie `6 + 9.5`, `6` is automatically promoted to the float type. 

The order of type conversion is as follows, from lowest to highest: booleans, bytes, unsigned integers, integers, floats, complex numbers, classes, and finally strings.

Promotion and demotion of types will happen automatically except for in two scenarios: promoting a boolean value or demoting a class to anything but a string. This is to avoid bad practices, and to make code look cleaner and more readable, so things like:
```
while 14 {
    // code omitted
}
```
and 
```
id := new Identification()
println(id ^ 2)
```
never happen.