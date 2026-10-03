"""Build JSONL input for tests/parser_corpus.roc from PostgreSQL regression SQL.

Install the pinned, test-only splitter in a local directory:
    python3 -m pip install --target local/python sqlparse==0.5.3
    PYTHONPATH=local/python python3 tools/parser_corpus.py local/parser-corpus.jsonl

This is a refactor differential test, not an oracle for SQL validity. Inputs
that the original parser rejects are retained, so error messages and positions
can be compared along with accepted parse trees.
"""

import argparse
import json
from pathlib import Path

import sqlparse


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    parser.add_argument("--postgres", type=Path, default=Path("local/postgres-18.6"))
    parser.add_argument("--examples", type=Path, default=Path("examples"))
    args = parser.parse_args()

    regression_dir = args.postgres / "src/test/regress/sql"
    if not regression_dir.is_dir():
        parser.error(f"PostgreSQL regression SQL is missing: {regression_dir}")
    sources = sorted(regression_dir.glob("*.sql")) + sorted(args.examples.glob("**/*.sql"))
    seen = set()
    unsplit = []
    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w") as output:
        for path in sources:
            source = path.read_text(errors="replace")
            # psql meta commands are not part of the raw SQL parser's input.
            source = "\n".join(
                line for line in source.splitlines() if not line.lstrip().startswith("\\")
            )
            try:
                statements = sqlparse.split(source)
            except sqlparse.exceptions.SQLParseError:
                # Keep even a file the splitter cannot handle, rather than
                # silently dropping it from the differential corpus.
                unsplit.append(str(path))
                statements = [source]
            for statement in statements:
                if not statement.strip() or statement in seen:
                    continue
                seen.add(statement)
                output.write(json.dumps({"sql": statement, "source": str(path)}) + "\n")

    print(f"{len(seen)} distinct SQL inputs from {len(sources)} files")
    if unsplit:
        print("Kept unsplit because of splitter limits:", *unsplit, sep="\n  ")


if __name__ == "__main__":
    main()
