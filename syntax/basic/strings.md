# Strings
Strings are a fundamental type. Strings are representations of text, from the word 'hello' to the number 12. To create a string, you surrounding your text in double quotes, like `"Hello, world"`.

Strings can contain anything, but a few things are made easier or possible to include, by writing an escaped character. Any backslash (`\`) in a string is the start of an escaped character. For example, to have double quotes in a string, you would escape it. For example, you might write
```
string quote = "\"I have a dream\" - Martin Luther King Jr."
println(quote) // prints "I have a dream" - Martin Luther King Jr.
```
As backslashes are used for escaped characters, you can also escape them by writing `\\`. Common escape characters like newlines and tabs are able to be written using a single letter.

A list of all escapable characters is below:
<center>

|Escape Sequence|Represented Character|
|:-|:-|
|`\a`|Alert|
|`\b`|Backspace|
|`\f`|Form feed|
|`\n`|New line|
|`\r`|Carriage return|
|`\t`|Tab|
|`\v`|Vertical tab|
|`\0`|Null|
|`\"`|Double quote|
|`\\`|Backslash|
|`\$(`|Dollar sign & left parenthesis
</center>
<br>

Finally, any UTF-8 encoded character can be represented by a lowercase 'u' and 4 hex characters, or a capital 'U' and 8 hex characters. For example, `"\u03BE"` for `"ξ"`, or `"U0002A10C"` for `"𪄌"`.