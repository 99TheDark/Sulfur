package utils

import (
	"fmt"
	"os/exec"
)

func Exec(cmd string, args ...string) {
	if out, err := exec.Command(cmd, args...).Output(); err != nil {
		Panic(err)
	} else {
		if len(out) > 0 {
			fmt.Print(string(out))
		}
	}
}
