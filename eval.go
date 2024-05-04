package novelscript

import (
	"fmt"
)

type StoryLoader struct {
	Debug             bool
	InvokeCallback    func(sl *StoryLoader, name string, params []string) (bool, error)
	CodeCallback      func(sl *StoryLoader, expr string) (any, error)
	ConditionCallback func(sl *StoryLoader, expr string) (bool, error)

	PrintOverride  func(s string, lineEnd bool, speedMicroSecond int)
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
			if sl.ConditionCallback != nil {
				var valid bool
				valid, sl.Error = sl.ConditionCallback(sl, i.Condition)
				if sl.Error != nil {
					break
				}

				if !valid {
					curIndex += 1 // 匹配失败，顺序向下
					continue
				}
			}
		}

		for _, line := range i.Lines {
			switch line.Type {
			case "":
				if sl.Debug {
					fmt.Println("line - invoke", line.Name, line.Params)
				}
				var solved bool
				if sl.InvokeCallback != nil {
					solved, sl.Error = sl.InvokeCallback(sl, line.Name, line.Params)
					if sl.Error != nil {
						break ForLoop
					}
				}
				if !solved {
					fmt.Printf("[Line %d Col %d] ERROR: invoke unsolved: %s\n", line.Pos[0], line.Pos[1], line.Name)
				}

			case "code":
				if sl.Debug {
					fmt.Println("line - code", line.Code)
				}

				_, sl.Error = sl.CodeCallback(sl, line.Code)
				if sl.Error != nil {
					break ForLoop
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
