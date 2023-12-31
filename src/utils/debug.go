package utils

import (
	"fmt"
	"sulfur/src/settings"
)

func AttemptSave(save func() error) {
	if settings.Debug {
		ForceSave(save)
	}
}

func ForceSave(save func() error) {
	if err := save(); err != nil {
		fmt.Println("ERROR!!!")
		Panic(err)
	}
}
