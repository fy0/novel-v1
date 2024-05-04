import haxe.macro.Context;
import haxe.macro.Expr;

macro inline function async(e:Expr) {
	if (Context.defined("js")) {
		return macro @:pos(e.pos) js.Syntax.code("(async {0})", ${e});
	} else {
		return e;
	}
}

macro inline function await(e:Expr) {
	if (Context.defined("js")) {
		return macro @:pos(e.pos) js.Syntax.code("(await {0})", ${e});
	} else {
		return e;
	}
}
