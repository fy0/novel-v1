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

macro function makeESM() {
	if (Context.defined("js")) {
		Context.onAfterGenerate(() -> {
			var outFile = haxe.macro.Compiler.getOutput();
			var output = sys.io.File.getContent(outFile);

			var header = "(function ($hx_exports, $global) { \"use strict\";";
			var headerNew = 'var exports = {};\n' + header;
			var headerStart = output.indexOf(header);
			if (headerStart == -1)
				trace("ERROR: Can't generate esm because header string is not found");
			else
				output = output.substring(0, headerStart) + headerNew + output.substring(headerStart + header.length);

			var footer = "})(typeof exports != \"undefined\" ? exports : typeof window != \"undefined\" ? window : typeof self != \"undefined\" ? self : this, typeof window != \"undefined\" ? window : typeof global != \"undefined\" ? global : typeof self != \"undefined\" ? self : this);";
			var footerNew = '})(exports);\nexport default exports;';
			var footerStart = output.indexOf(footer, output.length - 500);
			if (footerStart == -1)
				trace("ERROR: Can't generate esm because footer string is not found");
			else
				output = output.substring(0, footerStart) + footerNew + output.substring(footerStart + footer.length);

			sys.io.File.saveContent(outFile, output);
			// trace("ESM module rewrite is done.");
		});
	}

	return {expr: EConst(CString("", SingleQuotes)), pos: Context.makePosition({file: '', min: 0, max: 0})};
}
