package novelscript

import "fmt"

func ParseText(d string) (*Story, error) {
	p := newParser("", []byte(d+"\n"))
	v, err := p.parse(g)

	s := v.(*Story)
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
