## Remove mutation syntax only after all C alias and inout writebacks have
## been lowered. Generated local names are unique within each function.
## This pass never moves evaluation, and never substitutes mutable aliases.
CleanLocals :: [].{
	lines : List(Str) -> List(Str)
	lines = |input| clean(input)

	with_names : List(Str), List(Str) -> List(Str)
	with_names = |input, reserved| clean_reserved(input, reserved)
}

clean : List(Str) -> List(Str)
clean = |input| clean_reserved(input, [])

clean_reserved : List(Str), List(Str) -> List(Str)
clean_reserved = |input, reserved| {
	var $lines = input
	for line in input {
		text = line.trim()
		if text.starts_with("var $") {
			match text.drop_prefix("var ").split_first(" = ") {
				Ok({ before: name, after: rhs }) => {
					written = input.any(|l| l.trim().starts_with("${name} = "))
					if !written {
						# Only parameters are alias-elided: unlike another local,
						# they cannot change after this snapshot was taken.
						is_param = rhs.ends_with("_arg") and rhs.to_utf8().all(|c| name_char(c)) and !rhs.starts_with("$")
						used = $lines.any(|l| !l.trim().starts_with("var ${name} = ") and replace_token(l, name, "") != l)
						var $replacement = if is_param rhs else if used name.drop_prefix("$") else "_"
						if !is_param and used {
							# `$x` and `x` are different Roc bindings. In
							# particular a C local can be named like an
							# existing generated function parameter.
							text_now = Str.join_with($lines, "\n")
							while reserved.contains($replacement) or replace_token(text_now, $replacement, "") != text_now {
								$replacement = "${$replacement}_local"
							}
						}
						replacement = $replacement
						$lines = $lines.map(|l|
							if l.trim().starts_with("var ${name} = ") {
								if is_param "" else replace_token(l.replace_first("var ", ""), name, replacement)
							} else {
								replace_token(l, name, replacement)
							})
					}
				}
				Err(_) => {}
			}
		}
	}
	$lines.keep_if(|l| !l.is_empty())
}

## String contents are literal except for `${...}` expressions. Track nested
## strings and braces so generated error-message interpolation is rewritten
## without touching SQL text or escaped interpolation.
replace_token : Str, Str, Str -> Str
replace_token = |text, from, to| {
	bytes = text.to_utf8()
	var $out = []
	var $i = 0.U64
	var $contexts = [Code(0.U64)]
	while $i < bytes.len() {
		c = bytes.get($i) ?? 0
		context = $contexts.last() ?? Code(0)
		if context == Quoted {
			$out = $out.append(c)
			$i = $i + 1
			if c == '\\' and $i < bytes.len() {
				$out = $out.append(bytes.get($i) ?? 0)
				$i = $i + 1
			} else if c == '"' {
				$contexts = $contexts.drop_last(1)
			} else if c == '$' and bytes.get($i) == Ok('{') {
				$out = $out.append('{')
				$i = $i + 1
				$contexts = $contexts.append(Code(1))
			}
		} else if c == '"' {
			$contexts = $contexts.append(Quoted)
			$out = $out.append(c)
			$i = $i + 1
		} else if name_char(c) {
			start = $i
			while $i < bytes.len() and name_char(bytes.get($i) ?? 0) {
				$i = $i + 1
			}
			token = Str.from_utf8_lossy(bytes.drop_first(start).take_first($i - start))
			$out = $out.concat((if token == from to else token).to_utf8())
		} else {
			$out = $out.append(c)
			$i = $i + 1
			match context {
				Code(depth) if depth > 0 => {
					if c == '{' {
						$contexts = $contexts.drop_last(1).append(Code(depth + 1))
					} else if c == '}' {
						$contexts = $contexts.drop_last(1)
						if depth > 1 { $contexts = $contexts.append(Code(depth - 1)) }
					}
				}
				_ => {}
			}
		}
	}
	Str.from_utf8_lossy($out)
}

name_char : U8 -> Bool
name_char = |c| (c >= 'a' and c <= 'z') or (c >= 'A' and c <= 'Z') or (c >= '0' and c <= '9') or c == '_' or c == '$'

expect clean(["var $x = 1", "use($x)"]) == ["x = 1", "use(x)"]
expect clean(["var $x = x_arg", "use($x)"]) == ["use(x_arg)"]
expect clean(["var $x = 1", "if yes {", "\t$x = 2", "}", "use($x)"]) == ["var $x = 1", "if yes {", "\t$x = 2", "}", "use($x)"]
expect clean(["var $x = 1", "while yes {", "\t$x = written.a0", "}"]) == ["var $x = 1", "while yes {", "\t$x = written.a0", "}"]
expect clean(["var $x = $y", "$y = 2", "use($x)"]) == ["x = $y", "$y = 2", "use(x)"]
expect clean(["var $x = 1", "var $y = $x", "use($y)"]) == ["x = 1", "y = x", "use(y)"]
expect clean(["var $x_arg = 1", "use(x_arg, $x_arg)"]) == ["x_arg_local = 1", "use(x_arg, x_arg_local)"]
expect clean(["var $x = effect()"]) == ["_ = effect()"]
expect clean_reserved(["var $_x_arg = 1", "use($_x_arg)"], ["_x_arg"]) == ["_x_arg_local = 1", "use(_x_arg_local)"]
expect replace_token("use($x, $xx, \"literal $x \\\" $x\")", "$x", "x") == "use(x, $xx, \"literal $x \\\" $x\")"
expect replace_token("\"value \${show($x)} literal $x\"", "$x", "x") == "\"value \${show(x)} literal $x\""
expect replace_token("\"value \${show({ x: $x, text: \"$x\" })}\"", "$x", "x") == "\"value \${show({ x: x, text: \"$x\" })}\""
expect replace_token("\"escaped \\\${$x}\"", "$x", "x") == "\"escaped \\\${$x}\""
expect clean(["var $x = x_arg", "say(\"value \${show($x)}\")"]) == ["say(\"value \${show(x_arg)}\")"]
