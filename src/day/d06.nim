
## solution for aoc 2020 day 06
## https://adventofcode.com/2020/day/6

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ math, sequtils, strutils, tables, unittest]

# local lib modules: src/lib/
import lib/[aocutils, bedrock]

const
  day = "06"
  inPath = inputPath(day)
  otherPath = inputPath("06o1")
  checkpart1= {
    inPath:6506,
    otherPath:6768,
    }.toTable
  checkpart2 = {
    inPath:3243,
    otherPath:3489,
    }.toTable

proc toBitSetGroups(s:string):seq[set['a'..'z']] =
  var b:set['a'..'z'] = {}
  for c in s:
    if c == '\n':
      result.add b
      b = {}
    else: b.incl c
  if b.len > 0: result.add b

proc part0*(path:string): seq[seq[set['a'..'z']]] =
  path.readfile.split("\n\n").map(toBitSetGroups)

proc part1*(input:seq[seq[set['a'..'z']]]): int =
  input.mapit(it.foldl(a + b).card).sum

proc part2*(input:seq[seq[set['a'..'z']]]): int =
  input.mapit(it.foldl(a * b).card).sum

makeRunProc()

when isMainModule:
  getCliPaths(default=inPath).doit(it.run.echoRR)

#[
  Compiler commands:
```sh
export DAY="src/day/d06.nim"
nim r $DAY
nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
nim check --warnings:on --hints:on $DAY
nim r --gc:arc --hints:on --warnings:on -d:danger --opt:speed $DAY
```
]#

#[
  First solution
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
Day 06 at 1ca03d2 for in/i06.txt
Part1: 6506
Part2: 3243
Times:
Part0:   0s   0ms 193us 780ns
Part1:   0s   0ms 289us 116ns
Part2:   0s   0ms 259us 844ns
Total:   0s   0ms 754us 510ns

real    0m0.004s
user    0m0.002s
sys     0m0.001s
]#

#[
  Tried removing one set of extra string allocations and use a smaller bitset.
$ nim c -d:fast src/day/d06.nim && time out/run
Day 06 at 963d09d for in/i06.txt
Part1: 6506
Part2: 3243
Times:
Part0:   0s   0ms 447us 170ns
Part1:   0s   0ms   9us 735ns
Part2:   0s   0ms   8us  94ns
Total:   0s   0ms 481us 673ns

real    0m0.004s
user    0m0.001s
sys     0m0.001s
]#