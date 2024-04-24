//go:build js
// +build js

package main

import (
	"errors"
	"fmt"

	"github.com/gopherjs/gopherjs/js"
	ns "novel-v1"
)

func main() {
	diceModule := map[string]interface{}{
		"test": func(text string) *js.Object {
			v, err := ns.ParseText(text)
			if err != nil {
				fmt.Println(err)
				return nil
			}
			sl := ns.StoryLoader{}
			sl.SetupDefault()
			sl.Eval(v)
			return nil
		},
		"invokeOverride": func(s *ns.StoryLoader, x func(name string, params []string) (bool, bool)) {
			oldInvoke := s.InvokeCallback
			s.InvokeCallback = func(sl *ns.StoryLoader, _name string, _params []string) (bool, error) {
				ok, next := x(_name, _params)
				if next {
					return oldInvoke(sl, _name, _params)
				}
				return ok, nil
			}
		},
		"retWrap": func(ok bool, errInfo string) (bool, error) {
			if errInfo != "" {
				return ok, errors.New(errInfo)
			}
			return ok, nil
		},
		"parseText": func(text string) *js.Object {
			v, err := ns.ParseText(text)
			if err != nil {
				fmt.Println(err)
				return nil
			}
			return js.MakeFullWrapper(v)
		},
		"newLoader": func() *js.Object {
			sl := ns.StoryLoader{}
			sl.SetupDefault()
			return js.MakeFullWrapper(&sl)
		},
		"help": "此项目的js绑定: https://github.com/sealdice/dice",
	}

	js.Global.Set("ns", diceModule)
	//js.Module.Get("exports").Set("ns", diceModule)
}
