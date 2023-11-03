package utils

import (
	"path/filepath"
	"strings"
)

func FileName(path string) string {
	return strings.TrimSuffix(filepath.Base(path), filepath.Ext(path))
}
