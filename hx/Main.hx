import haxe.Json;
import Eval.StoryLoader;
import Macro;

function main() {
	#if !js
	demo();
	#end
}

#if !js
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
结束
");

	// for (x in r.items) {
	// 	trace('分段: ', x.name);
	// 	for (j in x.lines) {
	// 		trace(Json.stringify(j));
	// 	}
	// }

	sl.textCallback = async(function(sl:StoryLoader, text:String) {
		Sys.print(text);
		return null;
	});

	sl.codeCallback = async(function(sl:StoryLoader, name:String, returnAs:String) {
		// 这里没法真的运行代码，只是一个测试
		// trace(name, params);
		return true;
	});

	sl.eval(r);
}
#end
