package main

import (
	"errors"
	"fmt"
	"strconv"
	"time"

	ds "github.com/sealdice/dicescript"
	ns "novel-v1"
)

func SetupDiceScript(sl *ns.StoryLoader) {
	vm := ds.NewVM()

	scope := map[string]*ds.VMValue{}
	player := ds.VMValueNewDict(nil)
	player.Store("力量", ds.VMValueNewInt(50))
	scope["player"] = player.V()
	scope["测试"] = ds.VMValueNewStr("12345")

	scope["trace"] = ds.VMValueNewNativeFunction(&ds.NativeFunctionData{
		Name:   "trace",
		Params: []string{"arg"},
		NativeFunc: func(ctx *ds.Context, this *ds.VMValue, params []*ds.VMValue) *ds.VMValue {
			fmt.Printf("[trace][L%d] %s", sl.CurLine, params[0].ToString())
			return nil
		},
	})

	doPrintTerminal := func(s string, lineEnd bool, speedMicroSecond int) {
		if speedMicroSecond == 0 {
			speedMicroSecond = 70
		}
		for _, i := range []rune(s) {
			fmt.Print(string(i))
			time.Sleep(time.Duration(speedMicroSecond) * time.Millisecond)
		}
		if lineEnd {
			fmt.Print("\n")
		}
	}

	doPrint := doPrintTerminal

	vm.GlobalValueLoadFunc = func(name string) *ds.VMValue {
		if val, ok := scope[name]; ok {
			return val
		}
		return nil
	}

	doSelectTerminal := func(choices []string) int {
		for index, text := range choices {
			doPrint(fmt.Sprintf("> [%d]%s", index+1, text), true, 30)
		}

		var choice int64
		for {
			doPrint("输入选项序号:", false, 30)
			var val string
			read, _ := fmt.Scanln(&val)
			if read > 0 {
				var err error
				choice, err = strconv.ParseInt(val, 10, 64)
				if err == nil && choice > 0 && choice <= int64(len(choices)) {
					break
				}
			}
		}

		return int(choice)
	}

	scope["select"] = ds.VMValueNewNativeFunction(&ds.NativeFunctionData{
		Name:   "select",
		Params: []string{"choices"},
		NativeFunc: func(ctx *ds.Context, this *ds.VMValue, params []*ds.VMValue) *ds.VMValue {
			var items []string
			//for _, i := range params {
			//	items = append(items, i.ToString())
			//}
			if params[0].TypeId == ds.VMTypeArray {
				// 暂时先缩水，不支持变长
				for _, i := range params[0].MustReadArray().List {
					items = append(items, i.ToString())
				}
			}
			choice := doSelectTerminal(items)
			doPrint(fmt.Sprintf("你选择了: %d", choice), true, 30)
			vm.StoreName("val", ds.VMValueNewInt(ds.IntType(choice)))
			return ds.VMValueNewInt(ds.IntType(choice))
		},
	})

	sl.TextCallback = func(sl *ns.StoryLoader, text string, line, col int) error {
		doPrint(text, false, 0)
		return nil
	}

	sl.CodeCallback = func(sl *ns.StoryLoader, expr string, returnAs string) (any, error) {
		err := vm.Run(expr)
		if err != nil {
			sl.Error = err
			return false, sl.Error
		}
		if vm.RestInput != "" {
			return nil, errors.New("无法读取的代码块: " + vm.RestInput)
		}

		switch returnAs {
		case "bool":
			return vm.Ret.AsBool(), nil
		case "string":
			return vm.Ret.ToString(), nil
		default:
			return vm.Ret, nil
		}
	}
}
