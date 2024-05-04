import Eval.StoryLoader;
import Macro;

function main() {
	#if !js
	demo();
	#end
}

function demo() {
	var sl = new StoryLoader();
	var r = sl.parse("
:第一段
这是第一段文本11

:第二段
这是第二段文本

想写几行写几行33
   任何格式都会原样输出

:第三段
结束");

	sl.invokeCallback = async(function(sl:StoryLoader, name:String, params:Array<String>) {
		// trace(name, params);
		switch (name) {
			case "sayRaw":
				trace(sl.curLine, params[0]);
				return true;
		}
		return true;
	});

	sl.codeCallback = async(function(sl:StoryLoader, name:String) {
		// 这里没法真的运行代码，只是一个测试
		// trace(name, params);
		return true;
	});

	sl.eval(r);
	trace(r.items.length);
}
