package sulfurc

import (
	"sulfur/src/utils"
)

func Execute(name string, output string) {
	switch Mode {
	case Run:
		utils.Exec(utils.Absolute() + "/tmp/" + name)
	case Build:
		utils.Exec("cp", utils.Absolute()+"/tmp/"+name, output)
	}
}
