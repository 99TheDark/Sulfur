package utils

import (
	"log"
	"sulfur/src/settings"
)

func Panic(err any) {
	if settings.Stacktrace {
		panic(err)
	} else {
		log.Fatalln(err)
	}
}
