package main

import (
	"encoding/json"
	"fmt"
	"os"
	"strings"

	ns "novel-v1"
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

	sl := &ns.StoryLoader{}
	SetupDiceScript(sl)
	sl.Eval(v)
}
