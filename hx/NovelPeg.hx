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
	return {
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		type: "", // 作为最常见种类，故意置空，节省空间
		text: text,
	};
}

function parseReturnInvokeSectionLine(c:Current, name:String, params:Array<String>) {
	return {
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		type: "invoke",
		name: name,
		params: params,
	};
}

function parseReturnCodeSectionLine(c:Current, typeName:String, code:String) {
	return {
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		type: typeName,
		code: code,
	};
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

var toStr = (x:String) -> x;
var toStrWithTrim = (x:String) -> StringTools.trim(x);
var nil = null;

var g:Grammar = {
	rules: [
		{
			name: "input",
			varExists: true,
			expr: ActionExpr({
				run: _call_oninput_1,
				expr: SeqExpr({
					exprs: [
						RuleRefExpr({name: "sp",}),
						LabeledExpr({
							label: "x",
							expr: RuleRefExpr({name: "nodes",}),
							textCapture: false,
						}),
						NotExpr({
							expr: AnyMatcher({}),
						}),
					],
				}),
			}),
		},
		{
			name: "nodes",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodes_1,
				expr: LabeledExpr({
					label: "nodes",
					expr: ZeroOrMoreExpr({
						expr: RuleRefExpr({name: "node",}),
					}),
					textCapture: false,
				}),
			}),
		},
		{
			name: "_nodeCond",
			varExists: true,
			expr: ActionExpr({
				run: _call_on_nodeCond_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: "[", want: "\"[\"",}),
						LabeledExpr({
							label: "cond",
							expr: ZeroOrOneExpr({
								expr: RuleRefExpr({name: "CodeExpr2",}),
							}),
							textCapture: false,
						}),
						LitMatcher({val: "]", want: "\"]\"",}),
					],
				}),
			}),
		},
		{
			name: "_nodeNext",
			varExists: true,
			expr: ActionExpr({
				run: _call_on_nodeNext_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: "[", want: "\"[\"",}),
						LabeledExpr({
							label: "name",
							expr: RuleRefExpr({name: "identifier",}),
							textCapture: false,
						}),
						LitMatcher({val: "]", want: "\"]\"",}),
					],
				}),
			}),
		},
		{
			name: "node",
			expr: ChoiceExpr({
				alternatives: [RuleRefExpr({name: "nodeType1",}), RuleRefExpr({name: "nodeType2",}),],
			}),
		},
		{
			name: "nodeType1",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeType1_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: ":", want: "\":\"",}),
						RuleRefExpr({name: "spNoCR",}),
						LabeledExpr({
							label: "name",
							expr: ZeroOrOneExpr({
								expr: RuleRefExpr({name: "identifier",}),
							}),
							textCapture: false,
						}),
						RuleRefExpr({name: "spNoCR",}),
						SeqExpr({
							exprs: [
								LabeledExpr({
									label: "cond",
									expr: RuleRefExpr({name: "_nodeCond",}),
									textCapture: false,
								}),
								RuleRefExpr({name: "spNoCR",}),
								LabeledExpr({
									label: "next",
									expr: ZeroOrOneExpr({
										expr: RuleRefExpr({name: "_nodeNext",}),
									}),
									textCapture: false,
								}),
							],
						}),
						RuleRefExpr({name: "spNoCR",}),
						RuleRefExpr({name: "cr2",}),
						LabeledExpr({
							label: "lines",
							expr: RuleRefExpr({name: "nodeLines",}),
							textCapture: false,
						}),
					],
				}),
			}),
		},
		{
			name: "nodeType2",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeType2_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: ":", want: "\":\"",}),
						RuleRefExpr({name: "spNoCR",}),
						LabeledExpr({
							label: "name",
							expr: ZeroOrOneExpr({
								expr: RuleRefExpr({name: "identifier",}),
							}),
							textCapture: false,
						}),
						RuleRefExpr({name: "spNoCR",}),
						RuleRefExpr({name: "cr2",}),
						LabeledExpr({
							label: "lines",
							expr: RuleRefExpr({name: "nodeLines",}),
							textCapture: false,
						}),
					],
				}),
			}),
		},
		{
			name: "nodeLines",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeLines_1,
				expr: SeqExpr({
					exprs: [
						LabeledExpr({
							label: "lines",
							expr: ZeroOrMoreExpr({
								expr: RuleRefExpr({name: "nodeLine",}),
							}),
							textCapture: false,
						}),
						RuleRefExpr({name: "sp",}),
					],
				}),
			}),
		},
		{
			name: "nodeLine",
			expr: ChoiceExpr({
				alternatives: [
					RuleRefExpr({name: "nodeLineTypeComment",}),
					RuleRefExpr({name: "nodeLineType2",}),
					RuleRefExpr({name: "nodeLineCommonText",}),
				],
			}),
		},
		{
			name: "nodeLineTypeComment",
			expr: SeqExpr({
				exprs: [
					LitMatcher({val: "@", want: "\"@\"",}),
					LitMatcher({val: "#", want: "\"#\"",}),
					OneOrMoreExpr({
						expr: SeqExpr({
							exprs: [
								NotExpr({
									expr: RuleRefExpr({name: "cr",}),
								}),
								AnyMatcher({}),
							],
						}),
					}),
					RuleRefExpr({name: "cr",}),
					RuleRefExpr({name: "sp",}),
				],
			}),
		},
		{
			name: "_curLine",
			expr: ActionExpr({
				run: _call_on_curLine_1,
				expr: OneOrMoreExpr({
					expr: SeqExpr({
						exprs: [
							NotExpr({
								expr: RuleRefExpr({name: "cr",}),
							}),
							AnyMatcher({}),
						],
					}),
				}),
			}),
		},
		{
			name: "nodeLineType1x",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeLineType1x_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: "@", want: "\"@\"",}),
						NotExpr({
							expr: LitMatcher({val: "{", want: "\"{\"",}),
						}),
						LabeledExpr({
							label: "expr",
							expr: RuleRefExpr({name: "_curLine",}),
							textCapture: false,
						}),
						RuleRefExpr({name: "cr2",}),
					],
				}),
			}),
		},
		{
			name: "nodeLineType1",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeLineType1_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: "@", want: "\"@\"",}),
						LabeledExpr({
							label: "name",
							expr: RuleRefExpr({name: "identifier",}),
							textCapture: false,
						}),
						LabeledExpr({
							label: "params",
							expr: RuleRefExpr({name: "funcInvoke",}),
							textCapture: false,
						}),
						RuleRefExpr({name: "sp",}),
					],
				}),
			}),
		},
		{
			name: "nodeLineType2",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeLineType2_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: "@{", want: "\"@{\"",}),
						LabeledExpr({
							label: "code",
							expr: RuleRefExpr({name: "Code",}),
							textCapture: false,
						}),
						ChoiceExpr({
							alternatives: [
								LitMatcher({val: "}!", want: "\"}!\"",}),
								LitMatcher({val: "}", want: "\"}\"",}),
							],
						}),
						RuleRefExpr({name: "spNoCR",}),
						RuleRefExpr({name: "cr2",}),
					],
				}),
			}),
		},
		{
			name: "_nltEscape",
			expr: ActionExpr({
				run: _call_on_nltEscape_1,
				expr: LitMatcher({val: "\\{", want: "\"\\\\{\"",}),
			}),
		},
		{
			name: "_nltChar",
			expr: ActionExpr({
				run: _call_on_nltChar_1,
				expr: CharClassMatcher({
					val: "[^\\r\\n{]",
					chars: [0xD, 0xA, 0x7B,],
					inverted: true,
				}),
			}),
		},
		{
			name: "nodeLineText",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeLineText_1,
				expr: LabeledExpr({
					label: "items",
					expr: OneOrMoreExpr({
						expr: ChoiceExpr({
							alternatives: [RuleRefExpr({name: "_nltEscape",}), RuleRefExpr({name: "_nltChar",}),],
						}),
					}),
					textCapture: false,
				}),
			}),
		},
		{
			name: "nodeLineExprBlock",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeLineExprBlock_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: "{", want: "\"{\"",}),
						LabeledExpr({
							label: "expr",
							expr: RuleRefExpr({name: "CodeExpr",}),
							textCapture: false,
						}),
						LitMatcher({val: "}", want: "\"}\"",}),
					],
				}),
			}),
		},
		{
			name: "nodeLineCommonText",
			varExists: true,
			expr: ActionExpr({
				run: _call_onnodeLineCommonText_1,
				expr: SeqExpr({
					exprs: [
						NotExpr({
							expr: CharClassMatcher({
								val: "[:@]",
								chars: [0x3A, 0x40,],
							}),
						}),
						LabeledExpr({
							label: "items",
							expr: ZeroOrMoreExpr({
								expr: ChoiceExpr({
									alternatives: [RuleRefExpr({name: "nodeLineText",}), RuleRefExpr({name: "nodeLineExprBlock",}),],
								}),
							}),
							textCapture: false,
						}),
						RuleRefExpr({name: "cr2",}),
					],
				}),
			}),
		},
		{
			name: "funcInvoke",
			varExists: true,
			expr: ChoiceExpr({
				alternatives: [
					ActionExpr({
						run: _call_onfuncInvoke_2,
						expr: SeqExpr({
							exprs: [
								LitMatcher({val: "(", want: "\"(\"",}),
								RuleRefExpr({name: "sp",}),
								LitMatcher({val: ")", want: "\")\"",}),
							],
						}),
					}),
					ActionExpr({
						run: _call_onfuncInvoke_7,
						expr: SeqExpr({
							exprs: [
								LitMatcher({val: "(", want: "\"(\"",}),
								RuleRefExpr({name: "sp",}),
								LabeledExpr({
									label: "first",
									expr: RuleRefExpr({name: "_codeExpr",}),
									textCapture: false,
								}),
								LabeledExpr({
									label: "rest",
									expr: ZeroOrMoreExpr({
										expr: RuleRefExpr({name: "funcInvokeParamExtend",}),
									}),
									textCapture: false,
								}),
								LitMatcher({val: ")", want: "\")\"",}),
							],
						}),
					}),
				],
			}),
		},
		{
			name: "funcInvokeParamExtend",
			varExists: true,
			expr: ActionExpr({
				run: _call_onfuncInvokeParamExtend_1,
				expr: SeqExpr({
					exprs: [
						RuleRefExpr({name: "sp",}),
						LitMatcher({val: ",", want: "\",\"",}),
						RuleRefExpr({name: "sp",}),
						LabeledExpr({
							label: "e",
							expr: RuleRefExpr({name: "_codeExpr",}),
							textCapture: false,
						}),
					],
				}),
			}),
		},
		{
			name: "_codeExpr",
			expr: ActionExpr({
				run: _call_on_codeExpr_1,
				expr: RuleRefExpr({name: "_codeExpr2",}),
			}),
		},
		{
			name: "_codeExpr2",
			expr: ChoiceExpr({
				alternatives: [
					RuleRefExpr({name: "identifier",}),
					RuleRefExpr({name: "integer",}),
					SeqExpr({
						exprs: [
							ZeroOrMoreExpr({
								expr: CharClassMatcher({
									val: "[0-9]",
									ranges: [0x30, 0x39,],
								}),
							}),
							LitMatcher({val: ".", want: "\".\"",}),
							OneOrMoreExpr({
								expr: CharClassMatcher({
									val: "[0-9]",
									ranges: [0x30, 0x39,],
								}),
							}),
						],
					}),
					RuleRefExpr({name: "stringType",}),
				],
			}),
		},
		{
			name: "stringType",
			expr: ActionExpr({
				run: _call_onstringType_1,
				expr: ChoiceExpr({
					alternatives: [
						RuleRefExpr({name: "codeString",}),
						SeqExpr({
							exprs: [
								LitMatcher({val: "`", want: "\"`\"",}),
								ZeroOrMoreExpr({
									expr: CharClassMatcher({
										val: "[^`]",
										chars: [0x60,],
										inverted: true,
									}),
								}),
								LitMatcher({val: "`", want: "\"`\"",}),
							],
						}),
					],
				}),
			}),
		},
		{
			name: "codeString",
			expr: ChoiceExpr({
				alternatives: [
					SeqExpr({
						exprs: [
							LitMatcher({val: "\"", want: "\"\\\"\"",}),
							ZeroOrMoreExpr({
								expr: ChoiceExpr({
									alternatives: [
										SeqExpr({
											exprs: [
												NotExpr({
													expr: RuleRefExpr({name: "EscapedChar",}),
												}),
												AnyMatcher({}),
											],
										}),
										SeqExpr({
											exprs: [
												LitMatcher({val: "\\", want: "\"\\\\\"",}),
												RuleRefExpr({name: "EscapeSequence",}),
											],
										}),
									],
								}),
							}),
							LitMatcher({val: "\"", want: "\"\\\"\"",}),
						],
					}),
					SeqExpr({
						exprs: [
							LitMatcher({val: "'", want: "\"'\"",}),
							ZeroOrMoreExpr({
								expr: ChoiceExpr({
									alternatives: [
										SeqExpr({
											exprs: [
												NotExpr({
													expr: RuleRefExpr({name: "EscapedChar2",}),
												}),
												AnyMatcher({}),
											],
										}),
										SeqExpr({
											exprs: [
												LitMatcher({val: "\\", want: "\"\\\\\"",}),
												RuleRefExpr({name: "EscapeSequence2",}),
											],
										}),
									],
								}),
							}),
							LitMatcher({val: "'", want: "\"'\"",}),
						],
					}),
				],
			}),
		},
		{
			name: "EscapedChar2",
			expr: CharClassMatcher({
				val: "[\\x00-\\x1f'\\\\]",
				chars: [0x27, 0x5C,],
				ranges: [0x0, 0x1F,],
			}),
		},
		{
			name: "EscapeSequence2",
			expr: ChoiceExpr({
				alternatives: [
					RuleRefExpr({name: "SingleCharEscape2",}),
					RuleRefExpr({name: "UnicodeEscape",}),
				],
			}),
		},
		{
			name: "SingleCharEscape2",
			expr: CharClassMatcher({
				val: "['\\\\/bfnrt]",
				chars: [0x27, 0x5C, 0x2F, 0x62, 0x66, 0x6E, 0x72, 0x74,],
			}),
		},
		{
			name: "String",
			expr: ActionExpr({
				run: _call_onString_1,
				expr: SeqExpr({
					exprs: [
						LitMatcher({val: "\"", want: "\"\\\"\"",}),
						ZeroOrMoreExpr({
							expr: ChoiceExpr({
								alternatives: [
									SeqExpr({
										exprs: [
											NotExpr({
												expr: RuleRefExpr({name: "EscapedChar",}),
											}),
											AnyMatcher({}),
										],
									}),
									SeqExpr({
										exprs: [
											LitMatcher({val: "\\", want: "\"\\\\\"",}),
											RuleRefExpr({name: "EscapeSequence",}),
										],
									}),
								],
							}),
						}),
						LitMatcher({val: "\"", want: "\"\\\"\"",}),
					],
				}),
			}),
		},
		{
			name: "EscapedChar",
			expr: CharClassMatcher({
				val: "[\\x00-\\x1f\"\\\\]",
				chars: [0x22, 0x5C,],
				ranges: [0x0, 0x1F,],
			}),
		},
		{
			name: "EscapeSequence",
			expr: ChoiceExpr({
				alternatives: [RuleRefExpr({name: "SingleCharEscape",}), RuleRefExpr({name: "UnicodeEscape",}),],
			}),
		},
		{
			name: "SingleCharEscape",
			expr: CharClassMatcher({
				val: "[\"\\\\/bfnrt]",
				chars: [0x22, 0x5C, 0x2F, 0x62, 0x66, 0x6E, 0x72, 0x74,],
			}),
		},
		{
			name: "UnicodeEscape",
			expr: SeqExpr({
				exprs: [
					LitMatcher({val: "u", want: "\"u\"",}),
					RuleRefExpr({name: "HexDigit",}),
					RuleRefExpr({name: "HexDigit",}),
					RuleRefExpr({name: "HexDigit",}),
					RuleRefExpr({name: "HexDigit",}),
				],
			}),
		},
		{
			name: "DecimalDigit",
			expr: CharClassMatcher({
				val: "[0-9]",
				ranges: [0x30, 0x39,],
			}),
		},
		{
			name: "NonZeroDecimalDigit",
			expr: CharClassMatcher({
				val: "[1-9]",
				ranges: [0x31, 0x39,],
			}),
		},
		{
			name: "HexDigit",
			expr: CharClassMatcher({
				val: "[0-9a-f]i",
				ranges: [0x30, 0x39, 0x61, 0x66,],
				ignoreCase: true,
			}),
		},
		{
			name: "integer",
			expr: ActionExpr({
				run: _call_oninteger_1,
				expr: SeqExpr({
					exprs: [
						ZeroOrOneExpr({
							expr: LitMatcher({val: "-", want: "\"-\"",}),
						}),
						OneOrMoreExpr({
							expr: CharClassMatcher({
								val: "[0-9]",
								ranges: [0x30, 0x39,],
							}),
						}),
					],
				}),
			}),
		},
		{
			name: "identifier",
			expr: ActionExpr({
				run: _call_onidentifier_1,
				expr: SeqExpr({
					exprs: [
						RuleRefExpr({name: "xidStart",}),
						ZeroOrMoreExpr({
							expr: RuleRefExpr({name: "xidContinue",}),
						}),
					],
				}),
			}),
		},
		{
			name: "xidStart",
			expr: CharClassMatcher({
				val: "[_\\p{L}\\p{Other_ID_Start}]",
				chars: [0x5F,],
				classes: [Unicode.L, Unicode.Other_ID_Start,],
			}),
		},
		{
			name: "xidContinue",
			expr: CharClassMatcher({
				val: "[\\p{L}\\p{Other_ID_Start}\\p{Nl}\\p{Mn}\\p{Mc}\\p{Nd}\\p{Pc}\\p{Other_ID_Continue}]",
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
			}),
		},
		{
			name: "sp",
			displayName: "\"whitespace\"",
			expr: ZeroOrMoreExpr({
				expr: CharClassMatcher({
					val: "[ \\n\\t\\r]",
					chars: [0x20, 0xA, 0x9, 0xD,],
				}),
			}),
		},
		{
			name: "spNoCR",
			expr: ZeroOrMoreExpr({
				expr: CharClassMatcher({
					val: "[ \\t]",
					chars: [0x20, 0x9,],
				}),
			}),
		},
		{
			name: "cr",
			expr: CharClassMatcher({
				val: "[\\r\\n]",
				chars: [0xD, 0xA,],
			}),
		},
		{
			name: "cr2",
			expr: SeqExpr({
				exprs: [
					ZeroOrOneExpr({
						expr: LitMatcher({val: "\r", want: "\"\\r\"",}),
					}),
					LitMatcher({val: "\n", want: "\"\\n\"",}),
				],
			}),
		},
		{
			name: "SourceChar",
			expr: AnyMatcher({}),
		},
		{
			name: "Comment",
			expr: ChoiceExpr({
				alternatives: [
					RuleRefExpr({name: "MultiLineComment",}),
					RuleRefExpr({name: "SingleLineComment",}),
				],
			}),
		},
		{
			name: "MultiLineComment",
			expr: SeqExpr({
				exprs: [
					LitMatcher({val: "/*", want: "\"/*\"",}),
					ZeroOrMoreExpr({
						expr: SeqExpr({
							exprs: [
								NotExpr({
									expr: LitMatcher({val: "*/", want: "\"*/\"",}),
								}),
								RuleRefExpr({name: "SourceChar",}),
							],
						}),
					}),
					LitMatcher({val: "*/", want: "\"*/\"",}),
				],
			}),
		},
		{
			name: "MultiLineCommentNoLineTerminator",
			expr: SeqExpr({
				exprs: [
					LitMatcher({val: "/*", want: "\"/*\"",}),
					ZeroOrMoreExpr({
						expr: SeqExpr({
							exprs: [
								NotExpr({
									expr: ChoiceExpr({
										alternatives: [LitMatcher({val: "*/", want: "\"*/\"",}), RuleRefExpr({name: "cr",}),],
									}),
								}),
								RuleRefExpr({name: "SourceChar",}),
							],
						}),
					}),
					LitMatcher({val: "*/", want: "\"*/\"",}),
				],
			}),
		},
		{
			name: "SingleLineComment",
			expr: SeqExpr({
				exprs: [
					NotExpr({
						expr: LitMatcher({val: "//{", want: "\"//{\"",}),
					}),
					LitMatcher({val: "//", want: "\"//\"",}),
					ZeroOrMoreExpr({
						expr: SeqExpr({
							exprs: [
								NotExpr({
									expr: RuleRefExpr({name: "cr",}),
								}),
								RuleRefExpr({name: "SourceChar",}),
							],
						}),
					}),
				],
			}),
		},
		{
			name: "CodeStringLiteral",
			expr: ChoiceExpr({
				alternatives: [
					SeqExpr({
						exprs: [
							LitMatcher({val: "\"", want: "\"\\\"\"",}),
							ZeroOrMoreExpr({
								expr: ChoiceExpr({
									alternatives: [
										LitMatcher({val: "\\\"", want: "\"\\\\\\\"\"",}),
										LitMatcher({val: "\\\\", want: "\"\\\\\\\\\"",}),
										CharClassMatcher({
											val: "[^\"\\r\\n]",
											chars: [0x22, 0xD, 0xA,],
											inverted: true,
										}),
									],
								}),
							}),
							LitMatcher({val: "\"", want: "\"\\\"\"",}),
						],
					}),
					SeqExpr({
						exprs: [
							LitMatcher({val: "`", want: "\"`\"",}),
							ZeroOrMoreExpr({
								expr: CharClassMatcher({
									val: "[^`]",
									chars: [0x60,],
									inverted: true,
								}),
							}),
							LitMatcher({val: "`", want: "\"`\"",}),
						],
					}),
					SeqExpr({
						exprs: [
							LitMatcher({val: "'", want: "\"'\"",}),
							ZeroOrMoreExpr({
								expr: ChoiceExpr({
									alternatives: [
										LitMatcher({val: "\\'", want: "\"\\\\'\"",}),
										LitMatcher({val: "\\\\", want: "\"\\\\\\\\\"",}),
										OneOrMoreExpr({
											expr: CharClassMatcher({
												val: "[^']",
												chars: [0x27,],
												inverted: true,
											}),
										}),
									],
								}),
							}),
							LitMatcher({val: "'", want: "\"'\"",}),
						],
					}),
				],
			}),
		},
		{
			name: "Code",
			expr: ActionExpr({
				run: _call_onCode_1,
				expr: ZeroOrMoreExpr({
					expr: ChoiceExpr({
						alternatives: [
							OneOrMoreExpr({
								expr: ChoiceExpr({
									alternatives: [
										RuleRefExpr({name: "Comment",}),
										RuleRefExpr({name: "CodeStringLiteral",}),
										SeqExpr({
											exprs: [
												NotExpr({
													expr: CharClassMatcher({
														val: "[{}]",
														chars: [0x7B, 0x7D,],
													}),
												}),
												RuleRefExpr({name: "SourceChar",}),
											],
										}),
									],
								}),
							}),
							SeqExpr({
								exprs: [
									LitMatcher({val: "{", want: "\"{\"",}),
									RuleRefExpr({name: "Code",}),
									LitMatcher({val: "}", want: "\"}\"",}),
								],
							}),
						],
					}),
				}),
			}),
		},
		{
			name: "CodeExpr",
			expr: ActionExpr({
				run: _call_onCodeExpr_1,
				expr: ZeroOrMoreExpr({
					expr: ChoiceExpr({
						alternatives: [
							OneOrMoreExpr({
								expr: ChoiceExpr({
									alternatives: [
										RuleRefExpr({name: "CodeStringLiteral",}),
										SeqExpr({
											exprs: [
												NotExpr({
													expr: CharClassMatcher({
														val: "[{}]",
														chars: [0x7B, 0x7D,],
													}),
												}),
												RuleRefExpr({name: "SourceChar",}),
											],
										}),
									],
								}),
							}),
							SeqExpr({
								exprs: [
									LitMatcher({val: "{", want: "\"{\"",}),
									RuleRefExpr({name: "CodeExpr",}),
									LitMatcher({val: "}", want: "\"}\"",}),
								],
							}),
						],
					}),
				}),
			}),
		},
		{
			name: "CodeExpr2",
			expr: ActionExpr({
				run: _call_onCodeExpr2_1,
				expr: ZeroOrMoreExpr({
					expr: ChoiceExpr({
						alternatives: [
							OneOrMoreExpr({
								expr: ChoiceExpr({
									alternatives: [
										RuleRefExpr({name: "CodeStringLiteral",}),
										SeqExpr({
											exprs: [
												NotExpr({
													expr: CharClassMatcher({
														val: "[[\\]]",
														chars: [0x5B, 0x5D,],
													}),
												}),
												RuleRefExpr({name: "SourceChar",}),
											],
										}),
									],
								}),
							}),
							SeqExpr({
								exprs: [
									LitMatcher({val: "[", want: "\"[\"",}),
									RuleRefExpr({name: "CodeExpr2",}),
									LitMatcher({val: "]", want: "\"]\"",}),
								],
							}),
						],
					}),
				}),
			}),
		},
	],
}

private function _call_oninput_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, x:Any):Any {
		return x;
		return null;
	})(p.cur, stack["x"]);
}

private function _call_onnodes_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, nodes:Any):Any {
		return new Types.Story(nodes);
		return null;
	})(p.cur, stack["nodes"]);
}

private function _call_on_nodeCond_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, cond:Any):Any {
		return cond;
		return null;
	})(p.cur, stack["cond"]);
}

private function _call_on_nodeNext_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, name:Any):Any {
		return name;
		return null;
	})(p.cur, stack["name"]);
}

private function _call_onnodeType1_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, name, cond, next, lines:Any):Any {
		var e = c.data.setSectionIndex(name);
		if (e != null) {
			p.addErr(e);
			return null;
		}

		return {
			pos: [c.pos.line, c.pos.col, c.pos.offset],
			name: name,
			lines: parseFilterNil(lines),
			condition: cond,
			next: next,
			nextIndex: c.data.getNextIndex(),
		};
		return null;
	})(p.cur, stack["name"], stack["cond"], stack["next"], stack["lines"]);
}

private function _call_onnodeType2_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, name, lines:Any):Any {
		var e = c.data.setSectionIndex(name);
		if (e != null) {
			p.addErr(e);
			return null;
		}
		return {
			pos: [c.pos.line, c.pos.col, c.pos.offset],
			name: name,
			lines: parseFilterNil(lines),
			nextIndex: c.data.getNextIndex(),
		};
		return null;
	})(p.cur, stack["name"], stack["lines"]);
}

private function _call_onnodeLines_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, lines:Any):Any {
		return lines;
		return null;
	})(p.cur, stack["lines"]);
}

private function _call_on_curLine_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return toStr(c.text);
		return null;
	})(p.cur,);
}

private function _call_onnodeLineType1x_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, expr:Any):Any {
		// return parseReturnCodeSectionLine(c, "@", expr.(string));
		return null;
	})(p.cur, stack["expr"]);
}

private function _call_onnodeLineType1_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, name, params:Any):Any {
		return parseReturnInvokeSectionLine(c, name, params);
		return null;
	})(p.cur, stack["name"], stack["params"]);
}

private function _call_onnodeLineType2_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, code:Any):Any {
		return parseReturnCodeSectionLine(c, "codeBlock", code);
		return null;
	})(p.cur, stack["code"]);
}

private function _call_on_nltEscape_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return "{";
		return null;
	})(p.cur,);
}

private function _call_on_nltChar_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return toStr(c.text);
		return null;
	})(p.cur,);
}

private function _call_onnodeLineText_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, items:Any):Any {
		var items2 = [];
		if (Std.isOfType(items, Array)) {
			var itemsX:Array<Any> = cast items;
			for (i in itemsX) {
				items2.push(i);
			}
		}
		var text = items2.join("");
		return parseReturnTextSectionLine(c, text);
		return null;
	})(p.cur, stack["items"]);
}

private function _call_onnodeLineExprBlock_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, expr:Any):Any {
		return parseReturnCodeSectionLine(c, "codeInText", expr);
		return null;
	})(p.cur, stack["expr"]);
}

private function _call_onnodeLineCommonText_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, items:Any):Any {
		var x = parseReturnTextSectionLine(c, "\n");
		var items2:Array<Any> = null;
		if (Std.isOfType(items, Array)) {
			items2 = cast items;
			items2.push(x);
		}
		return items2;
		return null;
	})(p.cur, stack["items"]);
}

private function _call_onfuncInvoke_2(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return [];
		return null;
	})(p.cur,);
}

private function _call_onfuncInvoke_7(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, first, rest:Any):Any {
		return gatherParams(first, rest);
		return null;
	})(p.cur, stack["first"], stack["rest"]);
}

private function _call_onfuncInvokeParamExtend_1(p:Parser):Any {
	var stack = p.vstack.first();
	var c = p.cur;
	return (function(c:Current, e:Any):Any {
		return e;
		return null;
	})(p.cur, stack["e"]);
}

private function _call_on_codeExpr_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return toStr(c.text);
		return null;
	})(p.cur,);
}

private function _call_onstringType_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return toStr(c.text);
		return null;
	})(p.cur,);
}

private function _call_onString_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		// c.text = bytes.Replace(c.text, []byte(`\/`), []byte(`/`), -1)
		// return strconv.Unquote(string(c.text))
		return null;
	})(p.cur,);
}

private function _call_oninteger_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return Std.parseInt(c.text);
		return null;
	})(p.cur,);
}

private function _call_onidentifier_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return toStr(c.text);
		return null;
	})(p.cur,);
}

private function _call_onCode_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return toStr(c.text);
		return null;
	})(p.cur,);
}

private function _call_onCodeExpr_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return toStr(c.text);
		return null;
	})(p.cur,);
}

private function _call_onCodeExpr2_1(p:Parser):Any {
	var c = p.cur;
	return (function(c:Current,):Any {
		return toStr(c.text);
		return null;
	})(p.cur,);
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

typedef RetValOk = {
	var val:Any;
	var ok:Bool;
}

// Option is a function that can set an option on the parser. It returns
// the previous setting as an Option.
// typedef Option = (p:Parser) -> Option; // 注: 这是个函数
typedef Option = (p:Parser) -> Any; // 注: 这是个函数，因static编译需求返回Any

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
	var data:ParserCustomData;
}

enum AllExpr {
	ActionExpr(e:ActionExpr);
	AndCodeExpr(e:AndCodeExpr);
	AndExpr(e:AndExpr);
	AndLogicalExpr(e:AndLogicalExpr);
	AnyMatcher(e:AnyMatcher);

	CharClassMatcher(e:CharClassMatcher);
	ChoiceExpr(e:ChoiceExpr);
	CodeExpr(e:CodeExpr);

	LabeledExpr(e:LabeledExpr);
	LitMatcher(e:LitMatcher);
	NotCodeExpr(e:NotCodeExpr);
	NotExpr(e:NotExpr);
	NotLogicalExpr(e:NotLogicalExpr);
	OneOrMoreExpr(e:OneOrMoreExpr);
	RecoveryExpr(e:RecoveryExpr);
	RuleRefExpr(e:RuleRefExpr);
	SeqExpr(e:SeqExpr);
	ThrowExpr(e:ThrowExpr);
	ZeroOrMoreExpr(e:ZeroOrMoreExpr);
	ZeroOrOneExpr(e:ZeroOrOneExpr);
}

typedef Grammar = {
	var rules:Array<Rule>;
}

typedef Rule = {
	var name:String;
	@:optional var displayName:String;
	var expr:AllExpr;
	@:optional var varExists:Bool;
}

typedef ChoiceExpr = {
	var alternatives:Array<AllExpr>;
}

typedef ActionExpr = {
	var expr:AllExpr;
	var run:(p:Parser) -> Any;
}

typedef RecoveryExpr = {
	var expr:AllExpr;
	var recoverExpr:AllExpr;
	var failureLabel:Array<String>;
}

typedef SeqExpr = {
	var exprs:Array<AllExpr>;
}

typedef ThrowExpr = {
	var label:String;
}

typedef LabeledExpr = {
	var label:String;
	var expr:AllExpr;
	var textCapture:Bool;
}

typedef Expr = {
	var expr:AllExpr;
}

typedef AndExpr = Expr;
typedef NotExpr = Expr;
typedef AndLogicalExpr = Expr;
typedef NotLogicalExpr = Expr;
typedef ZeroOrOneExpr = Expr;
typedef ZeroOrMoreExpr = Expr;
typedef OneOrMoreExpr = Expr;

typedef RuleRefExpr = {
	var name:String;
}

typedef AndCodeExpr = {
	var run:(p:Parser) -> Bool;
}

typedef NotCodeExpr = {
	var run:(p:Parser) -> Bool;
}

typedef LitMatcher = {
	var val:String;
	var want:String;
	@:optional var ignoreCase:Bool;
}

typedef CodeExpr = {
	var run:(p:Parser) -> Any;
	var notSkip:Bool;
}

typedef CharClassMatcher = {
	var val:String;
	@:optional var chars:Array<UInt>;
	@:optional var ranges:Array<UInt>;
	@:optional var classes:Array<Unicode.RangeTable>;
	@:optional var ignoreCase:Bool;
	@:optional var inverted:Bool;
}

typedef AnyMatcher = {}

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
				return parserErrorToString(this.lst[0]);
			default:
				var arr = [];
				for (i in this.lst) {
					arr.push(parserErrorToString(i));
				}
				return arr.join('\n');
		}
	}

	public function toException():Exception {
		if (this.lst.length == 0) {
			return null;
		}
		return new Exception('Parse Failed:\n' + this.err().error() + '\n');
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
function parserErrorToString(p:ParserError):String {
	return p.prefix + ": " + p.Inner.toString();
}

typedef ResultTuple = {
	var v:Any;
	var b:Bool;
	var end:Savepoint;
}

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
	public var rulesArray:Array<Rule>;
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

	public var _errPos:Position;
	// skip code stack
	public var scStack = new GenericStack<Bool>();

	// save point stack
	// public var spStack = new GenericStack<Savepoint>();
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
			data: new ParserCustomData(),
		};

		this.maxFailPos = {col: 1, line: 1, offset: 0};
		this.maxFailExpected = []; // make([]string, 0, 20),
		this.stats = stats;
		// start rule is rule [0] unless an alternate entrypoint is specified
		this.entrypoint = "input";

		// p.spStack.init(5)
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

	// setCustomData to the parser.
	function setCustomData(data:ParserCustomData) {
		this.cur.data = data;
	}

	// setCustomData to the parser.
	function checkSkipCode():Bool {
		return this.scStack.first();
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

	public function addErr(err:Exception) {
		// p.addErrAt(err, p.pt.position,[])
		this.addErrAt(err, this.pt, []);
	}

	public function addErrAt(err:Exception, pos:Position, expected:Array<String>) {
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

	function sliceFromOffset(offset:Int):String {
		return this.data.substring(offset, this.pt.offset);
	}

	public function buildRulesTable(g:Grammar):Void {
		this.rules = new Map<String, Rule>();
		for (r in g.rules) {
			this.rules[r.name] = r;
		}
	}

	public function parse(grammar:Grammar):Any {
		if (grammar == null) {
			grammar = g;
		}
		if (grammar.rules.length == 0) {
			this.addErr(Errors.errNoRule);
			throw this.errs.toException();
		}

		this.rulesArray = grammar.rules;
		this.buildRulesTable(grammar);
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
		if (rule.varExists && !this.checkSkipCode()) {
			this.rstack.add(rule);
			this.pushV();
			var ret = this.parseExprWrap(rule.expr);
			this.popV();
			this.rstack.pop();
			return ret;
		} else {
			this.rstack.add(rule);
			var ret = this.parseExprWrap(rule.expr);
			this.rstack.pop();
			return ret;
		}
	}

	function parseExprWrap(expr:AllExpr):RetValOk {
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
			case AndLogicalExpr(expr):
				ret = this.parseAndLogicalExpr(expr);
			case AnyMatcher(expr):
				ret = this.parseAnyMatcher(expr);
			case CharClassMatcher(expr):
				ret = this.parseCharClassMatcher(expr);
			case ChoiceExpr(expr):
				ret = this.parseChoiceExpr(expr);
			case CodeExpr(expr):
				ret = this.parseCodeExpr(expr);
			case LabeledExpr(expr):
				ret = this.parseLabeledExpr(expr);
			case LitMatcher(expr):
				ret = this.parseLitMatcher(expr);
			case NotCodeExpr(expr):
				ret = this.parseNotCodeExpr(expr);
			case NotExpr(expr):
				ret = this.parseNotExpr(expr);
			case NotLogicalExpr(expr):
				ret = this.parseNotLogicalExpr(expr);
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
		if (this.checkSkipCode()) {
			var ret = this.parseExprWrap(act.expr);
			return {val: null, ok: ret.ok};
		}

		var start = savepointClone(this.pt);
		var ret = this.parseExprWrap(act.expr);
		if (ret.ok) {
			// this.cur.pos = start.position;
			this.cur.pos = positionClone(start);
			this.cur.text = this.sliceFrom(start);
			this._errPos = start;
			var val = act.run(this);
			this._errPos = null;
			ret.val = val;
		}
		return ret;
	}

	function parseAndCodeExpr(and:AndCodeExpr):RetValOk {
		var ok = and.run(this);
		return {val: null, ok: ok};
	}

	function parseAndExpr(and:AndExpr):RetValOk {
		return this.parseAndExprBase(and, false);
	}

	function parseAndLogicalExpr(and:AndExpr):RetValOk {
		return this.parseAndExprBase(and, true);
	}

	function parseAndExprBase(and:AndExpr, logical:Bool):RetValOk {
		var pt = this.pt;

		this.scStack.add(true);
		var ret = this.parseExprWrap(and.expr);
		this.scStack.pop();

		var matchedOffset = this.pt.offset;
		this.restore(pt);

		if (logical) {
			return {val: null, ok: ret.ok && this.pt.offset != matchedOffset}
		}
		return {val: null, ok: ret.ok};
	}

	function parseAnyMatcher(act:AnyMatcher):RetValOk {
		// if p.pt.rn == utf8.RuneError && p.pt.w == 0 {
		if (this.pt.rn == 0 && this.pt.w == 0) {
			// EOF - see utf8.DecodeRune
			this.failAt(false, this.pt, ".");
			return {val: null, ok: false};
		}
		this.failAt(true, this.pt, ".");
		this.read();
		return {val: null, ok: true};
	}

	function parseCharClassMatcher(chr:CharClassMatcher):RetValOk {
		var cur = this.pt.rn;

		// can't match EOF
		if (cur == 0 && this.pt.w == 0) { // see utf8.DecodeRune
			this.failAt(false, this.pt, chr.val);
			return {val: null, ok: false};
		}

		if (chr.ignoreCase) {
			cur = String.fromCharCode(cur).toLowerCase().charCodeAt(0);
		}

		if (chr.chars != null) {
			// try to match in the list of available chars
			for (rn in chr.chars) {
				if (rn == cur) {
					if (chr.inverted) {
						this.failAt(false, this.pt, chr.val);
						return {val: null, ok: false};
					}
					this.failAt(true, this.pt, chr.val);
					this.read();
					return {val: null, ok: true};
				}
			}
		}

		if (chr.ranges != null) {
			// try to match in the list of ranges
			for (i in 0...chr.ranges.length) {
				if (i % 2 != 0)
					continue;
				if (cur >= chr.ranges[i] && cur <= chr.ranges[i + 1]) {
					if (chr.inverted) {
						this.failAt(false, this.pt, chr.val);
						return {val: null, ok: false};
					}
					this.failAt(true, this.pt, chr.val);
					this.read();
					return {val: null, ok: true};
				}
			}
		}

		// try to match in the list of Unicode classes
		if (chr.classes != null) {
			for (cl in chr.classes) {
				if (Unicode.Is(cl, cur)) {
					if (chr.inverted) {
						this.failAt(false, this.pt, chr.val);
						return {val: null, ok: false};
					}
					this.failAt(true, this.pt, chr.val);
					this.read();
					return {val: null, ok: true};
				}
			}
		}

		if (chr.inverted) {
			this.failAt(true, this.pt, chr.val);
			this.read();
			return {val: null, ok: true};
		}
		this.failAt(true, this.pt, chr.val);
		return {val: null, ok: false};
	}

	function parseChoiceExpr(ch:ChoiceExpr):RetValOk {
		// for altI, alt := range ch.alternatives {
		for (altI in 0...ch.alternatives.length) {
			var alt = ch.alternatives[altI];

			var ret = this.parseExprWrap(alt);
			if (ret.ok) {
				return ret;
			}
		}
		return {val: null, ok: false};
	}

	function parseLabeledExpr(lab:LabeledExpr):RetValOk {
		var startOffset = this.pt.offset;
		var ret = this.parseExprWrap(lab.expr);
		if (ret.ok && lab.label != "" && !this.checkSkipCode()) {
			var m = this.vstack.first();
			m[lab.label] = lab.textCapture ? this.sliceFromOffset(startOffset) : ret.val;
		}
		return ret;
	}

	function parseCodeExpr(code:CodeExpr):RetValOk {
		if (!code.notSkip && this.checkSkipCode()) {
			return {val: null, ok: true};
		}
		return {val: code.run(this), ok: false};
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
		return {val: null, ok: true};
	}

	function parseNotCodeExpr(code:NotCodeExpr):RetValOk {
		return {val: null, ok: !code.run(this)};
	}

	function parseNotExpr(not:NotExpr):RetValOk {
		return this.parseNotExprBase(not, false);
	}

	function parseNotLogicalExpr(not:NotLogicalExpr):RetValOk {
		return this.parseNotExprBase(not, true);
	}

	function parseNotExprBase(not:NotExpr, logical:Bool):RetValOk {
		var pt = savepointClone(this.pt);
		this.maxFailInvertExpected = !this.maxFailInvertExpected;

		this.scStack.add(true);
		var ret = this.parseExprWrap(not.expr);
		this.scStack.pop();

		this.maxFailInvertExpected = !this.maxFailInvertExpected;
		var matchedOffset = this.pt.offset;
		this.restore(pt);

		if (logical) {
			return {val: null, ok: !ret.ok && this.pt.offset != matchedOffset}
		}
		return {val: null, ok: !ret.ok};
	}

	function parseOneOrMoreExpr(expr:OneOrMoreExpr):RetValOk {
		var vals:Array<Any> = [];
		var matched = false;

		while (true) {
			var ret = this.parseExprWrap(expr.expr);
			if (!ret.ok) {
				if (vals.length > 0) {
					return {val: vals, ok: matched};
				}
				return {val: null, ok: matched};
			}
			matched = true;
			if (ret.val != null) {
				vals.push(ret.val);
			}
		}
	}

	function parseRecoveryExpr(recover:RecoveryExpr):RetValOk {
		this.pushRecovery(recover.failureLabel, recover.recoverExpr);
		var ret = this.parseExprWrap(recover.expr);
		this.popRecovery();
		return ret;
	}

	function parseRuleRefExpr(ref:RuleRefExpr):RetValOk {
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
		var notSkipCode = this.checkSkipCode();

		var pt = savepointClone(this.pt);
		for (expr in seq.exprs) {
			var ret = this.parseExprWrap(expr);
			if (!ret.ok) {
				this.restore(pt);
				return {val: null, ok: false};
			}
			if (notSkipCode && ret.val != null) {
				vals.push(ret.val);
			}
		}
		if (vals.length > 0) {
			return {val: vals, ok: true};
		}
		return {val: null, ok: true};
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
			var ret = this.parseExprWrap(expr.expr);
			if (!ret.ok) {
				if (vals.length > 0) {
					return {val: vals, ok: true};
				}
				return {val: null, ok: true};
			}
			if (ret.val != null) {
				vals.push(ret.val);
			}
		}
	}

	function parseZeroOrOneExpr(expr:ZeroOrOneExpr):RetValOk {
		var ret = this.parseExprWrap(expr.expr);
		// whether it matched or not, consider it a match
		return {val: ret.val, ok: true};
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
