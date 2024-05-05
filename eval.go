package novelscript

import (
	"fmt"
)

type StoryLoader struct {
	Debug bool

	TextCallback func(sl *StoryLoader, text string, line, col int) error
	CodeCallback func(sl *StoryLoader, code string, returnAs string) (any, error) // returnAs: bool, string, any

	//InvokeCallback func(sl *StoryLoader, name string, params []string) (bool, error)
	SelectOverride func(choices []string, resolve func(val int))

	Error   error
	CurLine int
}

func (sl *StoryLoader) Eval(s *Story) {
	var curIndex int

ForLoop:
	for {
		if curIndex < 0 || curIndex >= len(s.Items) {
			break
		}

		i := s.Items[curIndex]
		sl.CurLine = i.Pos[0]

		if sl.Debug {
			nodeName := i.Name
			if nodeName == "" {
				nodeName = "<noname>"
			}
			fmt.Println("node: ", nodeName)
		}

		if i.Condition != "" {
			if sl.CodeCallback != nil {
				var valid any
				valid, sl.Error = sl.CodeCallback(sl, i.Condition, "bool")
				if sl.Error != nil {
					break
				}

				if valid == false {
					curIndex += 1 // 匹配失败，顺序向下
					continue
				}
			}
		}

		for _, line := range i.Lines {
			switch line.Type {
			case "": // text
				if sl.Debug {
					fmt.Printf("line - text %v\n", line.Text)
				}
				sl.TextCallback(sl, line.Text, line.Pos[0], line.Pos[1])

			case "codeBlock", "codeInText":
				if sl.Debug {
					fmt.Println("line - code", line.Code)
				}

				returnAs := "any"
				if line.Type == "codeInText" {
					returnAs = "string"
				}

				var ret any
				ret, sl.Error = sl.CodeCallback(sl, line.Code, returnAs)
				if sl.Error != nil {
					break ForLoop
				}

				if line.Type == "codeInText" {
					sl.TextCallback(sl, fmt.Sprintf("%v", ret), line.Pos[0], line.Pos[1])
				}
			}
		}

		// 执行完成，到下一节点(有next则为next，无则相当于+1)
		curIndex = i.NextIndex
	}

	if sl.Error != nil {
		fmt.Println(sl.Error)
	}
}

func (sl *StoryLoader) EvalAsync(s *Story) {
	go sl.Eval(s)
}
