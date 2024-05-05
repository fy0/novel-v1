package novelscript

type Story struct {
	Name  string          `json:"name"`
	Items []*StorySection `json:"items"`
}

type StorySection struct {
	Pos       []int               `json:"pos"` // line, col, pos
	Name      string              `json:"name"`
	Lines     []*StorySectionLine `json:"lines"`
	Condition string              `json:"cond,omitempty"`
	Next      string              `json:"next,omitempty"`

	NextIndex int `json:"nextIndex"` // 若为0，是下一个，若不为零，是指定的index，X表示Execute
}

type StorySectionLine struct {
	Pos  []int  `json:"pos"` // line, col, pos
	Type string `json:"type,omitempty"`

	// type: text 文本，注: 这种情况下type置空，节省空间
	Text string `json:"text,omitempty"`

	// type: invoke
	Name   string   `json:"name,omitempty"`
	Params []string `json:"params,omitempty"`

	// type: code 代码
	Code string `json:"code,omitempty"`
}
