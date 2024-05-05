import haxe.Exception;
import Types.StorySection;
import Types.Story;
import Macro;

@:expose
class StoryLoader {
	// public var invokeCallback:(sl:StoryLoader, name:String, params:Array<String>) -> Bool;
	public var textCallback:(sl:StoryLoader, text:String) -> Any;
	public var codeCallback:(sl:StoryLoader, code:String, returnAs:String) -> Any;

	public var debug:Bool;
	public var curLine:Int;

	public function new() {
		debug = false;
		curLine = 0;
	}

	public function parse(s:String):Story {
		var p = new NovelPeg.Parser('', s + '\n', []);
		var s = cast(p.parse(NovelPeg.g), Types.Story);

		// 处理一下section末尾
		for (i in s.items) {
			// 检查最后有多少\n
			var cur = i.lines.length - 1;
			while (cur >= 0 && i.lines[cur].type == "" && i.lines[cur].text == "\n") {
				cur--;
			}
			if (cur == -1) {
				// 这一节全是回车
				i.lines = [];
			} else {
				// 最后一条指令是文本，就保留\n
				if (i.lines[cur].type == "" || i.lines[cur].type == "codeInText") {
					i.lines = i.lines.slice(0, cur + 2);
				} else {
					i.lines = i.lines.slice(0, cur + 1);
				}
			}
		}

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
						var valid = await(this.codeCallback(this, i.condition, 'bool'));
						if (!cast(valid, Bool)) {
							curIndex += 1; // 匹配失败，顺序向下
							continue;
						}
					}
				}

				for (line in i.lines) {
					switch (line.type) {
						case "":
							if (this.debug) {
								trace("line - text", line.text);
							}
							await(this.textCallback(this, line.text));
						case "codeBlock", "codeInText":
							if (this.debug) {
								trace("line - code", line.code);
							}
							var returnAs = "any";
							if (line.type == 'codeInText') {
								returnAs = "string";
							}
							var ret = await(this.codeCallback(this, line.code, returnAs));

							if (line.type == 'codeInText') {
								await(this.textCallback(this, '${ret}'));
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
