package sulfurc

import (
	"sulfur/src/checker"
	"sulfur/src/compiler"
	"sulfur/src/errors"
	"sulfur/src/lexer"
	"sulfur/src/parser"
	"sulfur/src/utils"
)

func Compile(input, output string) {
	name := utils.FileName(input)

	code, err := lexer.GetSourceCode(input)
	if err != nil {
		utils.Panic(err)
	}

	errors.Errors = errors.NewErrorGenerator(code)

	errors.Step = errors.Lexing
	unfiltered := lexer.Lex(code)
	utils.AttemptSave(func() error {
		return lexer.Save(unfiltered, "debug/unfiltered.txt")
	})

	tokens := lexer.Filter(unfiltered)
	utils.AttemptSave(func() error {
		return lexer.Save(tokens, "debug/tokens.txt")
	})

	errors.Step = errors.Parsing
	ast := parser.Parse(code, tokens)
	utils.AttemptSave(func() error {
		return parser.Save(ast, 1, "debug/ast.json")
	})

	errors.Step = errors.Inferring
	props := checker.TypeCheck(ast)

	errors.Step = errors.Generating
	llcode := compiler.Generate(ast, props, input)
	utils.ForceSave(func() error {
		return compiler.Save("; ModuleID = '"+input+"'\n"+llcode, "tmp/"+name+".ll")
	})

	utils.Exec("bash", utils.Absolute()+"/compile.sh", name)

	Execute(name, output)
}
