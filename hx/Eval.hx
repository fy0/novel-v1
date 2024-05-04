import haxe.Exception;
import Types.StorySection;
import Types.Story;
import Macro;

@:expose
class StoryLoader {
	public var invokeCallback:(sl:StoryLoader, name:String, params:Array<String>) -> Bool;
	public var codeCallback:(sl:StoryLoader, code:String) -> Bool;

	public var debug:Bool;
	public var curLine:Int;

	public function new() {
		debug = false;
		curLine = 0;
	}

	public function parse(s:String):Story {
		var p = new NovelPeg.Parser('', s + '\n', []);
		var s = cast(p.parse(NovelPeg.g), Types.Story);

		for (i in s.items) {
			if (i.next == "" || i.next == null) {
				continue;
			}

			if (p.cur.data.name2Index.exists(i.next)) {
				i.nextIndex = p.cur.data.name2Index.get(i.next);
			} else {
				throw new Exception('line ${i.pos[0]}: section `${i.next}` not defined');
			}
		}
		return s;
	}

	public function eval(s:Story):Int {
		return async(() -> {
			var curIndex:Int = 0;

			while (true) {
				if (curIndex < 0 || curIndex >= s.items.length) {
					break;
				}

				var i:StorySection = s.items[curIndex];
				this.curLine = i.pos[0];

				if (this.debug) {
					var nodeName:String = i.name;
					if (nodeName == null || nodeName == "") {
						nodeName = "<noname>";
					}
					trace("node:", nodeName);
				}

				if (i.condition != null && i.condition != "") {
					if (this.codeCallback != null) {
						var valid = await(this.codeCallback(this, i.condition));
						if (!valid) {
							curIndex += 1; // 匹配失败，顺序向下
							continue;
						}
					}
				}

				for (line in i.lines) {
					switch (line.type) {
						case "":
							if (this.debug) {
								trace("line - invoke", line.name, line.params);
							}
							if (!await(this.invokeCallback(this, line.name, line.params))) {
								trace('[Line ${line.pos[0]} Col ${line.pos[1]}] ERROR: invoke unsolved');
							}
						case "code":
							if (this.debug) {
								trace("line - code", line.code);
							}
							if (line.code != null) {
								await(this.codeCallback(this, line.code));
							}
					}
				}

				// 执行完成，到下一节点(有next则为next，无则相当于+1)
				curIndex = i.nextIndex;
			}
			return 0;
		})();
	}
}
