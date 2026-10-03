"""Generate a package module with one big integer-literal match (like Actions.run)."""
import sys
n=int(sys.argv[1]); out=sys.argv[2]; m=int(sys.argv[3]) if len(sys.argv)>3 else n
lines=["Big :: [].{",
"        run : U64, List(I64), I64 -> Try(I64, [Bad])",
"        run = |rule, v, loc|",
"                match rule {"]
for i in range(2,2+m):
    lines.append(f"                        {i} => rule_{i}(v, loc)")
lines.append("                        _ => Ok(v.get(0) ?? 0)")
lines.append("                }")
lines.append("}")
for i in range(2,2+n):
    lines.append(f"rule_{i} : List(I64), I64 -> Try(I64, [Bad])")
    lines.append(f"rule_{i} = |v, loc| Ok((v.get(0) ?? 0) + loc + {i})")
open(out,'w').write("\n".join(lines)+"\n")
