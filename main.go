package main

import (
	"fmt"
	"os"
	"sulfur/src/settings"
	"sulfur/src/sulfurc"
	"sulfur/src/utils"
	"time"
)

func main() {
	start := time.Now()
	args := utils.NewQueue(os.Args[1:])

	mode := args.AttemptNext("No mode given")
	input := args.AttemptNext("No file given")
	output := utils.FileName(input)

	for !args.Empty() {
		name := *args.Consume()

		if name[0] == '-' { // Is a flag
			switch name[1:] {
			case "trace":
				settings.Stacktrace = true
			case "debug":
				settings.Debug = true
			case "colorless":
				settings.Colored = false
			case "o":
				if arg, ok := args.Next(); ok {
					output = *arg
				} else {
					utils.Panic("No output file given")
				}
			}
		}
	}

	sulfurc.SetMode(mode)
	sulfurc.Compile(input, output)

	fmt.Println("Compile time:", time.Since(start))
}
