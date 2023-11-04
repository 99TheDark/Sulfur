package utils

import (
	"encoding/json"
	"log"
)

func JSON(data any) string {
	json, err := json.MarshalIndent(data, "", "    ")
	if err != nil {
		log.Fatalln(err)
	}
	return string(json)
}
