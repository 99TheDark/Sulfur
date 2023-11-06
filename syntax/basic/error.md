# Errors
Errors in Sulfur are similar to enums, but with a few distinctions. Errors cannot have any non-automatic value like enums, and cannot be converted between. To create an error, use the `error` keyword, the name of the error, alongside a block containing all the possible errors. 

For example, for file errors, you might write something like this:
```
error FileError {
    FileNotFound,
    AccessDenied,
    InvalidFormat,
    BufferOverflow,
    CreationFailed
}
```
All functions can throw errors, and these errors must be handled, or the function must explicitly throw the error upwards. For example:
```
import "fs"

func saveFile(string loc, string name, string ext, string contents) throws FileError {
    path := location + name + extension
    
    fs.File file = undef
    if fs.exists(path) {
        // Might throw a FileError
        file = try fs.get(path)
    } else {
        // Might throw a FileError
        file = try fs.create(path)
    }
    
    // Might throw a FileError
    try file.write(path, contents)
}
```
You can also catch errors based on the type of error
```
import "some_module/apps"
import log from "some_logger"

error FatalError {
    MemoryLeak,
    InfiniteLoop,
    SaveError,
    CorruptedFile
}

log.setup()

try apps.run() catch {
    FatalError.MemoryLeak => log(apps.collectUsedMemory())
    FatalError.InfiniteLoop => log(apps.getRunningCode())
    FatalError.SaveError => log(apps.saveStep().file)
    FatalError.CurruptedFile => {
        files := apps.files()
        foreach file in files {
            log(file.contents())
        }
    }
}
```
or simply use an automatic value.
```
array := float[-9.7, 4.2, 0.3, -0.5, -7.1, 2.6]

// Since 0 is not in array, it will throw, so idx = -1
idx := try getIndex(array, 0) catch -1
```
However, some errors are non-recoverable, and will immediately stop the execution of your program. These kinds of errors are all built-in, such as array indexing. These cannot be handled.

Finally, to throw an error, just use the `throw` keyword and the error given.