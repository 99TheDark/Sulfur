# Issues
- Hyrbids
    - Statements use switch
    - Expressions use cascading
    - Parsing `if something {}` recognizes something as a typecast because of the brace
    - Possible Solution:
        - Transition each hybrid statement into a cascading-friendly form, and include in both `parseHybrid()` and `parseExpr()`.