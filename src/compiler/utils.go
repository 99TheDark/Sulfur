package compiler

import (
	"fmt"
	"sulfur/src/ast"

	"github.com/llir/llvm/ir"
)

func (g *generator) scope(scope *ast.Scope, body func()) {
	g.top = scope
	body()
	g.leaveRefs()
	g.top = scope.Parent
}

func (g *generator) block(entrance *ir.Block, exit *ir.Block, generate func()) {
	g.enter(exit)
	g.bl = entrance
	generate()
	g.autoFree()
	g.exit()
}

func (g *generator) id() string {
	id := fmt.Sprint(g.ctx.blockcount)
	g.ctx.blockcount++
	return id
}

func (g *generator) enter(bl *ir.Block) {
	g.bl.NewBr(bl)
	g.ctx.exits.Push(bl)
}

func (g *generator) exit() {
	exit := g.ctx.exits.Pop()
	if !g.breaks[g.bl] {
		g.bl.NewBr(exit)
	}
	g.bl = exit
}
