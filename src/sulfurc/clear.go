package sulfurc

import (
	"os/exec"
	"sulfur/src/utils"
)

func Clear() {
	if _, err := exec.Command("bash", utils.Absolute()+"/clear.sh").Output(); err != nil {
		utils.Panic(err)
	}
}
