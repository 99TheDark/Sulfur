package sulfurc

import (
	"fmt"
	"sulfur/src/utils"
)

func Execute(name string, output string) {
	switch Mode {
	case Run:
		utils.Exec(utils.Absolute() + "/tmp/" + name)
	case Build:
		fmt.Println(output)
		utils.Exec("cp", utils.Absolute()+"/tmp/"+name, output)
	}
}
