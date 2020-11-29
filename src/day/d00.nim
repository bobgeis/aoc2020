
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
  result = 1
  # assert xxx == result

proc part2*(): int =
  result = 2
  # assert xxx == result

when isMainModule:
  echo &"Day{dayNum}"
  echo &"Part1 {part1()}"
  echo &"Part2 {part2()}"

