
## solution for aoc 2020 day 06
## https://adventofcode.com/2020/day/6

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ algorithm, deques, math, memfiles, options, os, parsecsv, parseutils, sequtils, sets, strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  day = "06"
  inPath = inputPath(day)
  checkpart1= {
    inPath:6506,
    }.toTable
  checkpart2 = {
    inPath:3243,
    }.toTable

proc toBitSetGroups(s:string):seq[set['a'..'z']] =
  var b:set['a'..'z'] = {}
  for c in s:
    if c == '\n':
      result.add b
      b = {}
    else:
      b.incl c
  if b.len > 0:
    result.add b

proc part0*(path:string): seq[seq[set['a'..'z']]] =
  path.readfile.split("\n\n").map(toBitSetGroups)

proc countGroup(ss:seq[set['a'..'z']]):int =
  ss.foldl(a + b).card

proc countGroup2(ss:seq[set['a'..'z']]):int =
  ss.foldl(a * b).card

proc part1*(input:seq[seq[set['a'..'z']]]): int =
  input.map(countgroup).sum

proc part2*(input:seq[seq[set['a'..'z']]]): int =
  input.map(countgroup2).sum

makeRunProc()

when isMainModule:
  var paths = getCliPaths(default=inPath)
  for path in paths:
    path.run.echoRR

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
Day 06 at <Uncommitted> for in/i06.txt
Part1: 6506
Part2: 3243
Times:
Part0:   0s   0ms 649us 724ns
Part1:   0s   0ms  11us 906ns
Part2:   0s   0ms  10us 402ns
Total:   0s   0ms 687us 371ns

real    0m0.004s
user    0m0.002s
sys     0m0.001s
]#