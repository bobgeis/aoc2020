
## solution for aoc 2020 day XX
## https://adventofcode.com/2020/day/XX

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[
  algorithm, deques, math, options, os, parsecsv,
  sequtils, sets, strformat, strscans, strtabs,
  strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  githash = staticexec "git rev-parse --short HEAD"
  dayNum = "XX"
  dayFile = &"data/i{dayNum}.txt"

proc getPath():string = commandLineParams().getOr(0,dayFile)
proc testFile(i: int): string = inputTestFilePath(dayNum, i)

proc part1*(): int =
  result = 1

proc part2*(): int =
  result = 2

proc run*(path:string=dayFile) =
  echo &"Day{dayNum} at #{githash}"
  var input:seq[string]
  timeit "Read file":
    input = path.getlines
  var res1:int
  timeit &"Part1 is {res1}":
    res1 = part1()
    # if path == dayFile: check res1 == ?
  var res2:int
  timeit &"Part2 is {res2}":
    res2 = part2()
    # if path == dayFile: check res2 == ?

when isMainModule:
  getPath().run()

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
