package utils

import "os"

func SaveFile(value []byte, location string) error {
	file, err := os.Create(location)
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
