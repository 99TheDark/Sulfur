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

	if err := command.Run(); err != nil {
		out := stderr.String()
		if len(out) > 0 {
			Panic(out)
		} else {
			Panic(err)
		}
	} else {
		out := stdout.String()
		if len(out) > 0 {
			fmt.Print(out)
		}
	}
}
