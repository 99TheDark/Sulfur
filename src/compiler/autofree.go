package compiler

func (g *generator) autoFree() {
	// bl := g.bl
	for _, vari := range g.top.Vars {
		if !vari.Referenced && !vari.References && g.complex(vari.Type) {
			// bl.NewCall("")
		}
	}
}
