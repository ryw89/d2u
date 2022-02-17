# `d2u` -- minimalist `dos2unix` implementation

Like `dos2unix`, this program's purpose is to replace DOS-style line
endings (`\r\n`) with Unix-style line endings (`\n`).

Unlike `dos2unix`, this program has no options whatsoever -- it just
changes line endings piped in from `stdin`. That's it. A feature-rich
replacement this is not. Additionally, this program assumes that `\r`
is _only_ at the end of a line. So no removing that pesky carriage
return if it's not followed by `\n`.

For my own amusement (and at the unfortunate cost of reducing
portability) this program uses the `SCAS` x86 CPU instruction to
determine whether a line contains `\r`. Maybe this provides some
speedup on files with longer lines -- see below. (Though almost
certainly there are better ways of achieving said speedup.)

## Comparison with other tools

Interestingly, this tool seems to perform better than `dos2unix` as
line length increases. But overall, if you just want to quickly remove
`\r`, good old `tr` is probably your best bet.

Here are some arbitrary benchmarks using a machine with an Intel
i7-8700 @ 4.6GHz:

| Command         | Lines    | Line length | Time  |
| --------------- | -------- | ----------- | ----- |
| `d2u`           | 10000000 | 50          | 1.41s |
| `dos2unix`      | 10000000 | 50          | 2.69s |
| `tr -d '\r'`    | 10000000 | 50          | 0.44s |
| `sed 's/\r//g'` | 10000000 | 50          | 2.15s |
| `d2u`           | 10000000 | 5           | 0.97s |
| `dos2unix`      | 10000000 | 5           | 0.43s |
| `tr -d '\r'`    | 10000000 | 5           | 0.10s |
| `sed 's/\r//g'` | 10000000 | 5           | 1.52s |

And here's how I made some random test data:

```bash
cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-X} | head -n Y | unix2dos
```

Where `X` is the length of each line and `Y` is the number of lines.
