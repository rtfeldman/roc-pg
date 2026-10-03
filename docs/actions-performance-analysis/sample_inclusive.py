"""Inclusive sample counts per function name (recursion counted once) for one
thread of a macOS `sample` call-graph file, with optional root-name filter.
Usage: python3 sample_inclusive.py FILE THREAD_LINE_NO [ROOT_SUBSTRING] [TOP]"""
import re,sys,collections
path=sys.argv[1]; thread_line=int(sys.argv[2]); root=sys.argv[3] if len(sys.argv)>3 else None
top=int(sys.argv[4]) if len(sys.argv)>4 else 70
lines=open(path).read().split('\n')
pat=re.compile(r'^([\s+!:|]*)(\d+) (.*?)  \(in (.*?)\)')
pat2=re.compile(r'^([\s+!:|]*)(\d+) (.*)$')
incl=collections.Counter(); selfc=collections.Counter(); stack=[]; total=None
for l in lines[thread_line-1:]:
    m=pat.match(l) or pat2.match(l)
    if not m: break
    depth=len(m.group(1)); cnt=int(m.group(2)); name=m.group(3).split(' + ')[0].strip()
    if total is None: total=cnt
    elif depth==0: break
    while stack and stack[-1][0]>=depth:
        d,n,c,childsum=stack.pop(); selfc[n]+=c-childsum
        if stack: stack[-1][3]+=c
    anc=[s[1] for s in stack]
    if root is None or any(root in a for a in anc) or root in name:
        if name not in anc: incl[name]+=cnt
    stack.append([depth,name,cnt,0])
while stack:
    d,n,c,childsum=stack.pop(); selfc[n]+=c-childsum
    if stack: stack[-1][3]+=c
print("thread total",total)
for n,c in incl.most_common(top): print(f"{c:6d} {selfc[n]:6d}  {n}")
