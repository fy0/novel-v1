package novelscript

import (
	"fmt"
)

func ParseText(d string) (*Story, error) {
	p := newParser("", []byte(d+"\n"))
	//p.recover = false
	v, err := p.parse(g)

	if err != nil {
		return nil, err
	}

	s := v.(*Story)
	for _, i := range s.Items {
		// 检查最后有多少\n
		cur := len(i.Lines) - 1
		for cur >= 0 && i.Lines[cur].Type == "" && i.Lines[cur].Text == "\n" {
			cur -= 1
		}
		if cur == -1 {
			// 这一节全是回车
			i.Lines = []*StorySectionLine{}
		} else {
			// 最后一条指令是文本，就保留\n
			if i.Lines[cur].Type == "" || i.Lines[cur].Type == "codeInText" {
				i.Lines = i.Lines[:cur+2]
			} else {
				i.Lines = i.Lines[:cur+1]
			}
		}
	}

	//for _, sec := range s.Items {
	//	fmt.Println("分段", sec.Name, "pos", sec.Pos)
	//	for _, i := range sec.Lines {
	//		a, _ := json.Marshal(i)
	//		fmt.Println(string(a))
	//	}
	//}
	//fmt.Println("\n")

	for _, i := range s.Items {
		if i.Next == "" {
			continue
		}

		if index, ok := p.cur.data.Name2Index[i.Next]; ok {
			i.NextIndex = index
		} else {
			return nil, fmt.Errorf("line %d: section `%s` not defined", i.Pos[0], i.Next)
		}
	}

	return s, err
}
