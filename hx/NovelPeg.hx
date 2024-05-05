// Code is generated; DO NOT EDIT.
import haxe.Exception;
import haxe.ds.GenericStack;
import haxe.io.BytesBuffer;
import haxe.io.Bytes;
import haxe.ds.HashMap;
import haxe.iterators.StringIteratorUnicode;

class ParserCustomData {
	public var curIndex = 0;
	public var name2Index = new Map<String, Int>();

	public function new() {}

	public function getNextIndex():Int {
		// 如果我是第0段，那next是1
		this.curIndex += 1;
		return this.curIndex;
	}

	public function setSectionIndex(name:Null<String>):Exception {
		if (name == "" || name == null) {
			return null;
		}
		if (this.name2Index.exists(name)) {
			return new Exception("section name must be unique");
		}
		this.name2Index[name] = this.curIndex;
		return null;
	}
}

function parseFilterNil(lines:Any):Array<Any> {
	var items:Array<Any> = [];
	if (Std.isOfType(lines, Array)) {
		var x:Array<Any> = cast lines;
		for (i in x) {
			if (i != null) {
				if (Std.isOfType(i, Array)) {
					for (j in parseFilterNil(i)) {
						items.push(j);
					}
				} else {
					items.push(i);
				}
			}
		}
	}
	return items;
}

function parseReturnTextSectionLine(c:Current, text:String) {
	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		type: "", // 作为最常见种类，故意置空，节省空间
		text: text,
	}, nil);
}

function parseReturnInvokeSectionLine(c:Current, name:String, params:Array<String>) {
	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		type: "invoke",
		name: name,
		params: params,
	}, nil);
}

function parseReturnCodeSectionLine(c:Current, typeName:String, code:String) {
	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		type: typeName,
		code: code,
	}, nil);
}

function gatherParams(first:Any, v:Any):Array<String> {
	if (v == null) {
		return null;
	}
	var items:Array<String> = [first];
	for (i in parseFilterNil(v)) {
		items.push(i);
	}
	return items;
}

var retWrap = (a:Any, err:Exception) -> {val: a, err: err};
var toStr = (x:String) -> x;
var toStrWithTrim = (x:String) -> StringTools.trim(x);
var nil = null;

var g:Grammar = {
	rules: [
		{
			name: "input",
			pos: {line: 188, col: 1, offset: 4188},
			expr: ActionExpr({
				pos: {line: 188, col: 10, offset: 4197},
				run: _calloninput1,
				expr: SeqExpr({
					pos: {line: 188, col: 10, offset: 4197},
					exprs: [
						ZeroOrMoreExpr({
							pos: {line: 406, col: 20, offset: 10846},
							expr: CharClassMatcher({
								pos: {line: 406, col: 20, offset: 10846},
								val: "[ \\n\\t\\r]",
								chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						LabeledExpr({
							pos: {line: 188, col: 13, offset: 4200},
							label: "x",
							expr: RuleRefExpr({
								pos: {line: 188, col: 15, offset: 4202},
								name: "nodes",
							}),
						}),
						NotExpr({
							pos: {line: 188, col: 21, offset: 4208},
							expr: AnyMatcher({
								line: 188,
								col: 22,
								offset: 4209,
							}),
						}),
					],
				}),
			}),
		},
		{
			name: "nodes",
			pos: {line: 192, col: 1, offset: 4248},
			expr: ActionExpr({
				pos: {line: 192, col: 10, offset: 4257},
				run: _callonnodes1,
				expr: LabeledExpr({
					pos: {line: 192, col: 10, offset: 4257},
					label: "nodes",
					expr: ZeroOrMoreExpr({
						pos: {line: 192, col: 17, offset: 4264},
						expr: RuleRefExpr({
							pos: {line: 192, col: 17, offset: 4264},
							name: "node",
						}),
					}),
				}),
			}),
		},
		{
			name: "_nodeCond",
			pos: {line: 206, col: 1, offset: 4573},
			expr: ActionExpr({
				pos: {line: 206, col: 14, offset: 4586},
				run: _callon_nodeCond1,
				expr: SeqExpr({
					pos: {line: 206, col: 14, offset: 4586},
					exprs: [
						LitMatcher({
							pos: {line: 206, col: 14, offset: 4586},
							val: "[",
							ignoreCase: false,
							want: "\"[\"",
						}),
						LabeledExpr({
							pos: {line: 206, col: 18, offset: 4590},
							label: "cond",
							expr: ZeroOrOneExpr({
								pos: {line: 206, col: 23, offset: 4595},
								expr: RuleRefExpr({
									pos: {line: 206, col: 23, offset: 4595},
									name: "CodeExpr2",
								}),
							}),
						}),
						LitMatcher({
							pos: {line: 206, col: 34, offset: 4606},
							val: "]",
							ignoreCase: false,
							want: "\"]\"",
						}),
					],
				}),
			}),
		},
		{
			name: "node",
			pos: {line: 209, col: 1, offset: 4713},
			expr: ChoiceExpr({
				pos: {line: 209, col: 9, offset: 4721},
				alternatives: [
					RuleRefExpr({
						pos: {line: 209, col: 9, offset: 4721},
						name: "nodeType1",
					}),
					RuleRefExpr({
						pos: {line: 209, col: 21, offset: 4733},
						name: "nodeType2",
					}),
				],
			}),
		},
		{
			name: "nodeType1",
			pos: {line: 211, col: 1, offset: 4746},
			expr: ActionExpr({
				pos: {line: 211, col: 14, offset: 4759},
				run: _callonnodeType11,
				expr: SeqExpr({
					pos: {line: 211, col: 14, offset: 4759},
					exprs: [
						LitMatcher({
							pos: {line: 211, col: 14, offset: 4759},
							val: ":",
							ignoreCase: false,
							want: "\":\"",
						}),
						ZeroOrMoreExpr({
							pos: {line: 408, col: 11, offset: 10870},
							expr: CharClassMatcher({
								pos: {line: 408, col: 11, offset: 10870},
								val: "[ \\t]",
								chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						LabeledExpr({
							pos: {line: 211, col: 25, offset: 4770},
							label: "name",
							expr: ZeroOrOneExpr({
								pos: {line: 211, col: 30, offset: 4775},
								expr: ActionExpr({
									pos: {line: 396, col: 15, offset: 10524},
									run: _callonnodeType18,
									expr: SeqExpr({
										pos: {line: 396, col: 15, offset: 10524},
										exprs: [
											CharClassMatcher({
												pos: {line: 401, col: 13, offset: 10630},
												val: "[_\\pL\\pOther_ID_Start]",
												chars: ['_'.charCodeAt(0),],
												ranges: [],
												classes: [Unicode.L, Unicode.Other_ID_Start,],
												ignoreCase: false,
												inverted: false,
											}),
											ZeroOrMoreExpr({
												pos: {line: 396, col: 24, offset: 10533},
												expr: CharClassMatcher({
													pos: {line: 404, col: 16, offset: 10747},
													val: "[\\pL\\pOther_ID_Start\\pNl\\pMn\\pMc\\pNd\\pPc\\pOther_ID_Continue]",
													chars: [],
													ranges: [],
													classes: [
														Unicode.L,
														Unicode.Other_ID_Start,
														Unicode.Nl,
														Unicode.Mn,
														Unicode.Mc,
														Unicode.Nd,
														Unicode.Pc,
														Unicode.Other_ID_Continue,
													],
													ignoreCase: false,
													inverted: false,
												}),
											}),
										],
									}),
								}),
							}),
						}),
						ZeroOrMoreExpr({
							pos: {line: 408, col: 11, offset: 10870},
							expr: CharClassMatcher({
								pos: {line: 408, col: 11, offset: 10870},
								val: "[ \\t]",
								chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						LabeledExpr({
							pos: {line: 211, col: 50, offset: 4795},
							label: "cond",
							expr: RuleRefExpr({
								pos: {line: 211, col: 55, offset: 4800},
								name: "_nodeCond",
							}),
						}),
						ZeroOrMoreExpr({
							pos: {line: 408, col: 11, offset: 10870},
							expr: CharClassMatcher({
								pos: {line: 408, col: 11, offset: 10870},
								val: "[ \\t]",
								chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						LabeledExpr({
							pos: {line: 211, col: 72, offset: 4817},
							label: "next",
							expr: ZeroOrOneExpr({
								pos: {line: 211, col: 77, offset: 4822},
								expr: ActionExpr({
									pos: {line: 207, col: 14, offset: 4655},
									run: _callonnodeType121,
									expr: SeqExpr({
										pos: {line: 207, col: 14, offset: 4655},
										exprs: [
											LitMatcher({
												pos: {line: 207, col: 14, offset: 4655},
												val: "[",
												ignoreCase: false,
												want: "\"[\"",
											}),
											LabeledExpr({
												pos: {line: 207, col: 18, offset: 4659},
												label: "name",
												expr: ActionExpr({
													pos: {line: 396, col: 15, offset: 10524},
													run: _callonnodeType125,
													expr: SeqExpr({
														pos: {line: 396, col: 15, offset: 10524},
														exprs: [
															CharClassMatcher({
																pos: {line: 401, col: 13, offset: 10630},
																val: "[_\\pL\\pOther_ID_Start]",
																chars: ['_'.charCodeAt(0),],
																ranges: [],
																classes: [Unicode.L, Unicode.Other_ID_Start,],
																ignoreCase: false,
																inverted: false,
															}),
															ZeroOrMoreExpr({
																pos: {line: 396, col: 24, offset: 10533},
																expr: CharClassMatcher({
																	pos: {line: 404, col: 16, offset: 10747},
																	val: "[\\pL\\pOther_ID_Start\\pNl\\pMn\\pMc\\pNd\\pPc\\pOther_ID_Continue]",
																	chars: [],
																	ranges: [],
																	classes: [
																		Unicode.L,
																		Unicode.Other_ID_Start,
																		Unicode.Nl,
																		Unicode.Mn,
																		Unicode.Mc,
																		Unicode.Nd,
																		Unicode.Pc,
																		Unicode.Other_ID_Continue,
																	],
																	ignoreCase: false,
																	inverted: false,
																}),
															}),
														],
													}),
												}),
											}),
											LitMatcher({
												pos: {line: 207, col: 34, offset: 4675},
												val: "]",
												ignoreCase: false,
												want: "\"]\"",
											}),
										],
									}),
								}),
							}),
						}),
						ZeroOrMoreExpr({
							pos: {line: 408, col: 11, offset: 10870},
							expr: CharClassMatcher({
								pos: {line: 408, col: 11, offset: 10870},
								val: "[ \\t]",
								chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						ZeroOrOneExpr({
							pos: {line: 411, col: 8, offset: 10901},
							expr: LitMatcher({
								pos: {line: 411, col: 8, offset: 10901},
								val: "\r",
								ignoreCase: false,
								want: "\"\\r\"",
							}),
						}),
						LitMatcher({
							pos: {line: 411, col: 14, offset: 10907},
							val: "\n",
							ignoreCase: false,
							want: "\"\\n\"",
						}),
						LabeledExpr({
							pos: {line: 211, col: 100, offset: 4845},
							label: "lines",
							expr: RuleRefExpr({
								pos: {line: 211, col: 106, offset: 4851},
								name: "nodeLines",
							}),
						}),
					],
				}),
			}),
		},
		{
			name: "nodeType2",
			pos: {line: 246, col: 1, offset: 5760},
			expr: ActionExpr({
				pos: {line: 246, col: 14, offset: 5773},
				run: _callonnodeType21,
				expr: SeqExpr({
					pos: {line: 246, col: 14, offset: 5773},
					exprs: [
						LitMatcher({
							pos: {line: 246, col: 14, offset: 5773},
							val: ":",
							ignoreCase: false,
							want: "\":\"",
						}),
						ZeroOrMoreExpr({
							pos: {line: 408, col: 11, offset: 10870},
							expr: CharClassMatcher({
								pos: {line: 408, col: 11, offset: 10870},
								val: "[ \\t]",
								chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						LabeledExpr({
							pos: {line: 246, col: 25, offset: 5784},
							label: "name",
							expr: ZeroOrOneExpr({
								pos: {line: 246, col: 30, offset: 5789},
								expr: ActionExpr({
									pos: {line: 396, col: 15, offset: 10524},
									run: _callonnodeType28,
									expr: SeqExpr({
										pos: {line: 396, col: 15, offset: 10524},
										exprs: [
											CharClassMatcher({
												pos: {line: 401, col: 13, offset: 10630},
												val: "[_\\pL\\pOther_ID_Start]",
												chars: ['_'.charCodeAt(0),],
												ranges: [],
												classes: [Unicode.L, Unicode.Other_ID_Start,],
												ignoreCase: false,
												inverted: false,
											}),
											ZeroOrMoreExpr({
												pos: {line: 396, col: 24, offset: 10533},
												expr: CharClassMatcher({
													pos: {line: 404, col: 16, offset: 10747},
													val: "[\\pL\\pOther_ID_Start\\pNl\\pMn\\pMc\\pNd\\pPc\\pOther_ID_Continue]",
													chars: [],
													ranges: [],
													classes: [
														Unicode.L,
														Unicode.Other_ID_Start,
														Unicode.Nl,
														Unicode.Mn,
														Unicode.Mc,
														Unicode.Nd,
														Unicode.Pc,
														Unicode.Other_ID_Continue,
													],
													ignoreCase: false,
													inverted: false,
												}),
											}),
										],
									}),
								}),
							}),
						}),
						ZeroOrMoreExpr({
							pos: {line: 408, col: 11, offset: 10870},
							expr: CharClassMatcher({
								pos: {line: 408, col: 11, offset: 10870},
								val: "[ \\t]",
								chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						ZeroOrOneExpr({
							pos: {line: 411, col: 8, offset: 10901},
							expr: LitMatcher({
								pos: {line: 411, col: 8, offset: 10901},
								val: "\r",
								ignoreCase: false,
								want: "\"\\r\"",
							}),
						}),
						LitMatcher({
							pos: {line: 411, col: 14, offset: 10907},
							val: "\n",
							ignoreCase: false,
							want: "\"\\n\"",
						}),
						LabeledExpr({
							pos: {line: 246, col: 53, offset: 5812},
							label: "lines",
							expr: RuleRefExpr({
								pos: {line: 246, col: 59, offset: 5818},
								name: "nodeLines",
							}),
						}),
					],
				}),
			}),
		},
		{
			name: "nodeLines",
			pos: {line: 275, col: 1, offset: 6563},
			expr: ActionExpr({
				pos: {line: 275, col: 14, offset: 6576},
				run: _callonnodeLines1,
				expr: SeqExpr({
					pos: {line: 275, col: 14, offset: 6576},
					exprs: [
						LabeledExpr({
							pos: {line: 275, col: 14, offset: 6576},
							label: "lines",
							expr: ZeroOrMoreExpr({
								pos: {line: 275, col: 20, offset: 6582},
								expr: RuleRefExpr({
									pos: {line: 275, col: 20, offset: 6582},
									name: "nodeLine",
								}),
							}),
						}),
						ZeroOrMoreExpr({
							pos: {line: 406, col: 20, offset: 10846},
							expr: CharClassMatcher({
								pos: {line: 406, col: 20, offset: 10846},
								val: "[ \\n\\t\\r]",
								chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
					],
				}),
			}),
		},
		{
			name: "nodeLine",
			pos: {line: 277, col: 1, offset: 6630},
			expr: ChoiceExpr({
				pos: {line: 277, col: 13, offset: 6642},
				alternatives: [
					ActionExpr({
						pos: {line: 279, col: 24, offset: 6725},
						run: _callonnodeLine2,
						expr: SeqExpr({
							pos: {line: 279, col: 24, offset: 6725},
							exprs: [
								LitMatcher({
									pos: {line: 279, col: 24, offset: 6725},
									val: "@#",
									ignoreCase: false,
									want: "\"@#\"",
								}),
								OneOrMoreExpr({
									pos: {line: 279, col: 32, offset: 6733},
									expr: SeqExpr({
										pos: {line: 279, col: 33, offset: 6734},
										exprs: [
											NotExpr({
												pos: {line: 279, col: 33, offset: 6734},
												expr: CharClassMatcher({
													pos: {line: 410, col: 7, offset: 10886},
													val: "[\\r\\n]",
													chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
													ranges: [],
													ignoreCase: false,
													inverted: false,
												}),
											}),
											AnyMatcher({
												line: 279,
												col: 37,
												offset: 6738,
											}),
										],
									}),
								}),
								CharClassMatcher({
									pos: {line: 410, col: 7, offset: 10886},
									val: "[\\r\\n]",
									chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
									ranges: [],
									ignoreCase: false,
									inverted: false,
								}),
								ZeroOrMoreExpr({
									pos: {line: 406, col: 20, offset: 10846},
									expr: CharClassMatcher({
										pos: {line: 406, col: 20, offset: 10846},
										val: "[ \\n\\t\\r]",
										chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
										ranges: [],
										ignoreCase: false,
										inverted: false,
									}),
								}),
							],
						}),
					}),
					RuleRefExpr({
						pos: {line: 277, col: 35, offset: 6664},
						name: "nodeLineType2",
					}),
					RuleRefExpr({
						pos: {line: 277, col: 51, offset: 6680},
						name: "nodeLineCommonText",
					}),
				],
			}),
		},
		{
			name: "nodeLineType2",
			pos: {line: 297, col: 1, offset: 7307},
			expr: ActionExpr({
				pos: {line: 297, col: 18, offset: 7324},
				run: _callonnodeLineType21,
				expr: SeqExpr({
					pos: {line: 297, col: 18, offset: 7324},
					exprs: [
						LitMatcher({
							pos: {line: 297, col: 18, offset: 7324},
							val: "@{",
							ignoreCase: false,
							want: "\"@{\"",
						}),
						LabeledExpr({
							pos: {line: 297, col: 23, offset: 7329},
							label: "code",
							expr: RuleRefExpr({
								pos: {line: 297, col: 28, offset: 7334},
								name: "Code",
							}),
						}),
						ChoiceExpr({
							pos: {line: 297, col: 34, offset: 7340},
							alternatives: [
								LitMatcher({
									pos: {line: 297, col: 34, offset: 7340},
									val: "}!",
									ignoreCase: false,
									want: "\"}!\"",
								}),
								LitMatcher({
									pos: {line: 297, col: 41, offset: 7347},
									val: "}",
									ignoreCase: false,
									want: "\"}\"",
								}),
							],
						}),
						ZeroOrMoreExpr({
							pos: {line: 408, col: 11, offset: 10870},
							expr: CharClassMatcher({
								pos: {line: 408, col: 11, offset: 10870},
								val: "[ \\t]",
								chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						ZeroOrOneExpr({
							pos: {line: 411, col: 8, offset: 10901},
							expr: LitMatcher({
								pos: {line: 411, col: 8, offset: 10901},
								val: "\r",
								ignoreCase: false,
								want: "\"\\r\"",
							}),
						}),
						LitMatcher({
							pos: {line: 411, col: 14, offset: 10907},
							val: "\n",
							ignoreCase: false,
							want: "\"\\n\"",
						}),
					],
				}),
			}),
		},
		{
			name: "nodeLineExprBlock",
			pos: {line: 328, col: 1, offset: 8198},
			expr: ActionExpr({
				pos: {line: 328, col: 22, offset: 8219},
				run: _callonnodeLineExprBlock1,
				expr: SeqExpr({
					pos: {line: 328, col: 22, offset: 8219},
					exprs: [
						LitMatcher({
							pos: {line: 328, col: 22, offset: 8219},
							val: "{",
							ignoreCase: false,
							want: "\"{\"",
						}),
						LabeledExpr({
							pos: {line: 328, col: 26, offset: 8223},
							label: "expr",
							expr: RuleRefExpr({
								pos: {line: 328, col: 31, offset: 8228},
								name: "CodeExpr",
							}),
						}),
						LitMatcher({
							pos: {line: 328, col: 40, offset: 8237},
							val: "}",
							ignoreCase: false,
							want: "\"}\"",
						}),
					],
				}),
			}),
		},
		{
			name: "nodeLineCommonText",
			pos: {line: 337, col: 1, offset: 8502},
			expr: ActionExpr({
				pos: {line: 337, col: 23, offset: 8524},
				run: _callonnodeLineCommonText1,
				expr: SeqExpr({
					pos: {line: 337, col: 23, offset: 8524},
					exprs: [
						NotExpr({
							pos: {line: 337, col: 23, offset: 8524},
							expr: CharClassMatcher({
								pos: {line: 337, col: 24, offset: 8525},
								val: "[:@]",
								chars: [':'.charCodeAt(0), '@'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						LabeledExpr({
							pos: {line: 337, col: 29, offset: 8530},
							label: "items",
							expr: ZeroOrMoreExpr({
								pos: {line: 337, col: 36, offset: 8537},
								expr: ChoiceExpr({
									pos: {line: 337, col: 38, offset: 8539},
									alternatives: [
										ActionExpr({
											pos: {line: 307, col: 17, offset: 7682},
											run: _callonnodeLineCommonText8,
											expr: LabeledExpr({
												pos: {line: 307, col: 17, offset: 7682},
												label: "items",
												expr: OneOrMoreExpr({
													pos: {line: 307, col: 24, offset: 7689},
													expr: ChoiceExpr({
														pos: {line: 307, col: 25, offset: 7690},
														alternatives: [
															ActionExpr({
																pos: {line: 305, col: 15, offset: 7567},
																run: _callonnodeLineCommonText12,
																expr: LitMatcher({
																	pos: {line: 305, col: 15, offset: 7567},
																	val: "\\{",
																	ignoreCase: false,
																	want: "\"\\\\{\"",
																}),
															}),
															ActionExpr({
																pos: {line: 306, col: 13, offset: 7616},
																run: _callonnodeLineCommonText14,
																expr: CharClassMatcher({
																	pos: {line: 306, col: 13, offset: 7616},
																	val: "[^\\r\\n{]",
																	chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0), '{'.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: true,
																}),
															}),
														],
													}),
												}),
											}),
										}),
										RuleRefExpr({
											pos: {line: 337, col: 53, offset: 8554},
											name: "nodeLineExprBlock",
										}),
									],
								}),
							}),
						}),
						ZeroOrOneExpr({
							pos: {line: 411, col: 8, offset: 10901},
							expr: LitMatcher({
								pos: {line: 411, col: 8, offset: 10901},
								val: "\r",
								ignoreCase: false,
								want: "\"\\r\"",
							}),
						}),
						LitMatcher({
							pos: {line: 411, col: 14, offset: 10907},
							val: "\n",
							ignoreCase: false,
							want: "\"\\n\"",
						}),
					],
				}),
			}),
		},
		{
			name: "Code",
			pos: {line: 425, col: 1, offset: 11395},
			expr: ActionExpr({
				pos: {line: 425, col: 9, offset: 11403},
				run: _callonCode1,
				expr: ZeroOrMoreExpr({
					pos: {line: 425, col: 9, offset: 11403},
					expr: ChoiceExpr({
						pos: {line: 425, col: 11, offset: 11405},
						alternatives: [
							OneOrMoreExpr({
								pos: {line: 425, col: 11, offset: 11405},
								expr: ChoiceExpr({
									pos: {line: 425, col: 13, offset: 11407},
									alternatives: [
										SeqExpr({
											pos: {line: 416, col: 21, offset: 11073},
											exprs: [
												LitMatcher({
													pos: {line: 416, col: 21, offset: 11073},
													val: "/*",
													ignoreCase: false,
													want: "\"/*\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 416, col: 26, offset: 11078},
													expr: SeqExpr({
														pos: {line: 416, col: 28, offset: 11080},
														exprs: [
															NotExpr({
																pos: {line: 416, col: 28, offset: 11080},
																expr: LitMatcher({
																	pos: {line: 416, col: 29, offset: 11081},
																	val: "*/",
																	ignoreCase: false,
																	want: "\"*/\"",
																}),
															}),
															AnyMatcher({
																line: 414,
																col: 15,
																offset: 11001,
															}),
														],
													}),
												}),
												LitMatcher({
													pos: {line: 416, col: 48, offset: 11100},
													val: "*/",
													ignoreCase: false,
													want: "\"*/\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 418, col: 22, offset: 11205},
											exprs: [
												NotExpr({
													pos: {line: 418, col: 22, offset: 11205},
													expr: LitMatcher({
														pos: {line: 418, col: 24, offset: 11207},
														val: "//{",
														ignoreCase: false,
														want: "\"//{\"",
													}),
												}),
												LitMatcher({
													pos: {line: 418, col: 31, offset: 11214},
													val: "//",
													ignoreCase: false,
													want: "\"//\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 418, col: 36, offset: 11219},
													expr: SeqExpr({
														pos: {line: 418, col: 38, offset: 11221},
														exprs: [
															NotExpr({
																pos: {line: 418, col: 38, offset: 11221},
																expr: CharClassMatcher({
																	pos: {line: 410, col: 7, offset: 10886},
																	val: "[\\r\\n]",
																	chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: false,
																}),
															}),
															AnyMatcher({
																line: 414,
																col: 15,
																offset: 11001,
															}),
														],
													}),
												}),
											],
										}),
										SeqExpr({
											pos: {line: 420, col: 22, offset: 11263},
											exprs: [
												LitMatcher({
													pos: {line: 420, col: 22, offset: 11263},
													val: "\"",
													ignoreCase: false,
													want: "\"\\\"\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 420, col: 26, offset: 11267},
													expr: ChoiceExpr({
														pos: {line: 420, col: 27, offset: 11268},
														alternatives: [
															LitMatcher({
																pos: {line: 420, col: 27, offset: 11268},
																val: "\\\"",
																ignoreCase: false,
																want: "\"\\\\\\\"\"",
															}),
															LitMatcher({
																pos: {line: 420, col: 34, offset: 11275},
																val: "\\\\",
																ignoreCase: false,
																want: "\"\\\\\\\\\"",
															}),
															CharClassMatcher({
																pos: {line: 420, col: 41, offset: 11282},
																val: "[^\"\\r\\n]",
																chars: ['"'.charCodeAt(0), '\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																ranges: [],
																ignoreCase: false,
																inverted: true,
															}),
														],
													}),
												}),
												LitMatcher({
													pos: {line: 420, col: 52, offset: 11293},
													val: "\"",
													ignoreCase: false,
													want: "\"\\\"\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 421, col: 21, offset: 11320},
											exprs: [
												LitMatcher({
													pos: {line: 421, col: 21, offset: 11320},
													val: "`",
													ignoreCase: false,
													want: "\"`\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 421, col: 25, offset: 11324},
													expr: CharClassMatcher({
														pos: {line: 421, col: 25, offset: 11324},
														val: "[^`]",
														chars: ['`'.charCodeAt(0),],
														ranges: [],
														ignoreCase: false,
														inverted: true,
													}),
												}),
												LitMatcher({
													pos: {line: 421, col: 31, offset: 11330},
													val: "`",
													ignoreCase: false,
													want: "\"`\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 422, col: 21, offset: 11357},
											exprs: [
												LitMatcher({
													pos: {line: 422, col: 21, offset: 11357},
													val: "'",
													ignoreCase: false,
													want: "\"'\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 422, col: 26, offset: 11362},
													expr: ChoiceExpr({
														pos: {line: 422, col: 27, offset: 11363},
														alternatives: [
															LitMatcher({
																pos: {line: 422, col: 27, offset: 11363},
																val: "\\'",
																ignoreCase: false,
																want: "\"\\\\'\"",
															}),
															LitMatcher({
																pos: {line: 422, col: 34, offset: 11370},
																val: "\\\\",
																ignoreCase: false,
																want: "\"\\\\\\\\\"",
															}),
															OneOrMoreExpr({
																pos: {line: 422, col: 41, offset: 11377},
																expr: CharClassMatcher({
																	pos: {line: 422, col: 41, offset: 11377},
																	val: "[^\\]",
																	chars: ['\''.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: true,
																}),
															}),
														],
													}),
												}),
												LitMatcher({
													pos: {line: 422, col: 49, offset: 11385},
													val: "'",
													ignoreCase: false,
													want: "\"'\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 425, col: 43, offset: 11437},
											exprs: [
												NotExpr({
													pos: {line: 425, col: 43, offset: 11437},
													expr: CharClassMatcher({
														pos: {line: 425, col: 44, offset: 11438},
														val: "[{}]",
														chars: ['{'.charCodeAt(0), '}'.charCodeAt(0),],
														ranges: [],
														ignoreCase: false,
														inverted: false,
													}),
												}),
												AnyMatcher({
													line: 414,
													col: 15,
													offset: 11001,
												}),
											],
										}),
									],
								}),
							}),
							SeqExpr({
								pos: {line: 425, col: 65, offset: 11459},
								exprs: [
									LitMatcher({
										pos: {line: 425, col: 65, offset: 11459},
										val: "{",
										ignoreCase: false,
										want: "\"{\"",
									}),
									RuleRefExpr({
										pos: {line: 425, col: 69, offset: 11463},
										name: "Code",
									}),
									LitMatcher({
										pos: {line: 425, col: 74, offset: 11468},
										val: "}",
										ignoreCase: false,
										want: "\"}\"",
									}),
								],
							}),
						],
					}),
				}),
			}),
		},
		{
			name: "CodeExpr",
			pos: {line: 426, col: 1, offset: 11516},
			expr: ActionExpr({
				pos: {line: 426, col: 13, offset: 11528},
				run: _callonCodeExpr1,
				expr: ZeroOrMoreExpr({
					pos: {line: 426, col: 13, offset: 11528},
					expr: ChoiceExpr({
						pos: {line: 426, col: 15, offset: 11530},
						alternatives: [
							OneOrMoreExpr({
								pos: {line: 426, col: 15, offset: 11530},
								expr: ChoiceExpr({
									pos: {line: 426, col: 16, offset: 11531},
									alternatives: [
										SeqExpr({
											pos: {line: 420, col: 22, offset: 11263},
											exprs: [
												LitMatcher({
													pos: {line: 420, col: 22, offset: 11263},
													val: "\"",
													ignoreCase: false,
													want: "\"\\\"\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 420, col: 26, offset: 11267},
													expr: ChoiceExpr({
														pos: {line: 420, col: 27, offset: 11268},
														alternatives: [
															LitMatcher({
																pos: {line: 420, col: 27, offset: 11268},
																val: "\\\"",
																ignoreCase: false,
																want: "\"\\\\\\\"\"",
															}),
															LitMatcher({
																pos: {line: 420, col: 34, offset: 11275},
																val: "\\\\",
																ignoreCase: false,
																want: "\"\\\\\\\\\"",
															}),
															CharClassMatcher({
																pos: {line: 420, col: 41, offset: 11282},
																val: "[^\"\\r\\n]",
																chars: ['"'.charCodeAt(0), '\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																ranges: [],
																ignoreCase: false,
																inverted: true,
															}),
														],
													}),
												}),
												LitMatcher({
													pos: {line: 420, col: 52, offset: 11293},
													val: "\"",
													ignoreCase: false,
													want: "\"\\\"\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 421, col: 21, offset: 11320},
											exprs: [
												LitMatcher({
													pos: {line: 421, col: 21, offset: 11320},
													val: "`",
													ignoreCase: false,
													want: "\"`\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 421, col: 25, offset: 11324},
													expr: CharClassMatcher({
														pos: {line: 421, col: 25, offset: 11324},
														val: "[^`]",
														chars: ['`'.charCodeAt(0),],
														ranges: [],
														ignoreCase: false,
														inverted: true,
													}),
												}),
												LitMatcher({
													pos: {line: 421, col: 31, offset: 11330},
													val: "`",
													ignoreCase: false,
													want: "\"`\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 422, col: 21, offset: 11357},
											exprs: [
												LitMatcher({
													pos: {line: 422, col: 21, offset: 11357},
													val: "'",
													ignoreCase: false,
													want: "\"'\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 422, col: 26, offset: 11362},
													expr: ChoiceExpr({
														pos: {line: 422, col: 27, offset: 11363},
														alternatives: [
															LitMatcher({
																pos: {line: 422, col: 27, offset: 11363},
																val: "\\'",
																ignoreCase: false,
																want: "\"\\\\'\"",
															}),
															LitMatcher({
																pos: {line: 422, col: 34, offset: 11370},
																val: "\\\\",
																ignoreCase: false,
																want: "\"\\\\\\\\\"",
															}),
															OneOrMoreExpr({
																pos: {line: 422, col: 41, offset: 11377},
																expr: CharClassMatcher({
																	pos: {line: 422, col: 41, offset: 11377},
																	val: "[^\\]",
																	chars: ['\''.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: true,
																}),
															}),
														],
													}),
												}),
												LitMatcher({
													pos: {line: 422, col: 49, offset: 11385},
													val: "'",
													ignoreCase: false,
													want: "\"'\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 426, col: 36, offset: 11551},
											exprs: [
												NotExpr({
													pos: {line: 426, col: 36, offset: 11551},
													expr: CharClassMatcher({
														pos: {line: 426, col: 37, offset: 11552},
														val: "[{}]",
														chars: ['{'.charCodeAt(0), '}'.charCodeAt(0),],
														ranges: [],
														ignoreCase: false,
														inverted: false,
													}),
												}),
												AnyMatcher({
													line: 414,
													col: 15,
													offset: 11001,
												}),
											],
										}),
									],
								}),
							}),
							SeqExpr({
								pos: {line: 426, col: 57, offset: 11572},
								exprs: [
									LitMatcher({
										pos: {line: 426, col: 57, offset: 11572},
										val: "{",
										ignoreCase: false,
										want: "\"{\"",
									}),
									RuleRefExpr({
										pos: {line: 426, col: 61, offset: 11576},
										name: "CodeExpr",
									}),
									LitMatcher({
										pos: {line: 426, col: 70, offset: 11585},
										val: "}",
										ignoreCase: false,
										want: "\"}\"",
									}),
								],
							}),
						],
					}),
				}),
			}),
		},
		{
			name: "CodeExpr2",
			pos: {line: 427, col: 1, offset: 11633},
			expr: ActionExpr({
				pos: {line: 427, col: 14, offset: 11646},
				run: _callonCodeExpr21,
				expr: ZeroOrMoreExpr({
					pos: {line: 427, col: 14, offset: 11646},
					expr: ChoiceExpr({
						pos: {line: 427, col: 16, offset: 11648},
						alternatives: [
							OneOrMoreExpr({
								pos: {line: 427, col: 16, offset: 11648},
								expr: ChoiceExpr({
									pos: {line: 427, col: 17, offset: 11649},
									alternatives: [
										SeqExpr({
											pos: {line: 420, col: 22, offset: 11263},
											exprs: [
												LitMatcher({
													pos: {line: 420, col: 22, offset: 11263},
													val: "\"",
													ignoreCase: false,
													want: "\"\\\"\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 420, col: 26, offset: 11267},
													expr: ChoiceExpr({
														pos: {line: 420, col: 27, offset: 11268},
														alternatives: [
															LitMatcher({
																pos: {line: 420, col: 27, offset: 11268},
																val: "\\\"",
																ignoreCase: false,
																want: "\"\\\\\\\"\"",
															}),
															LitMatcher({
																pos: {line: 420, col: 34, offset: 11275},
																val: "\\\\",
																ignoreCase: false,
																want: "\"\\\\\\\\\"",
															}),
															CharClassMatcher({
																pos: {line: 420, col: 41, offset: 11282},
																val: "[^\"\\r\\n]",
																chars: ['"'.charCodeAt(0), '\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																ranges: [],
																ignoreCase: false,
																inverted: true,
															}),
														],
													}),
												}),
												LitMatcher({
													pos: {line: 420, col: 52, offset: 11293},
													val: "\"",
													ignoreCase: false,
													want: "\"\\\"\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 421, col: 21, offset: 11320},
											exprs: [
												LitMatcher({
													pos: {line: 421, col: 21, offset: 11320},
													val: "`",
													ignoreCase: false,
													want: "\"`\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 421, col: 25, offset: 11324},
													expr: CharClassMatcher({
														pos: {line: 421, col: 25, offset: 11324},
														val: "[^`]",
														chars: ['`'.charCodeAt(0),],
														ranges: [],
														ignoreCase: false,
														inverted: true,
													}),
												}),
												LitMatcher({
													pos: {line: 421, col: 31, offset: 11330},
													val: "`",
													ignoreCase: false,
													want: "\"`\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 422, col: 21, offset: 11357},
											exprs: [
												LitMatcher({
													pos: {line: 422, col: 21, offset: 11357},
													val: "'",
													ignoreCase: false,
													want: "\"'\"",
												}),
												ZeroOrMoreExpr({
													pos: {line: 422, col: 26, offset: 11362},
													expr: ChoiceExpr({
														pos: {line: 422, col: 27, offset: 11363},
														alternatives: [
															LitMatcher({
																pos: {line: 422, col: 27, offset: 11363},
																val: "\\'",
																ignoreCase: false,
																want: "\"\\\\'\"",
															}),
															LitMatcher({
																pos: {line: 422, col: 34, offset: 11370},
																val: "\\\\",
																ignoreCase: false,
																want: "\"\\\\\\\\\"",
															}),
															OneOrMoreExpr({
																pos: {line: 422, col: 41, offset: 11377},
																expr: CharClassMatcher({
																	pos: {line: 422, col: 41, offset: 11377},
																	val: "[^\\]",
																	chars: ['\''.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: true,
																}),
															}),
														],
													}),
												}),
												LitMatcher({
													pos: {line: 422, col: 49, offset: 11385},
													val: "'",
													ignoreCase: false,
													want: "\"'\"",
												}),
											],
										}),
										SeqExpr({
											pos: {line: 427, col: 37, offset: 11669},
											exprs: [
												NotExpr({
													pos: {line: 427, col: 37, offset: 11669},
													expr: CharClassMatcher({
														pos: {line: 427, col: 38, offset: 11670},
														val: "[[]]",
														chars: ['['.charCodeAt(0), ']'.charCodeAt(0),],
														ranges: [],
														ignoreCase: false,
														inverted: false,
													}),
												}),
												AnyMatcher({
													line: 414,
													col: 15,
													offset: 11001,
												}),
											],
										}),
									],
								}),
							}),
							SeqExpr({
								pos: {line: 427, col: 59, offset: 11691},
								exprs: [
									LitMatcher({
										pos: {line: 427, col: 59, offset: 11691},
										val: "[",
										ignoreCase: false,
										want: "\"[\"",
									}),
									RuleRefExpr({
										pos: {line: 427, col: 63, offset: 11695},
										name: "CodeExpr2",
									}),
									LitMatcher({
										pos: {line: 427, col: 73, offset: 11705},
										val: "]",
										ignoreCase: false,
										want: "\"]\"",
									}),
								],
							}),
						],
					}),
				}),
			}),
		},
	],
}

private function _oninput1(c:Current, x:Any):RetValErr {
	return retWrap(x, nil);
}

private function _calloninput1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput1(p.cur, stack["x"]);
}

private function _onnodes1(c:Current, nodes:Any):RetValErr {
	return retWrap(new Types.Story(nodes), nil);
}

private function _callonnodes1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodes1(p.cur, stack["nodes"]);
}

private function _on_nodeCond1(c:Current, cond:Any):RetValErr {
	return retWrap(cond, nil);
}

private function _callon_nodeCond1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _on_nodeCond1(p.cur, stack["cond"]);
}

private function _onnodeType18(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _callonnodeType18(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeType18(p.cur,);
}

private function _onnodeType125(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _callonnodeType125(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeType125(p.cur,);
}

private function _onnodeType121(c:Current, name:Any):RetValErr {
	return retWrap(name, nil);
}

private function _callonnodeType121(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeType121(p.cur, stack["name"]);
}

private function _onnodeType11(c:Current, name, cond, next, lines:Any):RetValErr {
	var e = c.data.setSectionIndex(name);
	if (e != null) {
		return retWrap(null, e);
	}

	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		name: name,
		lines: parseFilterNil(lines),
		condition: cond,
		next: next,
		nextIndex: c.data.getNextIndex(),
	}, nil);
}

private function _callonnodeType11(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeType11(p.cur, stack["name"], stack["cond"], stack["next"], stack["lines"]);
}

private function _onnodeType28(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _callonnodeType28(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeType28(p.cur,);
}

private function _onnodeType21(c:Current, name, lines:Any):RetValErr {
	var e = c.data.setSectionIndex(name);
	if (e != null) {
		return retWrap(null, e);
	}

	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		name: name,
		lines: parseFilterNil(lines),
		nextIndex: c.data.getNextIndex(),
	}, nil);
}

private function _callonnodeType21(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeType21(p.cur, stack["name"], stack["lines"]);
}

private function _onnodeLines1(c:Current, lines:Any):RetValErr {
	return retWrap(lines, nil);
}

private function _callonnodeLines1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeLines1(p.cur, stack["lines"]);
}

private function _onnodeLine2(c:Current,):RetValErr {
	return retWrap(nil, nil);
}

private function _callonnodeLine2(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeLine2(p.cur,);
}

private function _onnodeLineType21(c:Current, code:Any):RetValErr {
	return parseReturnCodeSectionLine(c, "codeBlock", code);
}

private function _callonnodeLineType21(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeLineType21(p.cur, stack["code"]);
}

private function _onnodeLineExprBlock1(c:Current, expr:Any):RetValErr {
	return parseReturnCodeSectionLine(c, "codeInText", expr);
}

private function _callonnodeLineExprBlock1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeLineExprBlock1(p.cur, stack["expr"]);
}

private function _onnodeLineCommonText12(c:Current,):RetValErr {
	return retWrap("{", nil);
}

private function _callonnodeLineCommonText12(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeLineCommonText12(p.cur,);
}

private function _onnodeLineCommonText14(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _callonnodeLineCommonText14(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeLineCommonText14(p.cur,);
}

private function _onnodeLineCommonText8(c:Current, items:Any):RetValErr {
	var items2 = [];
	if (Std.isOfType(items, Array)) {
		var itemsX:Array<Any> = cast items;
		for (i in itemsX) {
			items2.push(i);
		}
	}
	var text = items2.join("");
	return parseReturnTextSectionLine(c, text);
}

private function _callonnodeLineCommonText8(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeLineCommonText8(p.cur, stack["items"]);
}

private function _onnodeLineCommonText1(c:Current, items:Any):RetValErr {
	var x = parseReturnTextSectionLine(c, "\n");
	var items2:Array<Any> = null;
	if (Std.isOfType(items, Array)) {
		items2 = cast items;
		items2.push(x.val);
	}
	return retWrap(items2, nil);
}

private function _callonnodeLineCommonText1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onnodeLineCommonText1(p.cur, stack["items"]);
}

private function _onCode1(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _callonCode1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onCode1(p.cur,);
}

private function _onCodeExpr1(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _callonCodeExpr1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onCodeExpr1(p.cur,);
}

private function _onCodeExpr21(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _callonCodeExpr21(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _onCodeExpr21(p.cur,);
}

class Errors {
	public static var errNoRule:Exception = new Exception("grammar has no rule");
	public static var errInvalidEntrypoint:Exception = new Exception("invalid entrypoint");
	public static var errInvalidEncoding:Exception = new Exception("invalid encoding");
	public static var errMaxExprCnt:Exception = new Exception("max number of expressions parsed");
}

// alternative of Uint64
typedef Uint64A = UInt;
typedef RuneA = UInt;

// Option is a function that can set an option on the parser. It returns
// the previous setting as an Option.
// typedef Option = (p:Parser) -> Option; // 注: 这是个函数
typedef Option = (p:Parser) -> Any; // 注: 这是个函数，因static编译需求返回Any

// MaxExpressions creates an Option to stop parsing after the provided
// number of expressions have been parsed, if the value is 0 then the parser will
// parse for as many steps as needed (possibly an infinite number).
//
// The default for maxExprCnt is 0.
function MaxExpressions(maxExprCnt:Uint64A):Option {
	return function(p:Parser):Option {
		var oldMaxExprCnt = p.maxExprCnt;
		p.maxExprCnt = maxExprCnt;
		return MaxExpressions(oldMaxExprCnt);
	}
}

// Entrypoint creates an Option to set the rule name to use as entrypoint.
// The rule name must have been specified in the -alternate-entrypoints
// if generating the parser with the -optimize-grammar flag, otherwise
// it may have been optimized out. Passing an empty string sets the
// entrypoint to the first rule in the grammar.
//
// The default is to start parsing at the first rule in the grammar.
function Entrypoint(ruleName:String):Option {
	return function(p:Parser):Option {
		var oldEntrypoint = p.entrypoint;
		p.entrypoint = ruleName;
		if (ruleName == "") {
			p.entrypoint = g.rules[0].name;
		}
		return Entrypoint(oldEntrypoint);
	}
}

// AllowInvalidUTF8 creates an Option to allow invalid UTF-8 bytes.
// Every invalid UTF-8 byte is treated as a utf8.RuneError (U+FFFD)
// by character class matchers and is matched by the any matcher.
// The returned matched value, c.text and c.offset are NOT affected.
//
// The default is false.
function AllowInvalidUTF8(b:Bool):Option {
	return function(p:Parser):Option {
		var old = p.allowInvalidUTF8;
		p.allowInvalidUTF8 = b;
		return AllowInvalidUTF8(old);
	}
}

// Recover creates an Option to set the recover flag to b. When set to
// true, this causes the parser to recover from panics and convert it
// to an error. Setting it to false can be useful while debugging to
// access the full stack trace.
//
// The default is true.
function Recover(b:Bool):Option {
	return function(p:Parser):Option {
		var old = p.recover;
		p.recover = b;
		return Recover(old);
	}
}

// GlobalStore creates an Option to set a key to a certain value in
// the globalStore.
function GlobalStore(key:String, value:Any):Option {
	return function(p:Parser):Option {
		var old = p.cur.globalStore[key];
		p.cur.globalStore[key] = value;
		return GlobalStore(key, old);
	}
}

// position records a position in the text.
typedef Position = {
	var line:Int;
	var col:Int;
	var offset:Int;
}

function positionToString(p:Position):String {
	return '${p.line}:${p.col} [${p.offset}]';
}

// savepoint stores all state required to go back to this point in the
// parser.
typedef Savepoint = {
	> Position,
	var rn:RuneA;
	var w:Int;
}

function positionClone(x:Position):Position {
	return {
		line: x.line,
		col: x.col,
		offset: x.offset,
	};
}

function savepointClone(x:Savepoint):Savepoint {
	return {
		line: x.line,
		col: x.col,
		offset: x.offset,
		rn: x.rn,
		w: x.w
	};
}

typedef Current = {
	var pos:Position; // start position of the match
	var text:String; // raw text of the match // []byte

	// globalStore is a general store for the user to store arbitrary key-value
	// pairs that they need to manage and that they do not want tied to the
	// backtracking of the parser. This is only modified by the user and never
	// rolled back by the parser. It is always up to the user to keep this in a
	// consistent state.
	var globalStore:StoreDict;

	var data:ParserCustomData;
}

typedef StoreDict = Map<String, Any>;

enum AllExpr {
	ChoiceExpr(e:ChoiceExpr);
	ActionExpr(e:ActionExpr);
	RecoveryExpr(e:RecoveryExpr);
	SeqExpr(e:SeqExpr);
	ThrowExpr(e:ThrowExpr);
	LabeledExpr(e:LabeledExpr);

	AndExpr(e:AndExpr);
	NotExpr(e:NotExpr);
	ZeroOrOneExpr(e:ZeroOrOneExpr);
	ZeroOrMoreExpr(e:ZeroOrMoreExpr);
	OneOrMoreExpr(e:OneOrMoreExpr);
	RuleRefExpr(e:RuleRefExpr);
	AndCodeExpr(e:AndCodeExpr);
	NotCodeExpr(e:NotCodeExpr);

	AnyMatcher(e:AnyMatcher);
	CharClassMatcher(e:CharClassMatcher);
	CustomParserCodeExpr(e:CustomParserCodeExpr);
	LitMatcher(e:LitMatcher);
}

// the AST types...
//  nolint: structcheck
typedef Grammar = {
	@:optional var pos:Position;
	var rules:Array<Rule>;
}

//  nolint: structcheck
typedef Rule = {
	var pos:Position;
	var name:String;
	@:optional var displayName:String;
	var expr:AllExpr;
}

//  nolint: structcheck
typedef ChoiceExpr = {
	var pos:Position;
	var alternatives:Array<Any>;
}

typedef RetValOk = {
	var val:Any;
	var ok:Bool;
}

typedef RetValErr = {
	var val:Any;
	var err:Exception;
}

typedef RetValOkErr = {
	var val:Any;
	var ok:Bool;
	var err:Exception;
}

typedef RetOkErr = {
	var ok:Bool;
	var err:Exception;
}

//  nolint: structcheck
typedef ActionExpr = {
	var pos:Position;
	var expr:Any;
	var run:(p:Parser) -> RetValErr;
}

//  nolint: structcheck
typedef RecoveryExpr = {
	var pos:Position;
	var expr:Any;
	var recoverExpr:Any;
	var failureLabel:Array<String>;
}

//  nolint: structcheck
typedef SeqExpr = {
	var pos:Position;
	var exprs:Array<AllExpr>;
}

//  nolint: structcheck
typedef ThrowExpr = {
	var pos:Position;
	var label:String;
}

//  nolint: structcheck
typedef LabeledExpr = {
	var pos:Position;
	var label:String;
	var expr:AllExpr;
}

//  nolint: structcheck
typedef Expr = {
	var pos:Position;
	var expr:AllExpr;
}

typedef AndExpr = Expr;
typedef NotExpr = Expr;
typedef ZeroOrOneExpr = Expr;
typedef ZeroOrMoreExpr = Expr;
typedef OneOrMoreExpr = Expr;

//  nolint: structcheck
typedef RuleRefExpr = {
	var pos:Position;
	var name:String;
}

//  nolint: structcheck
typedef AndCodeExpr = {
	var pos:Position;
	var run:(p:Parser) -> RetOkErr;
}

//  nolint: structcheck
typedef NotCodeExpr = {
	var pos:Position;
	var run:(p:Parser) -> RetOkErr;
}

//  nolint: structcheck
typedef LitMatcher = {
	var pos:Position;
	var val:String;
	var ignoreCase:Bool;
	var want:String;
}

//  nolint: structcheck
typedef CustomParserCodeExpr = {
	var pos:Position;
	var run:(p:Parser) -> RetValOkErr;
}

//  nolint: structcheck
typedef CharClassMatcher = {
	var pos:Position;
	var val:String;
	// basicLatinChars [128]bool // TODO
	var chars:Array<UInt>;
	var ranges:Array<UInt>;
	@:optional var classes:Array<Unicode.RangeTable>;
	var ignoreCase:Bool;
	var inverted:Bool;
}

typedef AnyMatcher = Position; //  nolint: structcheck

// errList cumulates the errors found by the parser.
class ErrList {
	var lst:Array<ParserError> = [];

	public function add(err:ParserError) {
		this.lst.push(err);
	}

	function err():ErrList {
		if (this.lst.length == 0) {
			return null;
		}
		this.dedupe();
		return this;
	}

	public var length(get, null):Int;

	function get_length() {
		return this.lst.length;
	}

	function dedupe() {
		// TODO: 去重
		// var cleaned []error
		// set := make(map[string]bool)
		// for _, err := range *e {
		// 	if msg := err.Error(); !set[msg] {
		// 		set[msg] = true
		// 		cleaned = append(cleaned, err)
		// 	}
		// }
		// *e = cleaned
	}

	function error():String {
		switch (this.lst.length) {
			case 0:
				return "";
			case 1:
				return this.lst[0].prefix + ' ' + this.lst[0].Inner.toString();
			default:
				var arr = [];
				for (i in this.lst) {
					arr.push(i.prefix + ' ' + i.Inner.toString());
				}
				return arr.join('\n');
		}
	}

	public function toException():Exception {
		if (this.lst.length == 0) {
			return null;
		}
		return new Exception(this.err().error());
	}

	public function new() {}
}

// parserError wraps an error with a prefix indicating the rule in which
// the error occurred. The original error is stored in the Inner field.
typedef ParserError = {
	var Inner:Exception;
	var pos:Position;
	var prefix:String;
	var expected:Array<String>;
}

// Error returns the error message.
function parserErrorError(p:ParserError):String {
	return p.prefix + ": " + p.Inner.toString();
}

//  nolint: structcheck,deadcode
typedef ResultTuple = {
	var v:Any;
	var b:Bool;
	var end:Savepoint;
}

//  nolint: varcheck
var choiceNoMatch = -1; // const

// Stats stores some statistics, gathered during parsing
typedef Stats = {
	// ExprCnt counts the number of expressions processed during parsing
	// This value is compared to the maximum number of expressions allowed
	// (set by the MaxExpressions option).
	var ExprCnt:Uint64A;

	// ChoiceAltCnt is used to count for each ordered choice expression,
	// which alternative is used how may times.
	// These numbers allow to optimize the order of the ordered choice expression
	// to increase the performance of the parser
	//
	// The outer key of ChoiceAltCnt is composed of the name of the rule as well
	// as the line and the column of the ordered choice.
	// The inner key of ChoiceAltCnt is the number (one-based) of the matching alternative.
	// For each alternative the number of matches are counted. If an ordered choice does not
	// match, a special counter is incremented. The name of this counter is set with
	// the parser option Statistics.
	// For an alternative to be included in ChoiceAltCnt, it has to match at least once.
	var ChoiceAltCnt:Map<String, Map<String, Int>>;
}

//  nolint: structcheck,maligned
class Parser {
	public var filename:String;
	public var pt:Savepoint;
	public var cur:Current;

	public var data:String;
	public var errs = new ErrList(); // x *errList

	public var depth:Int;
	public var recover:Bool;
	// rules table, maps the rule identifier to the rule node
	public var rules:Map<String, Rule>;
	// variables stack, map of label to value
	public var vstack = new GenericStack<Map<String, Any>>();
	// rule stack, allows identification of the current rule in errors
	public var rstack = new GenericStack<Rule>();

	// parse fail
	public var maxFailPos:Position;
	public var maxFailExpected:Array<String>;
	public var maxFailInvertExpected:Bool = false;

	// max number of expressions to be parsed
	public var maxExprCnt:Uint64A;
	// entrypoint for the parser
	public var entrypoint:String;

	public var allowInvalidUTF8:Bool;

	// *Stats
	public var stats:Stats;

	public var choiceNoMatch:String;
	// recovery expression stack, keeps track of the currently available recovery expression, these are traversed in reverse
	public var recoveryStack = new GenericStack<Map<String, Any>>();

	// newParser creates a parser with the specified input source and options.
	public function new(filename:String, b:String, opts:Array<Option>) {
		var stats:Stats = {
			ExprCnt: 0,
			ChoiceAltCnt: new Map<String, Map<String, Int>>(),
		}

		this.filename = filename;
		this.data = b;
		this.pt = {
			line: 1,
			col: 0,
			offset: 0,
			rn: 0,
			w: 0,
		};
		this.recover = true;
		this.cur = {
			pos: {line: 0, col: 0, offset: 0},
			text: null,
			globalStore: new StoreDict(),
			data: new ParserCustomData(),
		};

		this.maxFailPos = {col: 1, line: 1, offset: 0};
		this.maxFailExpected = []; // make([]string, 0, 20),
		this.stats = stats;
		// start rule is rule [0] unless an alternate entrypoint is specified
		this.entrypoint = g.rules[0].name;

		this.setOptions(opts);

		if (this.maxExprCnt == 0) {
			this.maxExprCnt = 2147483647; // p.maxExprCnt = 2147483647;
		}
	}

	// setOptions applies the options to the parser.
	function setOptions(opts:Array<Option>) {
		for (opt in opts) {
			opt(this);
		}
	}

	// push a variable set on the vstack.
	function pushV() {
		this.vstack.add(new Map());
	}

	// pop a variable set from the vstack.
	function popV() {
		this.vstack.pop();
	}

	// push a recovery expression with its labels to the recoveryStack
	function pushRecovery(labels:Array<String>, expr:Any) {
		var m = new Map<String, Any>();
		// m := make(map[string]any, len(labels))
		for (fl in labels) {
			m[fl] = expr;
		}
		this.recoveryStack.add(m);
	}

	// pop a recovery expression from the recoveryStack
	function popRecovery() {
		this.recoveryStack.pop();
	}

	function addErr(err:Exception) {
		// p.addErrAt(err, p.pt.position,[])
		this.addErrAt(err, this.pt, []);
	}

	function addErrAt(err:Exception, pos:Position, expected:Array<String>) {
		var buf = new BytesBuffer();
		if (this.filename != "") {
			buf.addString(this.filename);
		}
		// if buf.Len() > 0 { 不确定
		if (buf.length > 0) {
			buf.addString(':');
		}
		// buf.WriteString(fmt.Sprintf("%d:%d (%d)", pos.line, pos.col, pos.offset))
		buf.addString('${pos.line}:${pos.col} (${pos.offset})');
		if (this.rstack.first() != null) {
			if (buf.length > 0) {
				buf.addString(": ");
			}
			var rule = this.rstack.first();
			if (rule.displayName != "") {
				buf.addString("rule " + rule.displayName);
			} else {
				buf.addString("rule " + rule.name);
			}
		}
		// pe := &parserError{Inner: err, pos: pos, prefix: buf.String(), expected: expected}
		// p.errs.add(pe)
		this.errs.add({
			Inner: err,
			pos: pos,
			prefix: buf.getBytes().toString(),
			expected: expected,
		});
	}

	function failAt(fail:Bool, pos:Position, want:String) {
		// process fail if parsing fails and not inverted or parsing succeeds and invert is set
		if (fail == this.maxFailInvertExpected) {
			if (pos.offset < this.maxFailPos.offset) {
				return;
			}

			if (pos.offset > this.maxFailPos.offset) {
				this.maxFailPos = pos;
				// p.maxFailExpected = p.maxFailExpected[:0]
				this.maxFailExpected = [];
			}

			if (this.maxFailInvertExpected) {
				want = "!" + want;
			}
			this.maxFailExpected.push(want);
		}
	}

	// read advances the parser to the next rune.
	function read() {
		// this.pt.offset += this.pt.w;
		this.pt.offset += this.pt.w > 0 ? 1 : 0;
		// rn, n := utf8.DecodeRune(p.data[p.pt.offset:])
		// p.pt.rn = rn
		// p.pt.w = n
		// p.pt.col++
		var rn = this.data.charAt(this.pt.offset);
		var rnB = Bytes.ofString(rn);
		var _rnInt = rn.charCodeAt(0);
		this.pt.rn = _rnInt != null ? _rnInt : 0; // static compile requires !null
		this.pt.w = rnB.length;
		this.pt.col++;

		// if rn == '\n' {
		if (rn == '\n') {
			this.pt.line++;
			this.pt.col = 0;
		}

		// TODO 需要重做，rn为空不代表utf8的invalid
		// if (rn == '') {
		//     if (!this.allowInvalidUTF8) {
		//         this.addErr(Errors.errInvalidEncoding);
		//     }
		// }
	}

	// restore parser position to the savepoint pt.
	function restore(pt:Savepoint) {
		if (pt.offset == this.pt.offset) {
			return;
		}
		this.pt = pt;
	}

	function sliceFrom(start:Savepoint):String {
		// return p.data[start.position.offset:p.pt.position.offset]
		return this.data.substring(start.offset, this.pt.offset);
	}

	public function buildRulesTable(g:Grammar):Void {
		this.rules = new Map<String, Rule>();
		for (r in g.rules) {
			this.rules[r.name] = r;
		}
	}

	//  nolint: gocyclo
	public function parse(g:Grammar):Any {
		if (g.rules.length == 0) {
			this.addErr(Errors.errNoRule);
			// return nil, p.errs.err()
			throw this.errs.toException();
		}

		// TODO : not super critical but this could be generated
		this.buildRulesTable(g);
		// var recoverDefer = () -> {};

		if (this.recover) {
			// panic can be used in action code to stop parsing immediately
			// and return the panic as an error.
		}

		var startRule = this.rules[this.entrypoint];

		if (startRule == null) {
			this.addErr(Errors.errInvalidEntrypoint);
			// return nil, p.errs.err()
			throw this.errs.toException();
		}

		var ret:RetValOk = {val: null, ok: false};

		try {
			this.read(); // advance to first rune
			ret = this.parseRuleWrap(startRule);
		} catch (e:haxe.Exception) {
			// switch e := e.(type) {
			// case error:
			this.addErr(e);
			// default:
			// 	p.addErr(fmt.Errorf("%v", e))
			// }
			throw this.errs.toException();
		}

		if (!ret.ok) {
			if (this.errs.length == 0) {
				// If parsing fails, but no errors have been recorded, the expected values
				// for the farthest parser position are returned as error.
				var maxFailExpectedMap = new Map<String, Any>();
				for (v in this.maxFailExpected) {
					// maxFailExpectedMap[v] = struct{}{}
					maxFailExpectedMap[v] = {};
				}

				var expected = [];
				var eof = false;
				if (maxFailExpectedMap["!."] != null) {
					// delete(maxFailExpectedMap, "!.")
					maxFailExpectedMap.remove("!.");
					eof = true;
				}
				for (k in maxFailExpectedMap.keys()) {
					expected.push(k);
				}

				// sort.Strings(expected)
				expected.sort((a, b) -> a > b ? 1 : -1);

				if (eof) {
					expected.push("EOF");
				}
				// p.addErrAt(errors.New("no match found, expected: " + listJoin(expected, ", ", "or")), p.maxFailPos, expected)
				this.addErrAt(new Exception("no match found, expected: " + listJoin(expected, ", ", "or")), this.maxFailPos, expected);
			}
			throw this.errs.toException();
		}

		// return val, p.errs.err()
		if (this.errs.length != 0) {
			throw this.errs.toException();
		}
		return ret.val;
	}

	function parseRuleWrap(rule:Rule):RetValOk {
		var ret:RetValOk = {val: null, ok: false};

		ret = this.parseRule(rule);

		return ret;
	}

	function parseRule(rule:Rule):RetValOk {
		this.rstack.add(rule);
		this.pushV();

		var ret = this.parseExprWrap(rule.expr);
		this.popV();
		this.rstack.pop();
		return ret;
	}

	function parseExprWrap(expr:AllExpr):RetValOk {
		var ret = this.parseExpr(expr);

		return ret;
	}

	//  nolint: gocyclo
	function parseExpr(expr:AllExpr):RetValOk {
		this.stats.ExprCnt++;
		if (this.stats.ExprCnt > this.maxExprCnt) {
			throw Errors.errMaxExprCnt;
		}

		var ret:RetValOk;

		switch (expr) {
			case ActionExpr(expr):
				ret = this.parseActionExpr(expr);
			case AndCodeExpr(expr):
				ret = this.parseAndCodeExpr(expr);
			case AndExpr(expr):
				ret = this.parseAndExpr(expr);
			case AnyMatcher(expr):
				ret = this.parseAnyMatcher(expr);
			case CharClassMatcher(expr):
				ret = this.parseCharClassMatcher(expr);
			case ChoiceExpr(expr):
				ret = this.parseChoiceExpr(expr);
			case CustomParserCodeExpr(expr):
				ret = this.parseCustomParserCodeExpr(expr);
			case LabeledExpr(expr):
				ret = this.parseLabeledExpr(expr);
			case LitMatcher(expr):
				ret = this.parseLitMatcher(expr);
			case NotCodeExpr(expr):
				ret = this.parseNotCodeExpr(expr);
			case NotExpr(expr):
				ret = this.parseNotExpr(expr);
			case OneOrMoreExpr(expr):
				ret = this.parseOneOrMoreExpr(expr);
			case RecoveryExpr(expr):
				ret = this.parseRecoveryExpr(expr);
			case RuleRefExpr(expr):
				ret = this.parseRuleRefExpr(expr);
			case SeqExpr(expr):
				ret = this.parseSeqExpr(expr);
			case ThrowExpr(expr):
				ret = this.parseThrowExpr(expr);
			case ZeroOrMoreExpr(expr):
				ret = this.parseZeroOrMoreExpr(expr);
			case ZeroOrOneExpr(expr):
				ret = this.parseZeroOrOneExpr(expr);
			default:
				throw new Exception("unknown expression type");
				// panic(fmt.Sprintf("unknown expression type %T", expr))
		}
		return ret;
	}

	function parseActionExpr(act:ActionExpr):RetValOk {
		var start = savepointClone(this.pt);
		var ret = this.parseExprWrap(act.expr);
		if (ret.ok) {
			// this.cur.pos = start.position;
			this.cur.pos = {line: start.line, col: start.col, offset: start.offset};
			this.cur.text = this.sliceFrom(start);
			var RetValErr = act.run(this);
			if (RetValErr.err != null) {
				this.addErrAt(RetValErr.err, {line: start.line, col: start.col, offset: start.offset}, []);
			}

			ret.val = RetValErr.val;
		}
		return ret;
	}

	function parseAndCodeExpr(and:AndCodeExpr):RetValOk {
		// ok, err := and.run(p);
		var ret = and.run(this);
		if (ret.err != null) {
			this.addErr(ret.err);
		}

		return {val: null, ok: true};
	}

	function parseAndExpr(and:AndExpr):RetValOk {
		var pt = this.pt;
		this.pushV();
		var ret = this.parseExprWrap(and.expr);
		this.popV();
		this.restore(pt);

		return {val: null, ok: ret.ok};
	}

	function parseAnyMatcher(act:AnyMatcher):RetValOk {
		// if p.pt.rn == utf8.RuneError && p.pt.w == 0 {
		if (this.pt.rn == 0 && this.pt.w == 0) {
			// EOF - see utf8.DecodeRune
			this.failAt(false, this.pt, ".");
			return {val: null, ok: false};
		}
		var start = savepointClone(this.pt);
		this.read();
		this.failAt(true, start, ".");
		return {val: this.sliceFrom(start), ok: true};
	}

	//  nolint: gocyclo
	function parseCharClassMatcher(chr:CharClassMatcher):RetValOk {
		var cur = this.pt.rn;
		var start = savepointClone(this.pt);

		// can't match EOF
		if (cur == 0 && this.pt.w == 0) { // see utf8.DecodeRune
			this.failAt(false, start, chr.val);
			return {val: null, ok: false};
		}

		if (chr.ignoreCase) {
			cur = String.fromCharCode(cur).toLowerCase().charCodeAt(0);
		}

		// try to match in the list of available chars
		for (rn in chr.chars) {
			if (rn == cur) {
				if (chr.inverted) {
					this.failAt(false, start, chr.val);
					return {val: null, ok: false};
				}
				this.read();
				this.failAt(true, start, chr.val);
				return {val: this.sliceFrom(start), ok: true};
			}
		}

		// try to match in the list of ranges
		for (i in 0...chr.ranges.length) {
			if (i % 2 != 0)
				continue;
			if (cur >= chr.ranges[i] && cur <= chr.ranges[i + 1]) {
				if (chr.inverted) {
					this.failAt(false, start, chr.val);
					return {val: null, ok: false};
				}
				this.read();
				this.failAt(true, start, chr.val);
				return {val: this.sliceFrom(start), ok: true};
			}
		}

		// try to match in the list of Unicode classes
		if (chr.classes != null) {
			for (cl in chr.classes) {
				if (Unicode.Is(cl, cur)) {
					if (chr.inverted) {
						this.failAt(false, start, chr.val);
						return {val: null, ok: false};
					}
					this.read();
					this.failAt(true, start, chr.val);
					return {val: this.sliceFrom(start), ok: true};
				}
			}
		}

		if (chr.inverted) {
			this.read();
			this.failAt(true, start, chr.val);
			return {val: this.sliceFrom(start), ok: true};
		}
		this.failAt(true, start, chr.val);
		return {val: null, ok: false};
	}

	function parseChoiceExpr(ch:ChoiceExpr):RetValOk {
		// for altI, alt := range ch.alternatives {
		for (altI in 0...ch.alternatives.length) {
			var alt = ch.alternatives[altI];

			// dummy assignment to prevent compile error if optimized
			var _ = altI;

			this.pushV();
			var ret = this.parseExprWrap(alt);
			this.popV();
			if (ret.ok) {
				return ret;
			}
		}

		return {val: null, ok: false};
	}

	function parseLabeledExpr(lab:LabeledExpr):RetValOk {
		this.pushV();
		var ret = this.parseExprWrap(lab.expr);
		this.popV();
		if (ret.ok && lab.label != "") {
			var m = this.vstack.first();
			m[lab.label] = ret.val;
		}
		return ret;
	}

	function parseCustomParserCodeExpr(code:CustomParserCodeExpr):RetValOk {
		// val, ok, err := code.run(p)
		var ret = code.run(this);
		if (ret.err != null) {
			this.addErr(ret.err);
			return {val: null, ok: false};
		}

		return {val: ret.val, ok: ret.ok};
	}

	function parseLitMatcher(lit:LitMatcher):RetValOk {
		var start = savepointClone(this.pt);
		var litVal = lit.val;
		if (lit.ignoreCase) {
			litVal = lit.val.toLowerCase();
		}

		for (want in new StringIteratorUnicode(litVal)) {
			var cur = this.pt.rn;
			if (cur != want) {
				this.failAt(false, start, lit.want);
				this.restore(start);
				return {val: null, ok: false};
			}
			this.read();
		}
		this.failAt(true, start, lit.want);
		return {val: this.sliceFrom(start), ok: true};
	}

	function parseNotCodeExpr(code:NotCodeExpr):RetValOk {
		var ret = code.run(this);
		if (ret.err != null) {
			this.addErr(ret.err);
		}

		return {val: null, ok: !ret.ok};
	}

	function parseNotExpr(not:NotExpr):RetValOk {
		var pt = savepointClone(this.pt);
		this.pushV();
		this.maxFailInvertExpected = !this.maxFailInvertExpected;
		var ret = this.parseExprWrap(not.expr);
		this.maxFailInvertExpected = !this.maxFailInvertExpected;
		this.popV();
		this.restore(pt);

		return {val: null, ok: !ret.ok};
	}

	function parseOneOrMoreExpr(expr:OneOrMoreExpr):RetValOk {
		var vals:Array<Any> = [];

		while (true) {
			this.pushV();
			var ret = this.parseExprWrap(expr.expr);
			this.popV();
			if (!ret.ok) {
				if (vals.length == 0) {
					// did not match once, no match
					return {val: null, ok: false};
				}
				return {val: vals, ok: true};
			}
			vals.push(ret.val);
		}
	}

	function parseRecoveryExpr(recover:RecoveryExpr):RetValOk {
		this.pushRecovery(recover.failureLabel, recover.recoverExpr);
		var ret = this.parseExprWrap(recover.expr);
		this.popRecovery();

		return ret;
	}

	function parseRuleRefExpr(ref:RuleRefExpr):RetValOk {
		if (ref.name == "") {
			// panic(fmt.Sprintf("%s: invalid rule: missing name", ref.pos))
			throw '${ref.pos}: invalid rule: missing name';
		}

		var rule = this.rules[ref.name];
		if (rule == null) {
			// p.addErr(fmt.Errorf("undefined rule: %s", ref.name))
			this.addErr(new Exception('undefined rule: ${ref.name}'));
			return {val: null, ok: false};
		}
		return this.parseRuleWrap(rule);
	}

	function parseSeqExpr(seq:SeqExpr):RetValOk {
		var vals = [];

		var pt = savepointClone(this.pt);
		for (expr in seq.exprs) {
			var ret = this.parseExprWrap(expr);
			if (!ret.ok) {
				this.restore(pt);
				return {val: null, ok: false};
			}
			vals.push(ret.val);
		}

		return {val: vals, ok: true};
	}

	function parseThrowExpr(expr:ThrowExpr):RetValOk {
		// for i := len(this.recoveryStack) - 1; i >= 0; i-- {
		// 	if recoverExpr, ok := this.recoveryStack[i][expr.label]; ok {
		for (i in this.recoveryStack) {
			var recoverExpr = i[expr.label];
			if (recoverExpr != null) {
				return this.parseExprWrap(recoverExpr);
			}
		}

		return {val: null, ok: false};
	}

	function parseZeroOrMoreExpr(expr:ZeroOrMoreExpr):RetValOk {
		var vals:Array<Any> = [];

		while (true) {
			this.pushV();
			var ret = this.parseExprWrap(expr.expr);
			this.popV();
			if (!ret.ok) {
				return {val: vals, ok: true};
			}
			vals.push(ret.val);
		}
	}

	function parseZeroOrOneExpr(expr:ZeroOrOneExpr):RetValOk {
		this.pushV();
		var ret = this.parseExprWrap(expr.expr);
		this.popV();
		// whether it matched or not, consider it a match
		return {val: ret.val, ok: true};
	}

	public function setCustomData(data:ParserCustomData) {
		this.cur.data = data;
	}
}

function listJoin(list:Array<String>, sep:String, lastSep:String):String {
	switch (list.length) {
		case 0:
			return "";
		case 1:
			return list[0];
		default:
			// return strings.Join(list[:len(list)-1], sep) + " " + lastSep + " " + list[len(list)-1]
			return list.slice(0, list.length - 1).join(sep) + " " + lastSep + " " + list[list.length - 1];
	}
}
