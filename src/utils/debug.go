package utils

import (
	"log"
	"sulfur/src/settings"
)

func AttemptSave(save func() error) {
	if settings.Debug {
		if err := save(); err != nil {
			if settings.Stacktrace {
				panic(err)
			} else {
				log.Fatalln(err)
			}
		}
	}
}
