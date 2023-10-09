# Builtins
- Integer
    ```
    int x = -5
    ```
    Operations: `+`, `-`, `*`, `/`, `^`, `%`, `&`, `|`, `!`, `!&`, `!|`, `>>`, `<<`, `>>>`
<br><br>
- Unsigned Integer
    ```
    uint x = 572u
    ```
    Operations: `+`, `-`, `*`, `/`, `^`, `%`, `&`, `|`, `!`, `!&`, `!|`, `>>`, `<<`, `>>>`
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
- Byte
    ```
    byte red = 237b
    ```
    Operations: `+`, `-`, `*`, `/`, `^`, `%`, `&`, `|`, `!`, `!&`, `!|`, `>>`, `<<`, `>>>`
<br><br>
- Complex 
    ```
    complex c = 3 + 2i
    ```
    Operations: `+`, `-`, `*`, `/`, `^`
<br><br>
- Array
    ```
    x := int[-8, 2, 6, -1, 0, 4]
    ```
    Operations: `[]`
<br><br>
- Function
    ```
    func add(int a, int b) (int) {
        return a + b
    }
    ```
    Operations: None
<br><br>
- Class
    ```
    class Person {
        pub string name

        Person(string name) {
            my.name = name
        }

        talk() {
            println("Hi, my name is $(my.name)!")
        }
    }
    ```
<br><br>
- Enum
    ```
    enum Season {
        Winter
        Spring
        Summer
        Fall
    }
    ```
    Operations: None
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
    Operations: None
<br><br>
- Any
    ```
    any val = "hi"
    val = 5
    val = -3.8
    val = -5:7
    ```
    Operations: None