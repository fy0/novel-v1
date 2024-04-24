package novelscript

import (
	"errors"
	"fmt"
	"strconv"
	"strings"
	"time"

	ds "github.com/sealdice/dicescript"
)

func (sl *StoryLoader) SetupDefault() {
	vm := ds.NewVM()

	scope := map[string]*ds.VMValue{}
	player := ds.VMValueNewDict(nil)
	player.Store("力量", ds.VMValueNewInt(50))
	player.Store("敏捷", ds.VMValueNewInt(60))
	player.Store("智力", ds.VMValueNewInt(70))
	scope["player"] = player.V()

	scope["trace"] = ds.VMValueNewNativeFunction(&ds.NativeFunctionData{
		Name:   "trace",
		Params: []string{"arg"},
		NativeFunc: func(ctx *ds.Context, this *ds.VMValue, params []*ds.VMValue) *ds.VMValue {
			fmt.Printf("[trace][L%d] %s", sl.CurLine, params[0].ToString())
			return nil
		},
	})

	vm.GlobalValueLoadFunc = func(name string) *ds.VMValue {
		if val, ok := scope[name]; ok {
			return val
		}
		return nil
	}

	defaultInvokeCallback := func(sl *StoryLoader, name string, params []string) (bool, error) {
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
		if sl.PrintOverride != nil {
			doPrint = sl.PrintOverride
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
					if err == nil && choice > 0 && choice <= int64(len(params)) {
						break
					}
				}
			}

			return int(choice)
		}

		doSelect := doSelectTerminal
		if sl.SelectOverride != nil {
			doSelect = func(choices []string) int {
				x := make(chan int, 1)

				resolve := func(val int) {
					go func() {
						x <- val
					}()
				}

				sl.SelectOverride(choices, resolve)

				v2 := <-x
				return v2
			}
		}

		switch name {
		case "sayRaw":
			doPrint(strings.TrimSpace(params[0]), true, 0)
			return true, nil

		case "say":
			err := vm.Run(params[0])
			if err != nil {
				return false, err
			}

			doPrint(vm.Ret.ToString(), true, 0)
			return true, nil

		case "select":
			var choices []string
			for _, i := range params {
				err := vm.Run(i)
				if err != nil {
					return false, err
				}

				choices = append(choices, vm.Ret.ToString())
			}

			choice := doSelect(choices)

			doPrint(fmt.Sprintf("你选择了: %d", choice), true, 30)
			vm.StoreName("val", ds.VMValueNewInt(ds.IntType(choice)))
			return true, nil

		case "input":
			line := ""
			if len(params) > 0 {
				line = params[0]
			}
			doPrint(line, false, 70)
			var val string
			fmt.Scanln(&val)
			return true, nil
		}

		// 执行函数
		code := fmt.Sprintf("%s(%s)", name, strings.Join(params, ","))
		err := vm.Run(code)
		if err != nil {
			return false, err
		}
		return true, nil
	}

	sl.InvokeCallback = defaultInvokeCallback

	sl.ConditionCallback = func(sl *StoryLoader, expr string) (bool, error) {
		err := vm.Run(expr)
		if err != nil {
			sl.Error = err
			return false, sl.Error
		}
		return vm.Ret.AsBool(), nil
	}

	sl.CodeCallback = func(sl *StoryLoader, expr string) (any, error) {
		err := vm.Run(expr)
		if err != nil {
			sl.Error = err
			return false, sl.Error
		}
		if vm.RestInput != "" {
			return nil, errors.New("无法读取的代码块: " + vm.RestInput)
		}

		return vm.Ret, nil
	}
}
