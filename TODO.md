# TODO
- Redo parsing
    - One statement per line, otherwise seperated by semicolons, ex:
        ```
        // Legal
        x, y := do(3, 1); a := 12 * x

        // Legal
        x, y := do(3, 1)
        a := 12 * x

        // Illegal
        x, y := do(3, 1) a := 12 * x
        ```
- Add back numbers
- Add builtin functions
- Structs in functions