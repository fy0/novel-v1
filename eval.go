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

	//vm      *ds.Context // 这里思路有点混乱，上面Callback和这个vm的存在是冲突的
	Error   error
	CurLine int
}

func (sl *StoryLoader) Eval(s *Story) {
	var start *StoryNode
	nameMap := map[string]*StoryNode{}
	var lastNode *StoryNode
	flowMap := map[*StoryNode]*StoryNode{}

	// 处理顺序节点
	for index, i := range s.Items {
		item := s.Items[index]
		if start == nil {
			start = s.Items[index]
		}

		if i.Name != "" {
			nameMap[i.Name] = s.Items[index]
		}

		flowMap[lastNode] = item
		lastNode = item
	}

	// 处理跳转节点
	flowMapOverride := map[*StoryNode]*StoryNode{}
	for index, _ := range s.Items {
		item := s.Items[index]

		if x := nameMap[item.Next]; x != nil {
			flowMapOverride[item] = x
		}
	}

	i := start
	for {
		if i == nil {
			break
		}
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
					goto _end
				}

				if !valid {
					i = flowMap[i] // 匹配失败，跳转下一个节点
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
						goto _end
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
					goto _end
				}
			}
		}

		if x := flowMapOverride[i]; x != nil {
			i = x
		} else {
			i = flowMap[i]
		}
		continue
	_end:
		break
	}

	if sl.Error != nil {
		fmt.Println(sl.Error)
	}
}

func (sl *StoryLoader) EvalAsync(s *Story) {
	go sl.Eval(s)
}

func ParseText(d string) (*Story, error) {
	v, err := Parse("", []byte(d+"\n"))
	if v == nil {
		return nil, err
	}
	return v.(*Story), err
}
