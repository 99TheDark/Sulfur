package utils

import (
	"os"
	"path/filepath"
)

func SaveFile(value []byte, location string) error {
	file, err := os.Create(Relative(location))
	if err != nil {
		return err
	}

	_, err = file.Write(value)
	if err != nil {
		file.Close()
		return err
	}

	err = file.Close()
	if err != nil {
		return err
	}

	return err
}

func Relative(path string) string {
	return Absolute() + "/" + path
}

func Absolute() string {
	return filepath.Dir(os.Args[0])
}
