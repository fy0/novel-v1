package main

import (
	"encoding/json"
	"fmt"
	ns "novel-v1"
	"os"
	"strings"
)

func main() {
	d, _ := os.ReadFile("./test.ns")

	v, err := ns.ParseText(string(d))
	if err != nil {
		fmt.Println(err)
		return
	}

	x, _ := json.Marshal(strings.Split(string(d), "\n"))
	os.WriteFile("./out.json", x, 0644)

	sl := ns.StoryLoader{}
	sl.SetupDefault()
	sl.Eval(v)

	// json 解决不了问题，因为不能流式传输
	//x, _ := json.Marshal(v)
	//fmt.Println(err, string(x))
}
