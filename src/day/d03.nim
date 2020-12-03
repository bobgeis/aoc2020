
## solution for aoc 2020 day 3
## https://adventofcode.com/2020/day/3

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
  dayNum = "03"
  dayFile = &"data/i{dayNum}.txt"

proc getPath():string = commandLineParams().getOr(0,dayFile)
proc testFile(i: int): string = inputTestFilePath(dayNum, i)

proc part1*(input:seq[string], slope:Vec2i=[3,1]): int =
  var
    pos = [0,0]
  for y in 0..input.high:
    if pos.y > input.high: return
    if input[pos.y][pos.x] == '#':
      inc result
    pos += slope
    pos.x = pos.x.wrap(input[0].len)

proc part2*(input:seq[string]): int =
  let slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
  result = 1
  for slope in slopes:
    result *= part1(input,slope)

proc run*(path:string=dayFile) =
  echo &"Day{dayNum} at #{githash}"
  var input:seq[string]
  timeit "Read file":
    input = path.getlines
  var res1:int
  timeit &"Part1 is {res1}":
    res1 = part1(input)
  case path
  of dayFile: check res1 == 278
  of "data/i03t1.txt": check res1 == 7
  var res2:int
  timeit &"Part2 is {res2}":
    res2 = part2(input)
  case path
  of dayFile: check res2 == 9709761600
  of "data/i03t1.txt": check res2 == 336

when isMainModule:
  getPath().run()

#[
  Compiler commands:
```sh
export DAY="src/day/d03.nim"
nim r $DAY
nim r $DAY data/i03t1.txt
nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
nim check --warnings:on --hints:on $DAY
nim r --gc:arc --hints:on --warnings:on -d:danger --opt:speed $DAY
```
]#
