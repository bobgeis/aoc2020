
## solution for aoc 2020 day 05
## https://adventofcode.com/2020/day/5

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ algorithm, deques, math, memfiles, options, os, parsecsv, parseutils, sequtils, sets, strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  day = "05"
  inPath = inputPath(day)
  checkpart1 = {
    inPath:835,
    }.toTable
  checkpart2 = {
    inPath:649,
    }.toTable

proc parseToNumber(s:string):int =
  discard s.multiReplace(("L","0"),("F","0"),("R","1"),("B","1")).parseBin(result)

proc part0*(path:string): seq[int] =
  var f = memfiles.open(path)
  defer: f.close
  for line in f.lines:
    result.add line.parseToNumber
  result.sort

proc part1*(input:seq[int]): int =
  input[input.high]

proc part2*(input:seq[int]): int =
  for i,n in input:
    if input[i+1] != n+1:
      return n+1
  err &"Could not find your seat!"

makeRunProc()

when isMainModule:
  var paths = getCliPaths(default=inPath)
  for path in paths:
    path.run.echoRR

#[
  Compiler commands:
```sh
export DAY="src/day/dXX.nim"
nim r $DAY
nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
nim check --warnings:on --hints:on $DAY
nim r --gc:arc --hints:on --warnings:on -d:danger --opt:speed $DAY
```
]#

#[
  First solution. My parsing method is very slow :/
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run

Day 05

Answers for in/i05.txt
Part1: 835
Part2: 649

Times:
Part0:     0.353ms
Part1:     0.000ms
Part2:     0.000ms
Total:     0.363ms

real    0m0.004s
user    0m0.001s
sys     0m0.001s
]#