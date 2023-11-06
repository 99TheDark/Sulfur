## String Interpolation
String interoplation is a very useful feature to make string creation simple and elegant. String interpolation means putting values, variables or expressions into a string without manually converting and adding them. 

You can interpolate an expression by putting a dollar sign (`$`) in your string, and surrounding the expression in parentheses. For example, instead of
```
println("I said " + string!(saying) + " " + string!(x) + " times!")
```
you can write 
```
println("I said $(saying) $(x) times!")
```
given that `saying` and `x` are valid variables. As stated previously, they can have any sort of expression within them, like `println("$I'm $(age * 365) days old")`.

If you would like to write a dollar sign and a parenthesis next to each other without interpolating a string, simply escape the character with a backslash, like 
```
// msg = `You can interpolate a string like this: "I said $(saying) $(x) times!"`
let msg = "You can interpolate a string like this: \"I said \$(saying) \$(x) times!\"
```
Finally, to not have to write any escaped characters, like escaped dolar signs or escaped quotes, you can use a raw string by using backticks (`` ` ``) instead of double quotes. For example, 
```
let passage = `And he exclaimed, "Today will be a great day!"`
```
However, as backticks negate *all* escape characters, you cannot have backticks in a raw string.