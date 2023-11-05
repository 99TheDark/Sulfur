package utils

import (
	"fmt"
	"os/exec"
)

func Exec(cmd string, args ...string) {
	if out, err := exec.Command(cmd, args...).Output(); err != nil {
		fmt.Println(string(out))
		fmt.Println(err)
		Panic(err)
	}
}
