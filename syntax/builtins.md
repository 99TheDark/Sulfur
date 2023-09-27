# Builtins
- Integer
    ```
    int x = -5
    ```
    Operations: `+`, `-`, `*`, `/`, `^`, `%`, `&`, `|`, `!`, `!&`, `!|`
<br><br>
- Float
    ```
    float y = 7.65
    ```
    Operations: `+`, `-`, `*`, `/`, `^`, `%`
<br><br>
- Boolean
    ```
    bool z = true
    ```
    Operations: `&`, `|`, `!`, `!&`, `!|`
<br><br>
- String
    ```
    string greeting = "Hello, world!"
    ```
    Operations: `+`
<br><br>
- Complex 
    ```
    complex c = 3 + 2i
    ```
    Operations: `+`, `-`, `*`, `/`, `^`
<br><br>
- Range
    ```
    range tenTimes = 1:10
    ```
    Operations: None
<br><br>
- Error
    ``` 
    error ArrayError {
        OutOfBounds,
        InvalidSize,
        OutOfMemory
    }
    ```
<br><br>
- Any
    ```
    any val = "hi"
    val = 5
    val = -3.8
    val = -5:7
    ```
    Operations: None