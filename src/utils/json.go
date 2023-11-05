package utils

import (
	"encoding/json"
)

func JSON(data any) string {
	json, err := json.MarshalIndent(data, "", "    ")
	if err != nil {
		Panic(err)
	}
	return string(json)
}
