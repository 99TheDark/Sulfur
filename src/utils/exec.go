package utils

import (
	"bytes"
	"fmt"
	"os/exec"
)

var stdout, stderr bytes.Buffer

func Exec(cmd string, args ...string) {
	command := exec.Command(cmd, args...)
	command.Stdout = &stdout
	command.Stderr = &stderr

	stdout.Reset()
	stderr.Reset()

	if command.Run() != nil {
		Panic(stderr.String())
	} else {
		out := stdout.String()
		if len(out) > 0 {
			fmt.Print(out)
		}
	}
}
