# Basic Structures
- Comments
    ```
    // Comment
    
    /*
    Multi-line comment
    */
    ```
- Groups
    ```
    // Anything inside of braces is a group, and has scope 
    {
        // code omitted
    }
    ```
- Array
    ```
    // Arrays literals are made from the type, and filled with brackets
    float[] myArray = float[3.7, -6.4, 12.9, 5.0]
    ```
- Operation Assignment
    ```
    int x = 5

    // x = x + 2 (append)
    x += 2

    // x = 1 - x (prepend)
    x =- 1
    ```
- Inference
    ```
    // x is a float
    x := 8.9

    // pi and otherPi are both int[]'s
    pi := [3, 1, 4]
    otherPi := int[3, 1, 4, 1, 5]
    ```
- Type Cast
    ```
    // to_type<from_type>
    str_num := string<543> // str_num := "543"
    ```
- String Interpolation
    ```
    x := 5
    saying := "good morning"

    // Equivalent to 'println("I said " + string<saying> + " " + string<x> + " times!")'
    println("I said $(saying) $(x) times!")
    ```
- Classes
    ```
    // Person class
    Person {
        // fields — TODO: design getter & setter syntax
        string name
        int    age
        int    days_old

        // Constructor, ~param => my.param = param
        Person(string ~name, int ~age) {
            // my => this
            my.days_old = age * 365
        }

        // TODO: Define destructor syntax

        talk() {
            println("Hello, my name is $(my.name).")
        }

        // Define typecast, now string<Person> is possible
        to string {
            return "$(my.name), $(my.age) years old"
        }

        // TODO: Define operator overloading syntax
    }
    ```