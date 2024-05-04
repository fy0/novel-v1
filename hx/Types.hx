typedef StorySectionLine = {
	var pos:Array<Int>; // line, col, pos
	var type:String;

	// type: invoke 注: 这种情况下type置空，节省空间
	@:optional var name:String;
	@:optional var params:Array<String>;

	// type: code
	@:optional var code:String;
}

typedef StorySection = {
	var pos:Array<Int>; // line, col, pos
	var name:String;
	var lines:Array<StorySectionLine>;

	@:optional var condition:String;
	@:optional var next:String;
	var nextIndex:Int;
}

@:expose
class Story {
	public var name:String;
	public var items:Array<StorySection>;

	public function new(items:Array<StorySection>) {
		this.name = "";
		// this.items = new Array<StorySection>();
		this.items = items;
	}
}
