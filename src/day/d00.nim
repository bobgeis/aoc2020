
## solution for aoc 2020 day 0
## https://adventofcode.com/2020/day/0

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[algorithm, deques, math, options, os, parsecsv, sequtils, sets,
    strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  dayNum = "00"
  inputFile = inputFilePath(dayNum)

proc testFile(i: int): string = inputTestFilePath(dayNum, i)

proc part1*(): int =
  # defer: doAssert xxx == result
  result = 1

proc part2*(): int =
  # defer: doAssert xxx == result
  result = 2

when isMainModule:
  echo &"Day{dayNum}"
  timeit " ":
    echo &"Part1 is {part1()}"
  timeit " ":
    echo &"Part2 is {part2()}"

