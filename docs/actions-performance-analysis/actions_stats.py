"""Static statistics over package/Actions.roc for the cost model:
constructor expressions per category, duplicate rule bodies modulo literals,
and an estimate of the construction count after a 'build the record, wrap
once' generator transform."""
import re,collections,sys
src=open(sys.argv[1] if len(sys.argv)>1 else 'package/Actions.roc').read()
# split into top-level functions: "name = |...| {" ... "\n}" or single-line
fn_re=re.compile(r'^([a-z_][a-z0-9_]*) = (.*?)(?=^\S|\Z)', re.S|re.M)
fns=[(m.group(1), m.group(2)) for m in fn_re.finditer(src)]
print("top-level fns:",len(fns))
ctor_re=re.compile(r'Node\.([A-Z][A-Za-z]*)\(')
total_ctors=len(ctor_re.findall(src)); nulls=len(re.findall(r'Node\.Null\b',src))
print("Node.X( constructions:",total_ctors," Node.Null:",nulls)
default_init=re.compile(r'var (\$\w+) = Node\.([A-Z]\w*)\(Node\.\w+_default\)')
update_same=re.compile(r'(\$\w+) = Node\.([A-Z]\w*)\(\{ \.\.Node\.\w+_of\(\1\)')
remaining=0; collapsed=0; n_default_inits=0; n_updates_local=0; n_updates_other=0
for name,body in fns:
    inits=dict((v,t) for v,t in default_init.findall(body))
    n_default_inits+=len(inits)
    ctors=ctor_re.findall(body)
    local_updates=0
    for v,t in update_same.findall(body):
        if v in inits: local_updates+=1
        else: n_updates_other+=1
    n_updates_local+=local_updates
    remaining+=len(ctors)-local_updates
print("default-initialized locals:",n_default_inits)
print("same-variant updates of a default-initialized local (collapsible):",n_updates_local)
print("same-variant updates of other vars (incoming nodes):",n_updates_other)
print("constructions remaining after collapsing locals:",remaining, " (+ Node.Null constructions:",nulls,")")
# duplicate bodies modulo integer literals and rule names
norm=collections.defaultdict(list)
for name,body in fns:
    if not name.startswith('rule_'): continue
    b=re.sub(r'\b\d+\b','#',body); b=re.sub(r'^## .*$','',b,flags=re.M)
    norm[b].append(name)
groups=[v for v in norm.values() if len(v)>1]
dup_fns=sum(len(v) for v in groups)
print("rule fns:",sum(1 for n,_ in fns if n.startswith('rule_')),"distinct bodies modulo int literals:",len(norm),"fns in duplicate groups:",dup_fns,"groups:",len(groups))
dup_ctors=sum((len(v)-1)*len(ctor_re.findall(norm_body)) for norm_body,v in norm.items() if len(v)>1)
print("constructions saved by sharing duplicate bodies:",dup_ctors)
