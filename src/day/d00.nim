
## solution for aoc 2020 day XX
## https://adventofcode.com/2020/day/XX

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[algorithm, deques, math, options, os, parsecsv, sequtils, sets,
    strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  githash = staticexec "git rev-parse --short HEAD"
  dayNum = "XX"
  inputFile = &"data/i{dayNum}.txt"

proc testFile(i: int): string = inputTestFilePath(dayNum, i)

proc part1*(): int =
  # defer: doAssert xxx == result
  result = 1

proc part2*(): int =
  # defer: doAssert xxx == result
  result = 2

when isMainModule:
  echo &"Day{dayNum} at #{githash}"
  var input:seq[string]
  timeit "Read file":
    input = inputFile.getlines
  var res1:int
  timeit &"Part1 is {res1}":
    res1 = part1()
  var res2:int
  timeit &"Part2 is {res2}":
    res2 = part2()

#[
## Compiler commands:
nim r src/day/dXX.nim
nim c --gc:arc -d:danger --opt:speed src/day/dXX.nim && time out/runme
nim check --warnings:on --hints:on src/day/d01.nim
]#
