# Modules
Modules are a fundamental part of complex Sulfur projects. Files can be in a module, or not be assigned to any module. Any file without a module is considered to be a 'main' file, meaning it is the entrypoint of a project.

To declare the module a file belongs to, simply write the `mod` keyword followed by its name. For example, if I were to make a string utilities module, I might write `mod stringutils` at the top of the file.

Files within the same directory may share the same module. All files in a module share variables, classes, functions, etc.