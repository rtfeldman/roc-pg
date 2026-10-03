"""Generate a Node-like nominal with K record-payload tags and M functions that
construct/update it, in one of several source styles:
  updates   : var + 4 sequential same-variant record updates (Actions style)
  single    : one constructor with all fields set (proposed generator output)
  immutable : like `updates` but with fresh immutable bindings instead of var
  zero      : M functions that only construct Node.Null (zero-arg tag)
Usage: gen_nominal.py K M STYLE OUTDIR"""
import sys,os
K=int(sys.argv[1]); M=int(sys.argv[2]); style=sys.argv[3]; out=sys.argv[4]
os.makedirs(out,exist_ok=True)
node=["Node := [","        Null,","        NodeList(List(Node)),"]
for i in range(K): node.append(f"        T{i}(Node.R{i}),")
node.append("].{")
node.append("        Text : Try(Str, [Null])")
node.append("        null : Node")
node.append("        null = Node.Null")
for i in range(K):
    node.append(f"        R{i} : {{ a : I64, b : Node.Text, c : List(Node), d : Node, e : Bool, f : I64, g : Node.Text, h : List(Node) }}")
    node.append(f"        r{i}_default : Node.R{i}")
    node.append(f"        r{i}_default = {{ a: 0.I64, b: Err(Null), c: [], d: Node.Null, e: Bool.False, f: 0.I64, g: Err(Null), h: [] }}")
    node.append(f"        r{i}_of : Node -> Node.R{i}")
    node.append(f"        r{i}_of = |n| match n {{ T{i}(r) => r, _ => crash \"expected T{i}\" }}")
node.append("}")
open(f"{out}/Node.roc","w").write("\n".join(node)+"\n")
acts=["import Node","","Acts :: [].{","        first : I64, I64, List(Node) -> Node","        first = |a, f, c| make_0(a, f, c)","}",""]
for j in range(M):
    t=j%K
    acts.append(f"make_{j} : I64, I64, List(Node) -> Node")
    if style=="updates":
        acts.append(f"make_{j} = |a_arg, f_arg, c_arg| {{")
        acts.append(f"        var $n = Node.T{t}(Node.r{t}_default)")
        acts.append(f"        $n = Node.T{t}({{ ..Node.r{t}_of($n), a: a_arg }})")
        acts.append(f"        $n = Node.T{t}({{ ..Node.r{t}_of($n), f: f_arg }})")
        acts.append(f"        $n = Node.T{t}({{ ..Node.r{t}_of($n), c: c_arg }})")
        acts.append(f"        $n = Node.T{t}({{ ..Node.r{t}_of($n), e: Bool.True }})")
        acts.append("        $n")
        acts.append("}")
    elif style=="immutable":
        acts.append(f"make_{j} = |a_arg, f_arg, c_arg| {{")
        acts.append(f"        n0 = Node.T{t}(Node.r{t}_default)")
        acts.append(f"        n1 = Node.T{t}({{ ..Node.r{t}_of(n0), a: a_arg }})")
        acts.append(f"        n2 = Node.T{t}({{ ..Node.r{t}_of(n1), f: f_arg }})")
        acts.append(f"        n3 = Node.T{t}({{ ..Node.r{t}_of(n2), c: c_arg }})")
        acts.append(f"        n4 = Node.T{t}({{ ..Node.r{t}_of(n3), e: Bool.True }})")
        acts.append("        n4")
        acts.append("}")
    elif style=="single":
        acts.append(f"make_{j} = |a_arg, f_arg, c_arg|")
        acts.append(f"        Node.T{t}({{ ..Node.r{t}_default, a: a_arg, f: f_arg, c: c_arg, e: Bool.True }})")
    elif style=="zero":
        acts.append(f"make_{j} = |_a_arg, _f_arg, _c_arg| Node.Null")
    elif style=="zeroconst":
        acts.append(f"make_{j} = |_a_arg, _f_arg, _c_arg| Node.null")
    acts.append("")
open(f"{out}/Acts.roc","w").write("\n".join(acts)+"\n")
open(f"{out}/main.roc","w").write("package [Node, Acts] {}\n")
