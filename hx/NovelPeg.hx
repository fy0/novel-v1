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
				items.push(i);
			}
		}
	}
	return items;
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
			pos: {line: 127, col: 1, offset: 2549},
			expr: ActionExpr({
				pos: {line: 127, col: 10, offset: 2558},
				run: _calloninput1,
				expr: SeqExpr({
					pos: {line: 127, col: 10, offset: 2558},
					exprs: [
						ZeroOrMoreExpr({
							pos: {line: 334, col: 20, offset: 8737},
							expr: CharClassMatcher({
								pos: {line: 334, col: 20, offset: 8737},
								val: "[ \\n\\t\\r]",
								chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
								ranges: [],
								ignoreCase: false,
								inverted: false,
							}),
						}),
						LabeledExpr({
							pos: {line: 127, col: 13, offset: 2561},
							label: "x",
							expr: ActionExpr({
								pos: {line: 131, col: 10, offset: 2618},
								run: _calloninput6,
								expr: LabeledExpr({
									pos: {line: 131, col: 10, offset: 2618},
									label: "nodes",
									expr: ZeroOrMoreExpr({
										pos: {line: 131, col: 17, offset: 2625},
										expr: ChoiceExpr({
											pos: {line: 149, col: 9, offset: 3157},
											alternatives: [
												ActionExpr({
													pos: {line: 151, col: 14, offset: 3195},
													run: _calloninput10,
													expr: SeqExpr({
														pos: {line: 151, col: 14, offset: 3195},
														exprs: [
															LitMatcher({
																pos: {line: 151, col: 14, offset: 3195},
																val: ":",
																ignoreCase: false,
																want: "\":\"",
															}),
															ZeroOrMoreExpr({
																pos: {line: 336, col: 11, offset: 8761},
																expr: CharClassMatcher({
																	pos: {line: 336, col: 11, offset: 8761},
																	val: "[ \\t]",
																	chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: false,
																}),
															}),
															LabeledExpr({
																pos: {line: 151, col: 25, offset: 3206},
																label: "name",
																expr: ZeroOrOneExpr({
																	pos: {line: 151, col: 30, offset: 3211},
																	expr: ActionExpr({
																		pos: {line: 324, col: 15, offset: 8415},
																		run: _calloninput17,
																		expr: SeqExpr({
																			pos: {line: 324, col: 15, offset: 8415},
																			exprs: [
																				CharClassMatcher({
																					pos: {line: 329, col: 13, offset: 8521},
																					val: "[_\\pL\\pOther_ID_Start]",
																					chars: ['_'.charCodeAt(0),],
																					ranges: [],
																					classes: [Unicode.L, Unicode.Other_ID_Start,],
																					ignoreCase: false,
																					inverted: false,
																				}),
																				ZeroOrMoreExpr({
																					pos: {line: 324, col: 24, offset: 8424},
																					expr: CharClassMatcher({
																						pos: {line: 332, col: 16, offset: 8638},
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
																pos: {line: 336, col: 11, offset: 8761},
																expr: CharClassMatcher({
																	pos: {line: 336, col: 11, offset: 8761},
																	val: "[ \\t]",
																	chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: false,
																}),
															}),
															LabeledExpr({
																pos: {line: 151, col: 50, offset: 3231},
																label: "cond",
																expr: ActionExpr({
																	pos: {line: 146, col: 14, offset: 3015},
																	run: _calloninput25,
																	expr: SeqExpr({
																		pos: {line: 146, col: 14, offset: 3015},
																		exprs: [
																			LitMatcher({
																				pos: {line: 146, col: 14, offset: 3015},
																				val: "[",
																				ignoreCase: false,
																				want: "\"[\"",
																			}),
																			LabeledExpr({
																				pos: {line: 146, col: 18, offset: 3019},
																				label: "cond",
																				expr: ZeroOrOneExpr({
																					pos: {line: 146, col: 23, offset: 3024},
																					expr: ActionExpr({
																						pos: {line: 145, col: 21, offset: 2954},
																						run: _calloninput30,
																						expr: OneOrMoreExpr({
																							pos: {line: 145, col: 21, offset: 2954},
																							expr: CharClassMatcher({
																								pos: {line: 145, col: 21, offset: 2954},
																								val: "[^]]",
																								chars: [']'.charCodeAt(0),],
																								ranges: [],
																								ignoreCase: false,
																								inverted: true,
																							}),
																						}),
																					}),
																				}),
																			}),
																			LitMatcher({
																				pos: {line: 146, col: 41, offset: 3042},
																				val: "]",
																				ignoreCase: false,
																				want: "\"]\"",
																			}),
																		],
																	}),
																}),
															}),
															ZeroOrMoreExpr({
																pos: {line: 336, col: 11, offset: 8761},
																expr: CharClassMatcher({
																	pos: {line: 336, col: 11, offset: 8761},
																	val: "[ \\t]",
																	chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: false,
																}),
															}),
															LabeledExpr({
																pos: {line: 151, col: 72, offset: 3253},
																label: "next",
																expr: ZeroOrOneExpr({
																	pos: {line: 151, col: 77, offset: 3258},
																	expr: ActionExpr({
																		pos: {line: 147, col: 14, offset: 3091},
																		run: _calloninput38,
																		expr: SeqExpr({
																			pos: {line: 147, col: 14, offset: 3091},
																			exprs: [
																				LitMatcher({
																					pos: {line: 147, col: 14, offset: 3091},
																					val: "[",
																					ignoreCase: false,
																					want: "\"[\"",
																				}),
																				LabeledExpr({
																					pos: {line: 147, col: 18, offset: 3095},
																					label: "name",
																					expr: ActionExpr({
																						pos: {line: 324, col: 15, offset: 8415},
																						run: _calloninput42,
																						expr: SeqExpr({
																							pos: {line: 324, col: 15, offset: 8415},
																							exprs: [
																								CharClassMatcher({
																									pos: {line: 329, col: 13, offset: 8521},
																									val: "[_\\pL\\pOther_ID_Start]",
																									chars: ['_'.charCodeAt(0),],
																									ranges: [],
																									classes: [Unicode.L, Unicode.Other_ID_Start,],
																									ignoreCase: false,
																									inverted: false,
																								}),
																								ZeroOrMoreExpr({
																									pos: {line: 324, col: 24, offset: 8424},
																									expr: CharClassMatcher({
																										pos: {line: 332, col: 16, offset: 8638},
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
																					pos: {line: 147, col: 34, offset: 3111},
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
																pos: {line: 336, col: 11, offset: 8761},
																expr: CharClassMatcher({
																	pos: {line: 336, col: 11, offset: 8761},
																	val: "[ \\t]",
																	chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: false,
																}),
															}),
															CharClassMatcher({
																pos: {line: 338, col: 7, offset: 8777},
																val: "[\\r\\n]",
																chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																ranges: [],
																ignoreCase: false,
																inverted: false,
															}),
															LabeledExpr({
																pos: {line: 151, col: 99, offset: 3280},
																label: "lines",
																expr: ActionExpr({
																	pos: {line: 215, col: 14, offset: 5003},
																	run: _calloninput52,
																	expr: SeqExpr({
																		pos: {line: 215, col: 14, offset: 5003},
																		exprs: [
																			LabeledExpr({
																				pos: {line: 215, col: 14, offset: 5003},
																				label: "lines",
																				expr: ZeroOrMoreExpr({
																					pos: {line: 215, col: 20, offset: 5009},
																					expr: ChoiceExpr({
																						pos: {line: 217, col: 13, offset: 5069},
																						alternatives: [
																							ActionExpr({
																								pos: {line: 219, col: 24, offset: 5163},
																								run: _calloninput57,
																								expr: SeqExpr({
																									pos: {line: 219, col: 24, offset: 5163},
																									exprs: [
																										LitMatcher({
																											pos: {line: 219, col: 24, offset: 5163},
																											val: "@#",
																											ignoreCase: false,
																											want: "\"@#\"",
																										}),
																										OneOrMoreExpr({
																											pos: {line: 219, col: 32, offset: 5171},
																											expr: SeqExpr({
																												pos: {line: 219, col: 33, offset: 5172},
																												exprs: [
																													NotExpr({
																														pos: {line: 219, col: 33, offset: 5172},
																														expr: CharClassMatcher({
																															pos: {line: 338, col: 7,
																																offset: 8777},
																															val: "[\\r\\n]",
																															chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																															ranges: [],
																															ignoreCase: false,
																															inverted: false,
																														}),
																													}),
																													AnyMatcher({
																														line: 219,
																														col: 37,
																														offset: 5176,
																													}),
																												],
																											}),
																										}),
																										CharClassMatcher({
																											pos: {line: 338, col: 7, offset: 8777},
																											val: "[\\r\\n]",
																											chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																											ranges: [],
																											ignoreCase: false,
																											inverted: false,
																										}),
																										ZeroOrMoreExpr({
																											pos: {line: 334, col: 20, offset: 8737},
																											expr: CharClassMatcher({
																												pos: {line: 334, col: 20, offset: 8737},
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
																							ActionExpr({
																								pos: {line: 221, col: 18, offset: 5236},
																								run: _calloninput68,
																								expr: SeqExpr({
																									pos: {line: 221, col: 18, offset: 5236},
																									exprs: [
																										LitMatcher({
																											pos: {line: 221, col: 18, offset: 5236},
																											val: "@",
																											ignoreCase: false,
																											want: "\"@\"",
																										}),
																										LabeledExpr({
																											pos: {line: 221, col: 22, offset: 5240},
																											label: "name",
																											expr: ActionExpr({
																												pos: {line: 324, col: 15, offset: 8415},
																												run: _calloninput72,
																												expr: SeqExpr({
																													pos: {line: 324, col: 15, offset: 8415},
																													exprs: [
																														CharClassMatcher({
																															pos: {line: 329, col: 13,
																																offset: 8521},
																															val: "[_\\pL\\pOther_ID_Start]",
																															chars: ['_'.charCodeAt(0),],
																															ranges: [],
																															classes: [Unicode.L, Unicode.Other_ID_Start,],
																															ignoreCase: false,
																															inverted: false,
																														}),
																														ZeroOrMoreExpr({
																															pos: {line: 324, col: 24,
																																offset: 8424},
																															expr: CharClassMatcher({
																																pos: {line: 332, col: 16,
																																	offset: 8638},
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
																										LabeledExpr({
																											pos: {line: 221, col: 38, offset: 5256},
																											label: "params",
																											expr: ChoiceExpr({
																												pos: {line: 282, col: 15, offset: 6890},
																												alternatives: [
																													ActionExpr({
																														pos: {line: 282, col: 15, offset: 6890},
																														run: _calloninput79,
																														expr: SeqExpr({
																															pos: {line: 282, col: 15,
																																offset: 6890},
																															exprs: [
																																LitMatcher({
																																	pos: {line: 282, col: 15,
																																		offset: 6890},
																																	val: "(",
																																	ignoreCase: false,
																																	want: "\"(\"",
																																}),
																																ZeroOrMoreExpr({
																																	pos: {line: 334, col: 20,
																																		offset: 8737},
																																	expr: CharClassMatcher({
																																		pos: {line: 334,
																																			col: 20,
																																			offset: 8737},
																																		val: "[ \\n\\t\\r]",
																																		chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
																																		ranges: [],
																																		ignoreCase: false,
																																		inverted: false,
																																	}),
																																}),
																																LitMatcher({
																																	pos: {line: 282, col: 22,
																																		offset: 6897},
																																	val: ")",
																																	ignoreCase: false,
																																	want: "\")\"",
																																}),
																															],
																														}),
																													}),
																													ActionExpr({
																														pos: {line: 283, col: 15, offset: 7023},
																														run: _calloninput85,
																														expr: SeqExpr({
																															pos: {line: 283, col: 15,
																																offset: 7023},
																															exprs: [
																																LitMatcher({
																																	pos: {line: 283, col: 15,
																																		offset: 7023},
																																	val: "(",
																																	ignoreCase: false,
																																	want: "\"(\"",
																																}),
																																ZeroOrMoreExpr({
																																	pos: {line: 334, col: 20,
																																		offset: 8737},
																																	expr: CharClassMatcher({
																																		pos: {line: 334,
																																			col: 20,
																																			offset: 8737},
																																		val: "[ \\n\\t\\r]",
																																		chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
																																		ranges: [],
																																		ignoreCase: false,
																																		inverted: false,
																																	}),
																																}),
																																LabeledExpr({
																																	pos: {line: 283, col: 22,
																																		offset: 7030},
																																	label: "first",
																																	expr: ActionExpr({
																																		pos: {line: 288,
																																			col: 13,
																																			offset: 7288},
																																		run: _calloninput91,
																																		expr: ChoiceExpr({
																																			pos: {line: 290,
																																				col: 14,
																																				offset: 7354},
																																			alternatives: [
																																				ActionExpr({
																																					pos: {line: 324,
																																						col: 15,
																																						offset: 8415},
																																					run: _calloninput93,
																																					expr: SeqExpr({
																																						pos: {line: 324,
																																							col: 15,
																																							offset: 8415},
																																						exprs: [
																																							CharClassMatcher({
																																								pos: {line: 329,
																																									col: 13,
																																									offset: 8521},
																																								val: "[_\\pL\\pOther_ID_Start]",
																																								chars: ['_'.charCodeAt(0),],
																																								ranges: [],
																																								classes: [Unicode.L, Unicode.Other_ID_Start,],
																																								ignoreCase: false,
																																								inverted: false,
																																							}),
																																							ZeroOrMoreExpr({
																																								pos: {line: 324,
																																									col: 24,
																																									offset: 8424},
																																								expr: CharClassMatcher({
																																									pos: {line: 332,
																																										col: 16,
																																										offset: 8638},
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
																																				ActionExpr({
																																					pos: {line: 316,
																																						col: 12,
																																						offset: 8242},
																																					run: _calloninput98,
																																					expr: SeqExpr({
																																						pos: {line: 316,
																																							col: 12,
																																							offset: 8242},
																																						exprs: [
																																							ZeroOrOneExpr({
																																								pos: {line: 316,
																																									col: 12,
																																									offset: 8242},
																																								expr: LitMatcher({
																																									pos: {line: 316,
																																										col: 12,
																																										offset: 8242},
																																									val: "-",
																																									ignoreCase: false,
																																									want: "\"-\"",
																																								}),
																																							}),
																																							OneOrMoreExpr({
																																								pos: {line: 316,
																																									col: 17,
																																									offset: 8247},
																																								expr: CharClassMatcher({
																																									pos: {line: 316,
																																										col: 17,
																																										offset: 8247},
																																									val: "[0-9]",
																																									chars: [],
																																									ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																									ignoreCase: false,
																																									inverted: false,
																																								}),
																																							}),
																																						],
																																					}),
																																				}),
																																				SeqExpr({
																																					pos: {line: 292,
																																						col: 14,
																																						offset: 7401},
																																					exprs: [
																																						ZeroOrMoreExpr({
																																							pos: {line: 292,
																																								col: 14,
																																								offset: 7401},
																																							expr: CharClassMatcher({
																																								pos: {line: 292,
																																									col: 14,
																																									offset: 7401},
																																								val: "[0-9]",
																																								chars: [],
																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																								ignoreCase: false,
																																								inverted: false,
																																							}),
																																						}),
																																						LitMatcher({
																																							pos: {line: 292,
																																								col: 21,
																																								offset: 7408},
																																							val: ".",
																																							ignoreCase: false,
																																							want: "\".\"",
																																						}),
																																						OneOrMoreExpr({
																																							pos: {line: 292,
																																								col: 25,
																																								offset: 7412},
																																							expr: CharClassMatcher({
																																								pos: {line: 292,
																																									col: 25,
																																									offset: 7412},
																																								val: "[0-9]",
																																								chars: [],
																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																								ignoreCase: false,
																																								inverted: false,
																																							}),
																																						}),
																																					],
																																				}),
																																				ActionExpr({
																																					pos: {line: 295,
																																						col: 15,
																																						offset: 7461},
																																					run: _calloninput110,
																																					expr: ChoiceExpr({
																																						pos: {line: 295,
																																							col: 16,
																																							offset: 7462},
																																						alternatives: [
																																							SeqExpr({
																																								pos: {line: 297,
																																									col: 14,
																																									offset: 7548},
																																								exprs: [
																																									LitMatcher({
																																										pos: {line: 297,
																																											col: 14,
																																											offset: 7548},
																																										val: "\"",
																																										ignoreCase: false,
																																										want: "\"\\\"\"",
																																									}),
																																									ZeroOrMoreExpr({
																																										pos: {line: 297,
																																											col: 18,
																																											offset: 7552},
																																										expr: ChoiceExpr({
																																											pos: {line: 297,
																																												col: 20,
																																												offset: 7554},
																																											alternatives: [
																																												SeqExpr({
																																													pos: {line: 297,
																																														col: 20,
																																														offset: 7554},
																																													exprs: [
																																														NotExpr({
																																															pos: {line: 297,
																																																col: 20,
																																																offset: 7554},
																																															expr: CharClassMatcher({
																																																pos: {line: 308,
																																																	col: 15,
																																																	offset: 7988},
																																																val: "[\"\\\\\\x00-\\x1f]",
																																																chars: ['"'.charCodeAt(0), '\\'.charCodeAt(0),],
																																																ranges: ['\x00'.charCodeAt(0), '\x1f'.charCodeAt(0),],
																																																ignoreCase: false,
																																																inverted: false,
																																															}),
																																														}),
																																														AnyMatcher({
																																															line: 297,
																																															col: 33,
																																															offset: 7567,
																																														}),
																																													],
																																												}),
																																												SeqExpr({
																																													pos: {line: 297,
																																														col: 37,
																																														offset: 7571},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 297,
																																																col: 37,
																																																offset: 7571},
																																															val: "\\",
																																															ignoreCase: false,
																																															want: "\"\\\\\"",
																																														}),
																																														ChoiceExpr({
																																															pos: {line: 309,
																																																col: 18,
																																																offset: 8023},
																																															alternatives: [
																																																CharClassMatcher({
																																																	pos: {line: 310,
																																																		col: 20,
																																																		offset: 8078},
																																																	val: "[\"\\\\/bfnrt]",
																																																	chars: [
																																																		'"'.charCodeAt(0),
																																																		'\\'.charCodeAt(0),
																																																		'/'.charCodeAt(0),
																																																		'b'.charCodeAt(0),
																																																		'f'.charCodeAt(0),
																																																		'n'.charCodeAt(0),
																																																		'r'.charCodeAt(0),
																																																		't'.charCodeAt(0),
																																																	],
																																																	ranges: [],
																																																	ignoreCase: false,
																																																	inverted: false,
																																																}),
																																																SeqExpr({
																																																	pos: {line: 311,
																																																		col: 17,
																																																		offset: 8109},
																																																	exprs: [
																																																		LitMatcher({
																																																			pos: {line: 311,
																																																				col: 17,
																																																				offset: 8109},
																																																			val: "u",
																																																			ignoreCase: false,
																																																			want: "\"u\"",
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																	],
																																																}),
																																															],
																																														}),
																																													],
																																												}),
																																											],
																																										}),
																																									}),
																																									LitMatcher({
																																										pos: {line: 297,
																																											col: 60,
																																											offset: 7594},
																																										val: "\"",
																																										ignoreCase: false,
																																										want: "\"\\\"\"",
																																									}),
																																								],
																																							}),
																																							SeqExpr({
																																								pos: {line: 298,
																																									col: 14,
																																									offset: 7612},
																																								exprs: [
																																									LitMatcher({
																																										pos: {line: 298,
																																											col: 14,
																																											offset: 7612},
																																										val: "'",
																																										ignoreCase: false,
																																										want: "\"'\"",
																																									}),
																																									ZeroOrMoreExpr({
																																										pos: {line: 298,
																																											col: 19,
																																											offset: 7617},
																																										expr: ChoiceExpr({
																																											pos: {line: 298,
																																												col: 21,
																																												offset: 7619},
																																											alternatives: [
																																												SeqExpr({
																																													pos: {line: 298,
																																														col: 21,
																																														offset: 7619},
																																													exprs: [
																																														NotExpr({
																																															pos: {line: 298,
																																																col: 21,
																																																offset: 7619},
																																															expr: CharClassMatcher({
																																																pos: {line: 300,
																																																	col: 16,
																																																	offset: 7686},
																																																val: "[\\\\\\\\x00-\\x1f]",
																																																chars: ['\''.charCodeAt(0), '\\'.charCodeAt(0),],
																																																ranges: ['\x00'.charCodeAt(0), '\x1f'.charCodeAt(0),],
																																																ignoreCase: false,
																																																inverted: false,
																																															}),
																																														}),
																																														AnyMatcher({
																																															line: 298,
																																															col: 35,
																																															offset: 7633,
																																														}),
																																													],
																																												}),
																																												SeqExpr({
																																													pos: {line: 298,
																																														col: 39,
																																														offset: 7637},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 298,
																																																col: 39,
																																																offset: 7637},
																																															val: "\\",
																																															ignoreCase: false,
																																															want: "\"\\\\\"",
																																														}),
																																														ChoiceExpr({
																																															pos: {line: 301,
																																																col: 19,
																																																offset: 7722},
																																															alternatives: [
																																																CharClassMatcher({
																																																	pos: {line: 302,
																																																		col: 21,
																																																		offset: 7779},
																																																	val: "[\\\\\\/bfnrt]",
																																																	chars: [
																																																		'\''.charCodeAt(0),
																																																		'\\'.charCodeAt(0),
																																																		'/'.charCodeAt(0),
																																																		'b'.charCodeAt(0),
																																																		'f'.charCodeAt(0),
																																																		'n'.charCodeAt(0),
																																																		'r'.charCodeAt(0),
																																																		't'.charCodeAt(0),
																																																	],
																																																	ranges: [],
																																																	ignoreCase: false,
																																																	inverted: false,
																																																}),
																																																SeqExpr({
																																																	pos: {line: 311,
																																																		col: 17,
																																																		offset: 8109},
																																																	exprs: [
																																																		LitMatcher({
																																																			pos: {line: 311,
																																																				col: 17,
																																																				offset: 8109},
																																																			val: "u",
																																																			ignoreCase: false,
																																																			want: "\"u\"",
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																	],
																																																}),
																																															],
																																														}),
																																													],
																																												}),
																																											],
																																										}),
																																									}),
																																									LitMatcher({
																																										pos: {line: 298,
																																											col: 63,
																																											offset: 7661},
																																										val: "'",
																																										ignoreCase: false,
																																										want: "\"'\"",
																																									}),
																																								],
																																							}),
																																							SeqExpr({
																																								pos: {line: 295,
																																									col: 29,
																																									offset: 7475},
																																								exprs: [
																																									LitMatcher({
																																										pos: {line: 295,
																																											col: 29,
																																											offset: 7475},
																																										val: "`",
																																										ignoreCase: false,
																																										want: "\"`\"",
																																									}),
																																									ZeroOrMoreExpr({
																																										pos: {line: 295,
																																											col: 33,
																																											offset: 7479},
																																										expr: CharClassMatcher({
																																											pos: {line: 295,
																																												col: 33,
																																												offset: 7479},
																																											val: "[^`]",
																																											chars: ['`'.charCodeAt(0),],
																																											ranges: [],
																																											ignoreCase: false,
																																											inverted: true,
																																										}),
																																									}),
																																									LitMatcher({
																																										pos: {line: 295,
																																											col: 39,
																																											offset: 7485},
																																										val: "`",
																																										ignoreCase: false,
																																										want: "\"`\"",
																																									}),
																																								],
																																							}),
																																						],
																																					}),
																																				}),
																																			],
																																		}),
																																	}),
																																}),
																																LabeledExpr({
																																	pos: {line: 283, col: 37,
																																		offset: 7045},
																																	label: "rest",
																																	expr: ZeroOrMoreExpr({
																																		pos: {line: 283,
																																			col: 43,
																																			offset: 7051},
																																		expr: ActionExpr({
																																			pos: {line: 285,
																																				col: 26,
																																				offset: 7159},
																																			run: _calloninput157,
																																			expr: SeqExpr({
																																				pos: {line: 285,
																																					col: 26,
																																					offset: 7159},
																																				exprs: [
																																					ZeroOrMoreExpr({
																																						pos: {line: 334,
																																							col: 20,
																																							offset: 8737},
																																						expr: CharClassMatcher({
																																							pos: {line: 334,
																																								col: 20,
																																								offset: 8737},
																																							val: "[ \\n\\t\\r]",
																																							chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
																																							ranges: [],
																																							ignoreCase: false,
																																							inverted: false,
																																						}),
																																					}),
																																					LitMatcher({
																																						pos: {line: 285,
																																							col: 29,
																																							offset: 7162},
																																						val: ",",
																																						ignoreCase: false,
																																						want: "\",\"",
																																					}),
																																					ZeroOrMoreExpr({
																																						pos: {line: 334,
																																							col: 20,
																																							offset: 8737},
																																						expr: CharClassMatcher({
																																							pos: {line: 334,
																																								col: 20,
																																								offset: 8737},
																																							val: "[ \\n\\t\\r]",
																																							chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
																																							ranges: [],
																																							ignoreCase: false,
																																							inverted: false,
																																						}),
																																					}),
																																					LabeledExpr({
																																						pos: {line: 285,
																																							col: 36,
																																							offset: 7169},
																																						label: "e",
																																						expr: ActionExpr({
																																							pos: {line: 288,
																																								col: 13,
																																								offset: 7288},
																																							run: _calloninput165,
																																							expr: ChoiceExpr({
																																								pos: {line: 290,
																																									col: 14,
																																									offset: 7354},
																																								alternatives: [
																																									ActionExpr({
																																										pos: {line: 324,
																																											col: 15,
																																											offset: 8415},
																																										run: _calloninput167,
																																										expr: SeqExpr({
																																											pos: {line: 324,
																																												col: 15,
																																												offset: 8415},
																																											exprs: [
																																												CharClassMatcher({
																																													pos: {line: 329,
																																														col: 13,
																																														offset: 8521},
																																													val: "[_\\pL\\pOther_ID_Start]",
																																													chars: ['_'.charCodeAt(0),],
																																													ranges: [],
																																													classes: [Unicode.L, Unicode.Other_ID_Start,],
																																													ignoreCase: false,
																																													inverted: false,
																																												}),
																																												ZeroOrMoreExpr({
																																													pos: {line: 324,
																																														col: 24,
																																														offset: 8424},
																																													expr: CharClassMatcher({
																																														pos: {line: 332,
																																															col: 16,
																																															offset: 8638},
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
																																									ActionExpr({
																																										pos: {line: 316,
																																											col: 12,
																																											offset: 8242},
																																										run: _calloninput172,
																																										expr: SeqExpr({
																																											pos: {line: 316,
																																												col: 12,
																																												offset: 8242},
																																											exprs: [
																																												ZeroOrOneExpr({
																																													pos: {line: 316,
																																														col: 12,
																																														offset: 8242},
																																													expr: LitMatcher({
																																														pos: {line: 316,
																																															col: 12,
																																															offset: 8242},
																																														val: "-",
																																														ignoreCase: false,
																																														want: "\"-\"",
																																													}),
																																												}),
																																												OneOrMoreExpr({
																																													pos: {line: 316,
																																														col: 17,
																																														offset: 8247},
																																													expr: CharClassMatcher({
																																														pos: {line: 316,
																																															col: 17,
																																															offset: 8247},
																																														val: "[0-9]",
																																														chars: [],
																																														ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																														ignoreCase: false,
																																														inverted: false,
																																													}),
																																												}),
																																											],
																																										}),
																																									}),
																																									SeqExpr({
																																										pos: {line: 292,
																																											col: 14,
																																											offset: 7401},
																																										exprs: [
																																											ZeroOrMoreExpr({
																																												pos: {line: 292,
																																													col: 14,
																																													offset: 7401},
																																												expr: CharClassMatcher({
																																													pos: {line: 292,
																																														col: 14,
																																														offset: 7401},
																																													val: "[0-9]",
																																													chars: [],
																																													ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																													ignoreCase: false,
																																													inverted: false,
																																												}),
																																											}),
																																											LitMatcher({
																																												pos: {line: 292,
																																													col: 21,
																																													offset: 7408},
																																												val: ".",
																																												ignoreCase: false,
																																												want: "\".\"",
																																											}),
																																											OneOrMoreExpr({
																																												pos: {line: 292,
																																													col: 25,
																																													offset: 7412},
																																												expr: CharClassMatcher({
																																													pos: {line: 292,
																																														col: 25,
																																														offset: 7412},
																																													val: "[0-9]",
																																													chars: [],
																																													ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																													ignoreCase: false,
																																													inverted: false,
																																												}),
																																											}),
																																										],
																																									}),
																																									ActionExpr({
																																										pos: {line: 295,
																																											col: 15,
																																											offset: 7461},
																																										run: _calloninput184,
																																										expr: ChoiceExpr({
																																											pos: {line: 295,
																																												col: 16,
																																												offset: 7462},
																																											alternatives: [
																																												SeqExpr({
																																													pos: {line: 297,
																																														col: 14,
																																														offset: 7548},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 297,
																																																col: 14,
																																																offset: 7548},
																																															val: "\"",
																																															ignoreCase: false,
																																															want: "\"\\\"\"",
																																														}),
																																														ZeroOrMoreExpr({
																																															pos: {line: 297,
																																																col: 18,
																																																offset: 7552},
																																															expr: ChoiceExpr({
																																																pos: {line: 297,
																																																	col: 20,
																																																	offset: 7554},
																																																alternatives: [
																																																	SeqExpr({
																																																		pos: {line: 297,
																																																			col: 20,
																																																			offset: 7554},
																																																		exprs: [
																																																			NotExpr({
																																																				pos: {line: 297,
																																																					col: 20,
																																																					offset: 7554},
																																																				expr: CharClassMatcher({
																																																					pos: {line: 308,
																																																						col: 15,
																																																						offset: 7988},
																																																					val: "[\"\\\\\\x00-\\x1f]",
																																																					chars: ['"'.charCodeAt(0), '\\'.charCodeAt(0),],
																																																					ranges: ['\x00'.charCodeAt(0), '\x1f'.charCodeAt(0),],
																																																					ignoreCase: false,
																																																					inverted: false,
																																																				}),
																																																			}),
																																																			AnyMatcher({
																																																				line: 297,
																																																				col: 33,
																																																				offset: 7567,
																																																			}),
																																																		],
																																																	}),
																																																	SeqExpr({
																																																		pos: {line: 297,
																																																			col: 37,
																																																			offset: 7571},
																																																		exprs: [
																																																			LitMatcher({
																																																				pos: {line: 297,
																																																					col: 37,
																																																					offset: 7571},
																																																				val: "\\",
																																																				ignoreCase: false,
																																																				want: "\"\\\\\"",
																																																			}),
																																																			ChoiceExpr({
																																																				pos: {line: 309,
																																																					col: 18,
																																																					offset: 8023},
																																																				alternatives: [
																																																					CharClassMatcher({
																																																						pos: {line: 310,
																																																							col: 20,
																																																							offset: 8078},
																																																						val: "[\"\\\\/bfnrt]",
																																																						chars: [
																																																							'"'.charCodeAt(0),
																																																							'\\'.charCodeAt(0),
																																																							'/'.charCodeAt(0),
																																																							'b'.charCodeAt(0),
																																																							'f'.charCodeAt(0),
																																																							'n'.charCodeAt(0),
																																																							'r'.charCodeAt(0),
																																																							't'.charCodeAt(0),
																																																						],
																																																						ranges: [],
																																																						ignoreCase: false,
																																																						inverted: false,
																																																					}),
																																																					SeqExpr({
																																																						pos: {line: 311,
																																																							col: 17,
																																																							offset: 8109},
																																																						exprs: [
																																																							LitMatcher({
																																																								pos: {
																																																									line: 311,
																																																									col: 17,
																																																									offset: 8109
																																																								},
																																																								val: "u",
																																																								ignoreCase: false,
																																																								want: "\"u\"",
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																						],
																																																					}),
																																																				],
																																																			}),
																																																		],
																																																	}),
																																																],
																																															}),
																																														}),
																																														LitMatcher({
																																															pos: {line: 297,
																																																col: 60,
																																																offset: 7594},
																																															val: "\"",
																																															ignoreCase: false,
																																															want: "\"\\\"\"",
																																														}),
																																													],
																																												}),
																																												SeqExpr({
																																													pos: {line: 298,
																																														col: 14,
																																														offset: 7612},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 298,
																																																col: 14,
																																																offset: 7612},
																																															val: "'",
																																															ignoreCase: false,
																																															want: "\"'\"",
																																														}),
																																														ZeroOrMoreExpr({
																																															pos: {line: 298,
																																																col: 19,
																																																offset: 7617},
																																															expr: ChoiceExpr({
																																																pos: {line: 298,
																																																	col: 21,
																																																	offset: 7619},
																																																alternatives: [
																																																	SeqExpr({
																																																		pos: {line: 298,
																																																			col: 21,
																																																			offset: 7619},
																																																		exprs: [
																																																			NotExpr({
																																																				pos: {line: 298,
																																																					col: 21,
																																																					offset: 7619},
																																																				expr: CharClassMatcher({
																																																					pos: {line: 300,
																																																						col: 16,
																																																						offset: 7686},
																																																					val: "[\\\\\\\\x00-\\x1f]",
																																																					chars: ['\''.charCodeAt(0), '\\'.charCodeAt(0),],
																																																					ranges: ['\x00'.charCodeAt(0), '\x1f'.charCodeAt(0),],
																																																					ignoreCase: false,
																																																					inverted: false,
																																																				}),
																																																			}),
																																																			AnyMatcher({
																																																				line: 298,
																																																				col: 35,
																																																				offset: 7633,
																																																			}),
																																																		],
																																																	}),
																																																	SeqExpr({
																																																		pos: {line: 298,
																																																			col: 39,
																																																			offset: 7637},
																																																		exprs: [
																																																			LitMatcher({
																																																				pos: {line: 298,
																																																					col: 39,
																																																					offset: 7637},
																																																				val: "\\",
																																																				ignoreCase: false,
																																																				want: "\"\\\\\"",
																																																			}),
																																																			ChoiceExpr({
																																																				pos: {line: 301,
																																																					col: 19,
																																																					offset: 7722},
																																																				alternatives: [
																																																					CharClassMatcher({
																																																						pos: {line: 302,
																																																							col: 21,
																																																							offset: 7779},
																																																						val: "[\\\\\\/bfnrt]",
																																																						chars: [
																																																							'\''.charCodeAt(0),
																																																							'\\'.charCodeAt(0),
																																																							'/'.charCodeAt(0),
																																																							'b'.charCodeAt(0),
																																																							'f'.charCodeAt(0),
																																																							'n'.charCodeAt(0),
																																																							'r'.charCodeAt(0),
																																																							't'.charCodeAt(0),
																																																						],
																																																						ranges: [],
																																																						ignoreCase: false,
																																																						inverted: false,
																																																					}),
																																																					SeqExpr({
																																																						pos: {line: 311,
																																																							col: 17,
																																																							offset: 8109},
																																																						exprs: [
																																																							LitMatcher({
																																																								pos: {
																																																									line: 311,
																																																									col: 17,
																																																									offset: 8109
																																																								},
																																																								val: "u",
																																																								ignoreCase: false,
																																																								want: "\"u\"",
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																						],
																																																					}),
																																																				],
																																																			}),
																																																		],
																																																	}),
																																																],
																																															}),
																																														}),
																																														LitMatcher({
																																															pos: {line: 298,
																																																col: 63,
																																																offset: 7661},
																																															val: "'",
																																															ignoreCase: false,
																																															want: "\"'\"",
																																														}),
																																													],
																																												}),
																																												SeqExpr({
																																													pos: {line: 295,
																																														col: 29,
																																														offset: 7475},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 295,
																																																col: 29,
																																																offset: 7475},
																																															val: "`",
																																															ignoreCase: false,
																																															want: "\"`\"",
																																														}),
																																														ZeroOrMoreExpr({
																																															pos: {line: 295,
																																																col: 33,
																																																offset: 7479},
																																															expr: CharClassMatcher({
																																																pos: {line: 295,
																																																	col: 33,
																																																	offset: 7479},
																																																val: "[^`]",
																																																chars: ['`'.charCodeAt(0),],
																																																ranges: [],
																																																ignoreCase: false,
																																																inverted: true,
																																															}),
																																														}),
																																														LitMatcher({
																																															pos: {line: 295,
																																																col: 39,
																																																offset: 7485},
																																															val: "`",
																																															ignoreCase: false,
																																															want: "\"`\"",
																																														}),
																																													],
																																												}),
																																											],
																																										}),
																																									}),
																																								],
																																							}),
																																						}),
																																					}),
																																				],
																																			}),
																																		}),
																																	}),
																																}),
																																LitMatcher({
																																	pos: {line: 283, col: 67,
																																		offset: 7075},
																																	val: ")",
																																	ignoreCase: false,
																																	want: "\")\"",
																																}),
																															],
																														}),
																													}),
																												],
																											}),
																										}),
																										ZeroOrMoreExpr({
																											pos: {line: 334, col: 20, offset: 8737},
																											expr: CharClassMatcher({
																												pos: {line: 334, col: 20, offset: 8737},
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
																							ActionExpr({
																								pos: {line: 240, col: 18, offset: 5708},
																								run: _calloninput232,
																								expr: SeqExpr({
																									pos: {line: 240, col: 18, offset: 5708},
																									exprs: [
																										LitMatcher({
																											pos: {line: 240, col: 18, offset: 5708},
																											val: "@{",
																											ignoreCase: false,
																											want: "\"@{\"",
																										}),
																										LabeledExpr({
																											pos: {line: 240, col: 23, offset: 5713},
																											label: "code",
																											expr: ActionExpr({
																												pos: {line: 280, col: 24, offset: 6808},
																												run: _calloninput236,
																												expr: ZeroOrMoreExpr({
																													pos: {line: 280, col: 26, offset: 6810},
																													expr: SeqExpr({
																														pos: {line: 280, col: 28, offset: 6812},
																														exprs: [
																															NotExpr({
																																pos: {line: 280, col: 28,
																																	offset: 6812},
																																expr: LitMatcher({
																																	pos: {line: 280, col: 29,
																																		offset: 6813},
																																	val: "}!",
																																	ignoreCase: false,
																																	want: "\"}!\"",
																																}),
																															}),
																															AnyMatcher({
																																line: 280,
																																col: 34,
																																offset: 6818,
																															}),
																														],
																													}),
																												}),
																											}),
																										}),
																										LitMatcher({
																											pos: {line: 240, col: 48, offset: 5738},
																											val: "}!",
																											ignoreCase: false,
																											want: "\"}!\"",
																										}),
																										ZeroOrMoreExpr({
																											pos: {line: 336, col: 11, offset: 8761},
																											expr: CharClassMatcher({
																												pos: {line: 336, col: 11, offset: 8761},
																												val: "[ \\t]",
																												chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
																												ranges: [],
																												ignoreCase: false,
																												inverted: false,
																											}),
																										}),
																										CharClassMatcher({
																											pos: {line: 338, col: 7, offset: 8777},
																											val: "[\\r\\n]",
																											chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																											ranges: [],
																											ignoreCase: false,
																											inverted: false,
																										}),
																									],
																								}),
																							}),
																							ActionExpr({
																								pos: {line: 257, col: 18, offset: 6206},
																								run: _calloninput246,
																								expr: LabeledExpr({
																									pos: {line: 257, col: 18, offset: 6206},
																									label: "text",
																									expr: ActionExpr({
																										pos: {line: 256, col: 22, offset: 6125},
																										run: _calloninput248,
																										expr: OneOrMoreExpr({
																											pos: {line: 256, col: 22, offset: 6125},
																											expr: SeqExpr({
																												pos: {line: 256, col: 24, offset: 6127},
																												exprs: [
																													NotExpr({
																														pos: {line: 256, col: 24, offset: 6127},
																														expr: CharClassMatcher({
																															pos: {line: 256, col: 25,
																																offset: 6128},
																															val: "[:@]",
																															chars: [':'.charCodeAt(0), '@'.charCodeAt(0),],
																															ranges: [],
																															ignoreCase: false,
																															inverted: false,
																														}),
																													}),
																													ZeroOrMoreExpr({
																														pos: {line: 256, col: 30, offset: 6133},
																														expr: CharClassMatcher({
																															pos: {line: 256, col: 30,
																																offset: 6133},
																															val: "[^\\r\\n]",
																															chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																															ranges: [],
																															ignoreCase: false,
																															inverted: true,
																														}),
																													}),
																													CharClassMatcher({
																														pos: {line: 338, col: 7, offset: 8777},
																														val: "[\\r\\n]",
																														chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																														ranges: [],
																														ignoreCase: false,
																														inverted: false,
																													}),
																												],
																											}),
																										}),
																									}),
																								}),
																							}),
																						],
																					}),
																				}),
																			}),
																			ZeroOrMoreExpr({
																				pos: {line: 334, col: 20, offset: 8737},
																				expr: CharClassMatcher({
																					pos: {line: 334, col: 20, offset: 8737},
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
															}),
														],
													}),
												}),
												ActionExpr({
													pos: {line: 186, col: 14, offset: 4208},
													run: _calloninput258,
													expr: SeqExpr({
														pos: {line: 186, col: 14, offset: 4208},
														exprs: [
															LitMatcher({
																pos: {line: 186, col: 14, offset: 4208},
																val: ":",
																ignoreCase: false,
																want: "\":\"",
															}),
															LabeledExpr({
																pos: {line: 186, col: 18, offset: 4212},
																label: "name",
																expr: ZeroOrOneExpr({
																	pos: {line: 186, col: 23, offset: 4217},
																	expr: ActionExpr({
																		pos: {line: 324, col: 15, offset: 8415},
																		run: _calloninput263,
																		expr: SeqExpr({
																			pos: {line: 324, col: 15, offset: 8415},
																			exprs: [
																				CharClassMatcher({
																					pos: {line: 329, col: 13, offset: 8521},
																					val: "[_\\pL\\pOther_ID_Start]",
																					chars: ['_'.charCodeAt(0),],
																					ranges: [],
																					classes: [Unicode.L, Unicode.Other_ID_Start,],
																					ignoreCase: false,
																					inverted: false,
																				}),
																				ZeroOrMoreExpr({
																					pos: {line: 324, col: 24, offset: 8424},
																					expr: CharClassMatcher({
																						pos: {line: 332, col: 16, offset: 8638},
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
																pos: {line: 336, col: 11, offset: 8761},
																expr: CharClassMatcher({
																	pos: {line: 336, col: 11, offset: 8761},
																	val: "[ \\t]",
																	chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
																	ranges: [],
																	ignoreCase: false,
																	inverted: false,
																}),
															}),
															CharClassMatcher({
																pos: {line: 338, col: 7, offset: 8777},
																val: "[\\r\\n]",
																chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																ranges: [],
																ignoreCase: false,
																inverted: false,
															}),
															LabeledExpr({
																pos: {line: 186, col: 45, offset: 4239},
																label: "lines",
																expr: ActionExpr({
																	pos: {line: 215, col: 14, offset: 5003},
																	run: _calloninput272,
																	expr: SeqExpr({
																		pos: {line: 215, col: 14, offset: 5003},
																		exprs: [
																			LabeledExpr({
																				pos: {line: 215, col: 14, offset: 5003},
																				label: "lines",
																				expr: ZeroOrMoreExpr({
																					pos: {line: 215, col: 20, offset: 5009},
																					expr: ChoiceExpr({
																						pos: {line: 217, col: 13, offset: 5069},
																						alternatives: [
																							ActionExpr({
																								pos: {line: 219, col: 24, offset: 5163},
																								run: _calloninput277,
																								expr: SeqExpr({
																									pos: {line: 219, col: 24, offset: 5163},
																									exprs: [
																										LitMatcher({
																											pos: {line: 219, col: 24, offset: 5163},
																											val: "@#",
																											ignoreCase: false,
																											want: "\"@#\"",
																										}),
																										OneOrMoreExpr({
																											pos: {line: 219, col: 32, offset: 5171},
																											expr: SeqExpr({
																												pos: {line: 219, col: 33, offset: 5172},
																												exprs: [
																													NotExpr({
																														pos: {line: 219, col: 33, offset: 5172},
																														expr: CharClassMatcher({
																															pos: {line: 338, col: 7,
																																offset: 8777},
																															val: "[\\r\\n]",
																															chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																															ranges: [],
																															ignoreCase: false,
																															inverted: false,
																														}),
																													}),
																													AnyMatcher({
																														line: 219,
																														col: 37,
																														offset: 5176,
																													}),
																												],
																											}),
																										}),
																										CharClassMatcher({
																											pos: {line: 338, col: 7, offset: 8777},
																											val: "[\\r\\n]",
																											chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																											ranges: [],
																											ignoreCase: false,
																											inverted: false,
																										}),
																										ZeroOrMoreExpr({
																											pos: {line: 334, col: 20, offset: 8737},
																											expr: CharClassMatcher({
																												pos: {line: 334, col: 20, offset: 8737},
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
																							ActionExpr({
																								pos: {line: 221, col: 18, offset: 5236},
																								run: _calloninput288,
																								expr: SeqExpr({
																									pos: {line: 221, col: 18, offset: 5236},
																									exprs: [
																										LitMatcher({
																											pos: {line: 221, col: 18, offset: 5236},
																											val: "@",
																											ignoreCase: false,
																											want: "\"@\"",
																										}),
																										LabeledExpr({
																											pos: {line: 221, col: 22, offset: 5240},
																											label: "name",
																											expr: ActionExpr({
																												pos: {line: 324, col: 15, offset: 8415},
																												run: _calloninput292,
																												expr: SeqExpr({
																													pos: {line: 324, col: 15, offset: 8415},
																													exprs: [
																														CharClassMatcher({
																															pos: {line: 329, col: 13,
																																offset: 8521},
																															val: "[_\\pL\\pOther_ID_Start]",
																															chars: ['_'.charCodeAt(0),],
																															ranges: [],
																															classes: [Unicode.L, Unicode.Other_ID_Start,],
																															ignoreCase: false,
																															inverted: false,
																														}),
																														ZeroOrMoreExpr({
																															pos: {line: 324, col: 24,
																																offset: 8424},
																															expr: CharClassMatcher({
																																pos: {line: 332, col: 16,
																																	offset: 8638},
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
																										LabeledExpr({
																											pos: {line: 221, col: 38, offset: 5256},
																											label: "params",
																											expr: ChoiceExpr({
																												pos: {line: 282, col: 15, offset: 6890},
																												alternatives: [
																													ActionExpr({
																														pos: {line: 282, col: 15, offset: 6890},
																														run: _calloninput299,
																														expr: SeqExpr({
																															pos: {line: 282, col: 15,
																																offset: 6890},
																															exprs: [
																																LitMatcher({
																																	pos: {line: 282, col: 15,
																																		offset: 6890},
																																	val: "(",
																																	ignoreCase: false,
																																	want: "\"(\"",
																																}),
																																ZeroOrMoreExpr({
																																	pos: {line: 334, col: 20,
																																		offset: 8737},
																																	expr: CharClassMatcher({
																																		pos: {line: 334,
																																			col: 20,
																																			offset: 8737},
																																		val: "[ \\n\\t\\r]",
																																		chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
																																		ranges: [],
																																		ignoreCase: false,
																																		inverted: false,
																																	}),
																																}),
																																LitMatcher({
																																	pos: {line: 282, col: 22,
																																		offset: 6897},
																																	val: ")",
																																	ignoreCase: false,
																																	want: "\")\"",
																																}),
																															],
																														}),
																													}),
																													ActionExpr({
																														pos: {line: 283, col: 15, offset: 7023},
																														run: _calloninput305,
																														expr: SeqExpr({
																															pos: {line: 283, col: 15,
																																offset: 7023},
																															exprs: [
																																LitMatcher({
																																	pos: {line: 283, col: 15,
																																		offset: 7023},
																																	val: "(",
																																	ignoreCase: false,
																																	want: "\"(\"",
																																}),
																																ZeroOrMoreExpr({
																																	pos: {line: 334, col: 20,
																																		offset: 8737},
																																	expr: CharClassMatcher({
																																		pos: {line: 334,
																																			col: 20,
																																			offset: 8737},
																																		val: "[ \\n\\t\\r]",
																																		chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
																																		ranges: [],
																																		ignoreCase: false,
																																		inverted: false,
																																	}),
																																}),
																																LabeledExpr({
																																	pos: {line: 283, col: 22,
																																		offset: 7030},
																																	label: "first",
																																	expr: ActionExpr({
																																		pos: {line: 288,
																																			col: 13,
																																			offset: 7288},
																																		run: _calloninput311,
																																		expr: ChoiceExpr({
																																			pos: {line: 290,
																																				col: 14,
																																				offset: 7354},
																																			alternatives: [
																																				ActionExpr({
																																					pos: {line: 324,
																																						col: 15,
																																						offset: 8415},
																																					run: _calloninput313,
																																					expr: SeqExpr({
																																						pos: {line: 324,
																																							col: 15,
																																							offset: 8415},
																																						exprs: [
																																							CharClassMatcher({
																																								pos: {line: 329,
																																									col: 13,
																																									offset: 8521},
																																								val: "[_\\pL\\pOther_ID_Start]",
																																								chars: ['_'.charCodeAt(0),],
																																								ranges: [],
																																								classes: [Unicode.L, Unicode.Other_ID_Start,],
																																								ignoreCase: false,
																																								inverted: false,
																																							}),
																																							ZeroOrMoreExpr({
																																								pos: {line: 324,
																																									col: 24,
																																									offset: 8424},
																																								expr: CharClassMatcher({
																																									pos: {line: 332,
																																										col: 16,
																																										offset: 8638},
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
																																				ActionExpr({
																																					pos: {line: 316,
																																						col: 12,
																																						offset: 8242},
																																					run: _calloninput318,
																																					expr: SeqExpr({
																																						pos: {line: 316,
																																							col: 12,
																																							offset: 8242},
																																						exprs: [
																																							ZeroOrOneExpr({
																																								pos: {line: 316,
																																									col: 12,
																																									offset: 8242},
																																								expr: LitMatcher({
																																									pos: {line: 316,
																																										col: 12,
																																										offset: 8242},
																																									val: "-",
																																									ignoreCase: false,
																																									want: "\"-\"",
																																								}),
																																							}),
																																							OneOrMoreExpr({
																																								pos: {line: 316,
																																									col: 17,
																																									offset: 8247},
																																								expr: CharClassMatcher({
																																									pos: {line: 316,
																																										col: 17,
																																										offset: 8247},
																																									val: "[0-9]",
																																									chars: [],
																																									ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																									ignoreCase: false,
																																									inverted: false,
																																								}),
																																							}),
																																						],
																																					}),
																																				}),
																																				SeqExpr({
																																					pos: {line: 292,
																																						col: 14,
																																						offset: 7401},
																																					exprs: [
																																						ZeroOrMoreExpr({
																																							pos: {line: 292,
																																								col: 14,
																																								offset: 7401},
																																							expr: CharClassMatcher({
																																								pos: {line: 292,
																																									col: 14,
																																									offset: 7401},
																																								val: "[0-9]",
																																								chars: [],
																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																								ignoreCase: false,
																																								inverted: false,
																																							}),
																																						}),
																																						LitMatcher({
																																							pos: {line: 292,
																																								col: 21,
																																								offset: 7408},
																																							val: ".",
																																							ignoreCase: false,
																																							want: "\".\"",
																																						}),
																																						OneOrMoreExpr({
																																							pos: {line: 292,
																																								col: 25,
																																								offset: 7412},
																																							expr: CharClassMatcher({
																																								pos: {line: 292,
																																									col: 25,
																																									offset: 7412},
																																								val: "[0-9]",
																																								chars: [],
																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																								ignoreCase: false,
																																								inverted: false,
																																							}),
																																						}),
																																					],
																																				}),
																																				ActionExpr({
																																					pos: {line: 295,
																																						col: 15,
																																						offset: 7461},
																																					run: _calloninput330,
																																					expr: ChoiceExpr({
																																						pos: {line: 295,
																																							col: 16,
																																							offset: 7462},
																																						alternatives: [
																																							SeqExpr({
																																								pos: {line: 297,
																																									col: 14,
																																									offset: 7548},
																																								exprs: [
																																									LitMatcher({
																																										pos: {line: 297,
																																											col: 14,
																																											offset: 7548},
																																										val: "\"",
																																										ignoreCase: false,
																																										want: "\"\\\"\"",
																																									}),
																																									ZeroOrMoreExpr({
																																										pos: {line: 297,
																																											col: 18,
																																											offset: 7552},
																																										expr: ChoiceExpr({
																																											pos: {line: 297,
																																												col: 20,
																																												offset: 7554},
																																											alternatives: [
																																												SeqExpr({
																																													pos: {line: 297,
																																														col: 20,
																																														offset: 7554},
																																													exprs: [
																																														NotExpr({
																																															pos: {line: 297,
																																																col: 20,
																																																offset: 7554},
																																															expr: CharClassMatcher({
																																																pos: {line: 308,
																																																	col: 15,
																																																	offset: 7988},
																																																val: "[\"\\\\\\x00-\\x1f]",
																																																chars: ['"'.charCodeAt(0), '\\'.charCodeAt(0),],
																																																ranges: ['\x00'.charCodeAt(0), '\x1f'.charCodeAt(0),],
																																																ignoreCase: false,
																																																inverted: false,
																																															}),
																																														}),
																																														AnyMatcher({
																																															line: 297,
																																															col: 33,
																																															offset: 7567,
																																														}),
																																													],
																																												}),
																																												SeqExpr({
																																													pos: {line: 297,
																																														col: 37,
																																														offset: 7571},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 297,
																																																col: 37,
																																																offset: 7571},
																																															val: "\\",
																																															ignoreCase: false,
																																															want: "\"\\\\\"",
																																														}),
																																														ChoiceExpr({
																																															pos: {line: 309,
																																																col: 18,
																																																offset: 8023},
																																															alternatives: [
																																																CharClassMatcher({
																																																	pos: {line: 310,
																																																		col: 20,
																																																		offset: 8078},
																																																	val: "[\"\\\\/bfnrt]",
																																																	chars: [
																																																		'"'.charCodeAt(0),
																																																		'\\'.charCodeAt(0),
																																																		'/'.charCodeAt(0),
																																																		'b'.charCodeAt(0),
																																																		'f'.charCodeAt(0),
																																																		'n'.charCodeAt(0),
																																																		'r'.charCodeAt(0),
																																																		't'.charCodeAt(0),
																																																	],
																																																	ranges: [],
																																																	ignoreCase: false,
																																																	inverted: false,
																																																}),
																																																SeqExpr({
																																																	pos: {line: 311,
																																																		col: 17,
																																																		offset: 8109},
																																																	exprs: [
																																																		LitMatcher({
																																																			pos: {line: 311,
																																																				col: 17,
																																																				offset: 8109},
																																																			val: "u",
																																																			ignoreCase: false,
																																																			want: "\"u\"",
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																	],
																																																}),
																																															],
																																														}),
																																													],
																																												}),
																																											],
																																										}),
																																									}),
																																									LitMatcher({
																																										pos: {line: 297,
																																											col: 60,
																																											offset: 7594},
																																										val: "\"",
																																										ignoreCase: false,
																																										want: "\"\\\"\"",
																																									}),
																																								],
																																							}),
																																							SeqExpr({
																																								pos: {line: 298,
																																									col: 14,
																																									offset: 7612},
																																								exprs: [
																																									LitMatcher({
																																										pos: {line: 298,
																																											col: 14,
																																											offset: 7612},
																																										val: "'",
																																										ignoreCase: false,
																																										want: "\"'\"",
																																									}),
																																									ZeroOrMoreExpr({
																																										pos: {line: 298,
																																											col: 19,
																																											offset: 7617},
																																										expr: ChoiceExpr({
																																											pos: {line: 298,
																																												col: 21,
																																												offset: 7619},
																																											alternatives: [
																																												SeqExpr({
																																													pos: {line: 298,
																																														col: 21,
																																														offset: 7619},
																																													exprs: [
																																														NotExpr({
																																															pos: {line: 298,
																																																col: 21,
																																																offset: 7619},
																																															expr: CharClassMatcher({
																																																pos: {line: 300,
																																																	col: 16,
																																																	offset: 7686},
																																																val: "[\\\\\\\\x00-\\x1f]",
																																																chars: ['\''.charCodeAt(0), '\\'.charCodeAt(0),],
																																																ranges: ['\x00'.charCodeAt(0), '\x1f'.charCodeAt(0),],
																																																ignoreCase: false,
																																																inverted: false,
																																															}),
																																														}),
																																														AnyMatcher({
																																															line: 298,
																																															col: 35,
																																															offset: 7633,
																																														}),
																																													],
																																												}),
																																												SeqExpr({
																																													pos: {line: 298,
																																														col: 39,
																																														offset: 7637},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 298,
																																																col: 39,
																																																offset: 7637},
																																															val: "\\",
																																															ignoreCase: false,
																																															want: "\"\\\\\"",
																																														}),
																																														ChoiceExpr({
																																															pos: {line: 301,
																																																col: 19,
																																																offset: 7722},
																																															alternatives: [
																																																CharClassMatcher({
																																																	pos: {line: 302,
																																																		col: 21,
																																																		offset: 7779},
																																																	val: "[\\\\\\/bfnrt]",
																																																	chars: [
																																																		'\''.charCodeAt(0),
																																																		'\\'.charCodeAt(0),
																																																		'/'.charCodeAt(0),
																																																		'b'.charCodeAt(0),
																																																		'f'.charCodeAt(0),
																																																		'n'.charCodeAt(0),
																																																		'r'.charCodeAt(0),
																																																		't'.charCodeAt(0),
																																																	],
																																																	ranges: [],
																																																	ignoreCase: false,
																																																	inverted: false,
																																																}),
																																																SeqExpr({
																																																	pos: {line: 311,
																																																		col: 17,
																																																		offset: 8109},
																																																	exprs: [
																																																		LitMatcher({
																																																			pos: {line: 311,
																																																				col: 17,
																																																				offset: 8109},
																																																			val: "u",
																																																			ignoreCase: false,
																																																			want: "\"u\"",
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																		CharClassMatcher({
																																																			pos: {line: 314,
																																																				col: 12,
																																																				offset: 8218},
																																																			val: "[0-9a-f]i",
																																																			chars: [],
																																																			ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																			ignoreCase: true,
																																																			inverted: false,
																																																		}),
																																																	],
																																																}),
																																															],
																																														}),
																																													],
																																												}),
																																											],
																																										}),
																																									}),
																																									LitMatcher({
																																										pos: {line: 298,
																																											col: 63,
																																											offset: 7661},
																																										val: "'",
																																										ignoreCase: false,
																																										want: "\"'\"",
																																									}),
																																								],
																																							}),
																																							SeqExpr({
																																								pos: {line: 295,
																																									col: 29,
																																									offset: 7475},
																																								exprs: [
																																									LitMatcher({
																																										pos: {line: 295,
																																											col: 29,
																																											offset: 7475},
																																										val: "`",
																																										ignoreCase: false,
																																										want: "\"`\"",
																																									}),
																																									ZeroOrMoreExpr({
																																										pos: {line: 295,
																																											col: 33,
																																											offset: 7479},
																																										expr: CharClassMatcher({
																																											pos: {line: 295,
																																												col: 33,
																																												offset: 7479},
																																											val: "[^`]",
																																											chars: ['`'.charCodeAt(0),],
																																											ranges: [],
																																											ignoreCase: false,
																																											inverted: true,
																																										}),
																																									}),
																																									LitMatcher({
																																										pos: {line: 295,
																																											col: 39,
																																											offset: 7485},
																																										val: "`",
																																										ignoreCase: false,
																																										want: "\"`\"",
																																									}),
																																								],
																																							}),
																																						],
																																					}),
																																				}),
																																			],
																																		}),
																																	}),
																																}),
																																LabeledExpr({
																																	pos: {line: 283, col: 37,
																																		offset: 7045},
																																	label: "rest",
																																	expr: ZeroOrMoreExpr({
																																		pos: {line: 283,
																																			col: 43,
																																			offset: 7051},
																																		expr: ActionExpr({
																																			pos: {line: 285,
																																				col: 26,
																																				offset: 7159},
																																			run: _calloninput377,
																																			expr: SeqExpr({
																																				pos: {line: 285,
																																					col: 26,
																																					offset: 7159},
																																				exprs: [
																																					ZeroOrMoreExpr({
																																						pos: {line: 334,
																																							col: 20,
																																							offset: 8737},
																																						expr: CharClassMatcher({
																																							pos: {line: 334,
																																								col: 20,
																																								offset: 8737},
																																							val: "[ \\n\\t\\r]",
																																							chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
																																							ranges: [],
																																							ignoreCase: false,
																																							inverted: false,
																																						}),
																																					}),
																																					LitMatcher({
																																						pos: {line: 285,
																																							col: 29,
																																							offset: 7162},
																																						val: ",",
																																						ignoreCase: false,
																																						want: "\",\"",
																																					}),
																																					ZeroOrMoreExpr({
																																						pos: {line: 334,
																																							col: 20,
																																							offset: 8737},
																																						expr: CharClassMatcher({
																																							pos: {line: 334,
																																								col: 20,
																																								offset: 8737},
																																							val: "[ \\n\\t\\r]",
																																							chars: [' '.charCodeAt(0), '\n'.charCodeAt(0), '\t'.charCodeAt(0), '\r'.charCodeAt(0),],
																																							ranges: [],
																																							ignoreCase: false,
																																							inverted: false,
																																						}),
																																					}),
																																					LabeledExpr({
																																						pos: {line: 285,
																																							col: 36,
																																							offset: 7169},
																																						label: "e",
																																						expr: ActionExpr({
																																							pos: {line: 288,
																																								col: 13,
																																								offset: 7288},
																																							run: _calloninput385,
																																							expr: ChoiceExpr({
																																								pos: {line: 290,
																																									col: 14,
																																									offset: 7354},
																																								alternatives: [
																																									ActionExpr({
																																										pos: {line: 324,
																																											col: 15,
																																											offset: 8415},
																																										run: _calloninput387,
																																										expr: SeqExpr({
																																											pos: {line: 324,
																																												col: 15,
																																												offset: 8415},
																																											exprs: [
																																												CharClassMatcher({
																																													pos: {line: 329,
																																														col: 13,
																																														offset: 8521},
																																													val: "[_\\pL\\pOther_ID_Start]",
																																													chars: ['_'.charCodeAt(0),],
																																													ranges: [],
																																													classes: [Unicode.L, Unicode.Other_ID_Start,],
																																													ignoreCase: false,
																																													inverted: false,
																																												}),
																																												ZeroOrMoreExpr({
																																													pos: {line: 324,
																																														col: 24,
																																														offset: 8424},
																																													expr: CharClassMatcher({
																																														pos: {line: 332,
																																															col: 16,
																																															offset: 8638},
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
																																									ActionExpr({
																																										pos: {line: 316,
																																											col: 12,
																																											offset: 8242},
																																										run: _calloninput392,
																																										expr: SeqExpr({
																																											pos: {line: 316,
																																												col: 12,
																																												offset: 8242},
																																											exprs: [
																																												ZeroOrOneExpr({
																																													pos: {line: 316,
																																														col: 12,
																																														offset: 8242},
																																													expr: LitMatcher({
																																														pos: {line: 316,
																																															col: 12,
																																															offset: 8242},
																																														val: "-",
																																														ignoreCase: false,
																																														want: "\"-\"",
																																													}),
																																												}),
																																												OneOrMoreExpr({
																																													pos: {line: 316,
																																														col: 17,
																																														offset: 8247},
																																													expr: CharClassMatcher({
																																														pos: {line: 316,
																																															col: 17,
																																															offset: 8247},
																																														val: "[0-9]",
																																														chars: [],
																																														ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																														ignoreCase: false,
																																														inverted: false,
																																													}),
																																												}),
																																											],
																																										}),
																																									}),
																																									SeqExpr({
																																										pos: {line: 292,
																																											col: 14,
																																											offset: 7401},
																																										exprs: [
																																											ZeroOrMoreExpr({
																																												pos: {line: 292,
																																													col: 14,
																																													offset: 7401},
																																												expr: CharClassMatcher({
																																													pos: {line: 292,
																																														col: 14,
																																														offset: 7401},
																																													val: "[0-9]",
																																													chars: [],
																																													ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																													ignoreCase: false,
																																													inverted: false,
																																												}),
																																											}),
																																											LitMatcher({
																																												pos: {line: 292,
																																													col: 21,
																																													offset: 7408},
																																												val: ".",
																																												ignoreCase: false,
																																												want: "\".\"",
																																											}),
																																											OneOrMoreExpr({
																																												pos: {line: 292,
																																													col: 25,
																																													offset: 7412},
																																												expr: CharClassMatcher({
																																													pos: {line: 292,
																																														col: 25,
																																														offset: 7412},
																																													val: "[0-9]",
																																													chars: [],
																																													ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0),],
																																													ignoreCase: false,
																																													inverted: false,
																																												}),
																																											}),
																																										],
																																									}),
																																									ActionExpr({
																																										pos: {line: 295,
																																											col: 15,
																																											offset: 7461},
																																										run: _calloninput404,
																																										expr: ChoiceExpr({
																																											pos: {line: 295,
																																												col: 16,
																																												offset: 7462},
																																											alternatives: [
																																												SeqExpr({
																																													pos: {line: 297,
																																														col: 14,
																																														offset: 7548},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 297,
																																																col: 14,
																																																offset: 7548},
																																															val: "\"",
																																															ignoreCase: false,
																																															want: "\"\\\"\"",
																																														}),
																																														ZeroOrMoreExpr({
																																															pos: {line: 297,
																																																col: 18,
																																																offset: 7552},
																																															expr: ChoiceExpr({
																																																pos: {line: 297,
																																																	col: 20,
																																																	offset: 7554},
																																																alternatives: [
																																																	SeqExpr({
																																																		pos: {line: 297,
																																																			col: 20,
																																																			offset: 7554},
																																																		exprs: [
																																																			NotExpr({
																																																				pos: {line: 297,
																																																					col: 20,
																																																					offset: 7554},
																																																				expr: CharClassMatcher({
																																																					pos: {line: 308,
																																																						col: 15,
																																																						offset: 7988},
																																																					val: "[\"\\\\\\x00-\\x1f]",
																																																					chars: ['"'.charCodeAt(0), '\\'.charCodeAt(0),],
																																																					ranges: ['\x00'.charCodeAt(0), '\x1f'.charCodeAt(0),],
																																																					ignoreCase: false,
																																																					inverted: false,
																																																				}),
																																																			}),
																																																			AnyMatcher({
																																																				line: 297,
																																																				col: 33,
																																																				offset: 7567,
																																																			}),
																																																		],
																																																	}),
																																																	SeqExpr({
																																																		pos: {line: 297,
																																																			col: 37,
																																																			offset: 7571},
																																																		exprs: [
																																																			LitMatcher({
																																																				pos: {line: 297,
																																																					col: 37,
																																																					offset: 7571},
																																																				val: "\\",
																																																				ignoreCase: false,
																																																				want: "\"\\\\\"",
																																																			}),
																																																			ChoiceExpr({
																																																				pos: {line: 309,
																																																					col: 18,
																																																					offset: 8023},
																																																				alternatives: [
																																																					CharClassMatcher({
																																																						pos: {line: 310,
																																																							col: 20,
																																																							offset: 8078},
																																																						val: "[\"\\\\/bfnrt]",
																																																						chars: [
																																																							'"'.charCodeAt(0),
																																																							'\\'.charCodeAt(0),
																																																							'/'.charCodeAt(0),
																																																							'b'.charCodeAt(0),
																																																							'f'.charCodeAt(0),
																																																							'n'.charCodeAt(0),
																																																							'r'.charCodeAt(0),
																																																							't'.charCodeAt(0),
																																																						],
																																																						ranges: [],
																																																						ignoreCase: false,
																																																						inverted: false,
																																																					}),
																																																					SeqExpr({
																																																						pos: {line: 311,
																																																							col: 17,
																																																							offset: 8109},
																																																						exprs: [
																																																							LitMatcher({
																																																								pos: {
																																																									line: 311,
																																																									col: 17,
																																																									offset: 8109
																																																								},
																																																								val: "u",
																																																								ignoreCase: false,
																																																								want: "\"u\"",
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																						],
																																																					}),
																																																				],
																																																			}),
																																																		],
																																																	}),
																																																],
																																															}),
																																														}),
																																														LitMatcher({
																																															pos: {line: 297,
																																																col: 60,
																																																offset: 7594},
																																															val: "\"",
																																															ignoreCase: false,
																																															want: "\"\\\"\"",
																																														}),
																																													],
																																												}),
																																												SeqExpr({
																																													pos: {line: 298,
																																														col: 14,
																																														offset: 7612},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 298,
																																																col: 14,
																																																offset: 7612},
																																															val: "'",
																																															ignoreCase: false,
																																															want: "\"'\"",
																																														}),
																																														ZeroOrMoreExpr({
																																															pos: {line: 298,
																																																col: 19,
																																																offset: 7617},
																																															expr: ChoiceExpr({
																																																pos: {line: 298,
																																																	col: 21,
																																																	offset: 7619},
																																																alternatives: [
																																																	SeqExpr({
																																																		pos: {line: 298,
																																																			col: 21,
																																																			offset: 7619},
																																																		exprs: [
																																																			NotExpr({
																																																				pos: {line: 298,
																																																					col: 21,
																																																					offset: 7619},
																																																				expr: CharClassMatcher({
																																																					pos: {line: 300,
																																																						col: 16,
																																																						offset: 7686},
																																																					val: "[\\\\\\\\x00-\\x1f]",
																																																					chars: ['\''.charCodeAt(0), '\\'.charCodeAt(0),],
																																																					ranges: ['\x00'.charCodeAt(0), '\x1f'.charCodeAt(0),],
																																																					ignoreCase: false,
																																																					inverted: false,
																																																				}),
																																																			}),
																																																			AnyMatcher({
																																																				line: 298,
																																																				col: 35,
																																																				offset: 7633,
																																																			}),
																																																		],
																																																	}),
																																																	SeqExpr({
																																																		pos: {line: 298,
																																																			col: 39,
																																																			offset: 7637},
																																																		exprs: [
																																																			LitMatcher({
																																																				pos: {line: 298,
																																																					col: 39,
																																																					offset: 7637},
																																																				val: "\\",
																																																				ignoreCase: false,
																																																				want: "\"\\\\\"",
																																																			}),
																																																			ChoiceExpr({
																																																				pos: {line: 301,
																																																					col: 19,
																																																					offset: 7722},
																																																				alternatives: [
																																																					CharClassMatcher({
																																																						pos: {line: 302,
																																																							col: 21,
																																																							offset: 7779},
																																																						val: "[\\\\\\/bfnrt]",
																																																						chars: [
																																																							'\''.charCodeAt(0),
																																																							'\\'.charCodeAt(0),
																																																							'/'.charCodeAt(0),
																																																							'b'.charCodeAt(0),
																																																							'f'.charCodeAt(0),
																																																							'n'.charCodeAt(0),
																																																							'r'.charCodeAt(0),
																																																							't'.charCodeAt(0),
																																																						],
																																																						ranges: [],
																																																						ignoreCase: false,
																																																						inverted: false,
																																																					}),
																																																					SeqExpr({
																																																						pos: {line: 311,
																																																							col: 17,
																																																							offset: 8109},
																																																						exprs: [
																																																							LitMatcher({
																																																								pos: {
																																																									line: 311,
																																																									col: 17,
																																																									offset: 8109
																																																								},
																																																								val: "u",
																																																								ignoreCase: false,
																																																								want: "\"u\"",
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																							CharClassMatcher({
																																																								pos: {
																																																									line: 314,
																																																									col: 12,
																																																									offset: 8218
																																																								},
																																																								val: "[0-9a-f]i",
																																																								chars: [],
																																																								ranges: ['0'.charCodeAt(0), '9'.charCodeAt(0), 'a'.charCodeAt(0), 'f'.charCodeAt(0),],
																																																								ignoreCase: true,
																																																								inverted: false,
																																																							}),
																																																						],
																																																					}),
																																																				],
																																																			}),
																																																		],
																																																	}),
																																																],
																																															}),
																																														}),
																																														LitMatcher({
																																															pos: {line: 298,
																																																col: 63,
																																																offset: 7661},
																																															val: "'",
																																															ignoreCase: false,
																																															want: "\"'\"",
																																														}),
																																													],
																																												}),
																																												SeqExpr({
																																													pos: {line: 295,
																																														col: 29,
																																														offset: 7475},
																																													exprs: [
																																														LitMatcher({
																																															pos: {line: 295,
																																																col: 29,
																																																offset: 7475},
																																															val: "`",
																																															ignoreCase: false,
																																															want: "\"`\"",
																																														}),
																																														ZeroOrMoreExpr({
																																															pos: {line: 295,
																																																col: 33,
																																																offset: 7479},
																																															expr: CharClassMatcher({
																																																pos: {line: 295,
																																																	col: 33,
																																																	offset: 7479},
																																																val: "[^`]",
																																																chars: ['`'.charCodeAt(0),],
																																																ranges: [],
																																																ignoreCase: false,
																																																inverted: true,
																																															}),
																																														}),
																																														LitMatcher({
																																															pos: {line: 295,
																																																col: 39,
																																																offset: 7485},
																																															val: "`",
																																															ignoreCase: false,
																																															want: "\"`\"",
																																														}),
																																													],
																																												}),
																																											],
																																										}),
																																									}),
																																								],
																																							}),
																																						}),
																																					}),
																																				],
																																			}),
																																		}),
																																	}),
																																}),
																																LitMatcher({
																																	pos: {line: 283, col: 67,
																																		offset: 7075},
																																	val: ")",
																																	ignoreCase: false,
																																	want: "\")\"",
																																}),
																															],
																														}),
																													}),
																												],
																											}),
																										}),
																										ZeroOrMoreExpr({
																											pos: {line: 334, col: 20, offset: 8737},
																											expr: CharClassMatcher({
																												pos: {line: 334, col: 20, offset: 8737},
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
																							ActionExpr({
																								pos: {line: 240, col: 18, offset: 5708},
																								run: _calloninput452,
																								expr: SeqExpr({
																									pos: {line: 240, col: 18, offset: 5708},
																									exprs: [
																										LitMatcher({
																											pos: {line: 240, col: 18, offset: 5708},
																											val: "@{",
																											ignoreCase: false,
																											want: "\"@{\"",
																										}),
																										LabeledExpr({
																											pos: {line: 240, col: 23, offset: 5713},
																											label: "code",
																											expr: ActionExpr({
																												pos: {line: 280, col: 24, offset: 6808},
																												run: _calloninput456,
																												expr: ZeroOrMoreExpr({
																													pos: {line: 280, col: 26, offset: 6810},
																													expr: SeqExpr({
																														pos: {line: 280, col: 28, offset: 6812},
																														exprs: [
																															NotExpr({
																																pos: {line: 280, col: 28,
																																	offset: 6812},
																																expr: LitMatcher({
																																	pos: {line: 280, col: 29,
																																		offset: 6813},
																																	val: "}!",
																																	ignoreCase: false,
																																	want: "\"}!\"",
																																}),
																															}),
																															AnyMatcher({
																																line: 280,
																																col: 34,
																																offset: 6818,
																															}),
																														],
																													}),
																												}),
																											}),
																										}),
																										LitMatcher({
																											pos: {line: 240, col: 48, offset: 5738},
																											val: "}!",
																											ignoreCase: false,
																											want: "\"}!\"",
																										}),
																										ZeroOrMoreExpr({
																											pos: {line: 336, col: 11, offset: 8761},
																											expr: CharClassMatcher({
																												pos: {line: 336, col: 11, offset: 8761},
																												val: "[ \\t]",
																												chars: [' '.charCodeAt(0), '\t'.charCodeAt(0),],
																												ranges: [],
																												ignoreCase: false,
																												inverted: false,
																											}),
																										}),
																										CharClassMatcher({
																											pos: {line: 338, col: 7, offset: 8777},
																											val: "[\\r\\n]",
																											chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																											ranges: [],
																											ignoreCase: false,
																											inverted: false,
																										}),
																									],
																								}),
																							}),
																							ActionExpr({
																								pos: {line: 257, col: 18, offset: 6206},
																								run: _calloninput466,
																								expr: LabeledExpr({
																									pos: {line: 257, col: 18, offset: 6206},
																									label: "text",
																									expr: ActionExpr({
																										pos: {line: 256, col: 22, offset: 6125},
																										run: _calloninput468,
																										expr: OneOrMoreExpr({
																											pos: {line: 256, col: 22, offset: 6125},
																											expr: SeqExpr({
																												pos: {line: 256, col: 24, offset: 6127},
																												exprs: [
																													NotExpr({
																														pos: {line: 256, col: 24, offset: 6127},
																														expr: CharClassMatcher({
																															pos: {line: 256, col: 25,
																																offset: 6128},
																															val: "[:@]",
																															chars: [':'.charCodeAt(0), '@'.charCodeAt(0),],
																															ranges: [],
																															ignoreCase: false,
																															inverted: false,
																														}),
																													}),
																													ZeroOrMoreExpr({
																														pos: {line: 256, col: 30, offset: 6133},
																														expr: CharClassMatcher({
																															pos: {line: 256, col: 30,
																																offset: 6133},
																															val: "[^\\r\\n]",
																															chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																															ranges: [],
																															ignoreCase: false,
																															inverted: true,
																														}),
																													}),
																													CharClassMatcher({
																														pos: {line: 338, col: 7, offset: 8777},
																														val: "[\\r\\n]",
																														chars: ['\r'.charCodeAt(0), '\n'.charCodeAt(0),],
																														ranges: [],
																														ignoreCase: false,
																														inverted: false,
																													}),
																												],
																											}),
																										}),
																									}),
																								}),
																							}),
																						],
																					}),
																				}),
																			}),
																			ZeroOrMoreExpr({
																				pos: {line: 334, col: 20, offset: 8737},
																				expr: CharClassMatcher({
																					pos: {line: 334, col: 20, offset: 8737},
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
															}),
														],
													}),
												}),
											],
										}),
									}),
								}),
							}),
						}),
						NotExpr({
							pos: {line: 127, col: 21, offset: 2569},
							expr: AnyMatcher({
								line: 127,
								col: 22,
								offset: 2570,
							}),
						}),
					],
				}),
			}),
		},
	],
}

private function _oninput17(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput17(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput17(p.cur,);
}

private function _oninput30(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput30(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput30(p.cur,);
}

private function _oninput25(c:Current, cond:Any):RetValErr {
	return retWrap(cond, nil);
}

private function _calloninput25(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput25(p.cur, stack["cond"]);
}

private function _oninput42(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput42(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput42(p.cur,);
}

private function _oninput38(c:Current, name:Any):RetValErr {
	return retWrap(name, nil);
}

private function _calloninput38(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput38(p.cur, stack["name"]);
}

private function _oninput57(c:Current,):RetValErr {
	return retWrap(nil, nil);
}

private function _calloninput57(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput57(p.cur,);
}

private function _oninput72(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput72(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput72(p.cur,);
}

private function _oninput79(c:Current,):RetValErr {
	return retWrap([], nil);
}

private function _calloninput79(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput79(p.cur,);
}

private function _oninput93(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput93(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput93(p.cur,);
}

private function _oninput98(c:Current,):RetValErr {
	return retWrap(Std.parseInt(c.text), nil);
}

private function _calloninput98(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput98(p.cur,);
}

private function _oninput110(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput110(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput110(p.cur,);
}

private function _oninput91(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput91(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput91(p.cur,);
}

private function _oninput167(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput167(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput167(p.cur,);
}

private function _oninput172(c:Current,):RetValErr {
	return retWrap(Std.parseInt(c.text), nil);
}

private function _calloninput172(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput172(p.cur,);
}

private function _oninput184(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput184(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput184(p.cur,);
}

private function _oninput165(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput165(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput165(p.cur,);
}

private function _oninput157(c:Current, e:Any):RetValErr {
	return retWrap(e, nil);
}

private function _calloninput157(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput157(p.cur, stack["e"]);
}

private function _oninput85(c:Current, first, rest:Any):RetValErr {
	return retWrap(gatherParams(first, rest), nil);
}

private function _calloninput85(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput85(p.cur, stack["first"], stack["rest"]);
}

private function _oninput68(c:Current, name, params:Any):RetValErr {
	return retWrap({
		type: "",
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		name: name,
		params: params,
	}, nil);
}

private function _calloninput68(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput68(p.cur, stack["name"], stack["params"]);
}

private function _oninput236(c:Current,):RetValErr {
	return retWrap(toStrWithTrim(c.text), nil);
}

private function _calloninput236(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput236(p.cur,);
}

private function _oninput232(c:Current, code:Any):RetValErr {
	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		type: 'code',
		code: code,
	}, nil);
}

private function _calloninput232(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput232(p.cur, stack["code"]);
}

private function _oninput248(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput248(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput248(p.cur,);
}

private function _oninput246(c:Current, text:Any):RetValErr {
	if (StringTools.trim(c.text) == "") {
		return retWrap(null, null);
	}
	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		name: 'sayRaw',
		type: "",
		params: [text],
	}, nil);
}

private function _calloninput246(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput246(p.cur, stack["text"]);
}

private function _oninput52(c:Current, lines:Any):RetValErr {
	return retWrap(lines, nil);
}

private function _calloninput52(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput52(p.cur, stack["lines"]);
}

private function _oninput10(c:Current, name, cond, next, lines:Any):RetValErr {
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

private function _calloninput10(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput10(p.cur, stack["name"], stack["cond"], stack["next"], stack["lines"]);
}

private function _oninput263(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput263(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput263(p.cur,);
}

private function _oninput277(c:Current,):RetValErr {
	return retWrap(nil, nil);
}

private function _calloninput277(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput277(p.cur,);
}

private function _oninput292(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput292(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput292(p.cur,);
}

private function _oninput299(c:Current,):RetValErr {
	return retWrap([], nil);
}

private function _calloninput299(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput299(p.cur,);
}

private function _oninput313(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput313(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput313(p.cur,);
}

private function _oninput318(c:Current,):RetValErr {
	return retWrap(Std.parseInt(c.text), nil);
}

private function _calloninput318(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput318(p.cur,);
}

private function _oninput330(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput330(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput330(p.cur,);
}

private function _oninput311(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput311(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput311(p.cur,);
}

private function _oninput387(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput387(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput387(p.cur,);
}

private function _oninput392(c:Current,):RetValErr {
	return retWrap(Std.parseInt(c.text), nil);
}

private function _calloninput392(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput392(p.cur,);
}

private function _oninput404(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput404(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput404(p.cur,);
}

private function _oninput385(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput385(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput385(p.cur,);
}

private function _oninput377(c:Current, e:Any):RetValErr {
	return retWrap(e, nil);
}

private function _calloninput377(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput377(p.cur, stack["e"]);
}

private function _oninput305(c:Current, first, rest:Any):RetValErr {
	return retWrap(gatherParams(first, rest), nil);
}

private function _calloninput305(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput305(p.cur, stack["first"], stack["rest"]);
}

private function _oninput288(c:Current, name, params:Any):RetValErr {
	return retWrap({
		type: "",
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		name: name,
		params: params,
	}, nil);
}

private function _calloninput288(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput288(p.cur, stack["name"], stack["params"]);
}

private function _oninput456(c:Current,):RetValErr {
	return retWrap(toStrWithTrim(c.text), nil);
}

private function _calloninput456(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput456(p.cur,);
}

private function _oninput452(c:Current, code:Any):RetValErr {
	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		type: 'code',
		code: code,
	}, nil);
}

private function _calloninput452(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput452(p.cur, stack["code"]);
}

private function _oninput468(c:Current,):RetValErr {
	return retWrap(toStr(c.text), nil);
}

private function _calloninput468(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput468(p.cur,);
}

private function _oninput466(c:Current, text:Any):RetValErr {
	if (StringTools.trim(c.text) == "") {
		return retWrap(null, null);
	}
	return retWrap({
		pos: [c.pos.line, c.pos.col, c.pos.offset],
		name: 'sayRaw',
		type: "",
		params: [text],
	}, nil);
}

private function _calloninput466(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput466(p.cur, stack["text"]);
}

private function _oninput272(c:Current, lines:Any):RetValErr {
	return retWrap(lines, nil);
}

private function _calloninput272(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput272(p.cur, stack["lines"]);
}

private function _oninput258(c:Current, name, lines:Any):RetValErr {
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

private function _calloninput258(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput258(p.cur, stack["name"], stack["lines"]);
}

private function _oninput6(c:Current, nodes:Any):RetValErr {
	return retWrap(new Types.Story(nodes), nil);
}

private function _calloninput6(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput6(p.cur, stack["nodes"]);
}

private function _oninput1(c:Current, x:Any):RetValErr {
	return retWrap(x, nil);
}

private function _calloninput1(p:Parser):RetValErr {
	var stack = p.vstack.first();
	var _ = stack;
	return _oninput1(p.cur, stack["x"]);
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
