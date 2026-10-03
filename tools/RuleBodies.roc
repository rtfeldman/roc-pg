## Intern already-lowered, typed grammar action templates. Source rule
## labels stay at the dispatch sites; literal arguments are supplied by the
## translator, never inferred by rewriting generated Roc text.
import Translate

RuleBodies :: [].{
	State : { seen : Dict(Str, U64), code : List(Str), dispatch : List(Str) }

	empty : {} -> RuleBodies.State
	empty = |_| { seen: Dict.empty(), code: [], dispatch: [] }

	add : RuleBodies.State, U64, Str, Translate.ActionTemplate -> RuleBodies.State
	add = |state, rule, rule_text, template| {
		# Parameter names and their count are part of the template. All extra
		# parameters are I64; other C literal representations are never slots.
		key = "${Str.join_with(template.params, ",")}\n${template.body}"
		first = state.seen.get(key)
		owner = first ?? rule
		name = "rule_${owner.to_str()}"
		args = ["ctx", "v", "l", "loc"].concat(template.args)
		dispatch = state.dispatch.append("\t\t\t# ${rule_text}").append("\t\t\t${rule.to_str()} => ${name}(${Str.join_with(args, ", ")})")
		match first {
			Ok(_) => { ..state, dispatch }
			Err(_) => {
				types = ["Rt.Ctx", "List(Rt.Value)", "List(I64)", "I64"].concat(template.args.map(|_| "I64"))
				code = "## ${rule_text}\n${name} : ${Str.join_with(types, ", ")} -> Try(Rt.Value, Scan.Problem)\n${name} = |${Str.join_with(template.params, ", ")}| ${template.body}"
				{ seen: state.seen.insert(key, rule), code: state.code.append(code), dispatch }
			}
		}
	}
}

expect {
	template = { params: ["_ctx", "_v", "_l", "_loc", "literal_0"], body: "{\n\tOk(Rt.of_int(literal_0))\n}", args: ["1"], problems: [] }
	one = RuleBodies.add(RuleBodies.empty({}), 5, "first: TOKEN1", template)
	two = RuleBodies.add(one, 6, "second: TOKEN2", { ..template, args: ["2"] })
	two.code.len() == 1 and two.dispatch.last() == Ok("\t\t\t6 => rule_5(ctx, v, l, loc, 2)")
}

expect {
	template = { params: ["_ctx", "_v", "_l", "_loc"], body: "{\n\tOk(Rt.of_int(42))\n}", args: [], problems: [] }
	one = RuleBodies.add(RuleBodies.empty({}), 5, "first", template)
	two = RuleBodies.add(one, 6, "second", template)
	two.code.len() == 1 and two.dispatch.last() == Ok("\t\t\t6 => rule_5(ctx, v, l, loc)")
}

expect {
	template = { params: ["_ctx", "_v", "_l", "_loc"], body: "{\n\tOk(Rt.of_text(Ok(\"number 1\")))\n}", args: [], problems: [] }
	one = RuleBodies.add(RuleBodies.empty({}), 5, "first", template)
	two = RuleBodies.add(one, 6, "second", { ..template, body: "{\n\tOk(Rt.of_text(Ok(\"number 2\")))\n}" })
	two.code.len() == 2
}
