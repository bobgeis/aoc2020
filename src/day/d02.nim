
## solution for aoc 2020 day 2
## https://adventofcode.com/2020/day/2

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[algorithm, deques, math, options, os, parsecsv, sequtils, sets,
    strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  dayNum = "02"
  inputFile = "data/i02.txt"

proc testFile(i: int): string = inputTestFilePath(dayNum, i)

proc part1*(): int =
  # defer: doAssert xxx == result
  result = 1

proc part2*(): int =
  # defer: doAssert xxx == result
  result = 2

when isMainModule:
  echo &"Day{dayNum}"
  var val1:int
  timeit &"Part1 is {val1}":
    val1 = part1()
  var val2:int
  timeit &"Part2 is {val2}":
    val2 = part2()

#[
## Compiler commands:
nim r src/day/d02.nim
nim c --gc:arc -d:danger --opt:speed src/day/d02.nim && time out/runme
nim check --warnings:on --hints:on src/day/d01.nim
]#
