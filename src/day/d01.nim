
## solution for aoc 2020 day 1
## https://adventofcode.com/2020/day/1

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[algorithm, deques, math, options, os, parsecsv, sequtils, sets,
    strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  dayNum = "01"
  inputFile = inputFilePath(dayNum)

proc testFile(i: int): string = inputTestFilePath(dayNum, i)

let nums = inputFile.getlines.map(parseInt)

proc part1*(): int =
  for n in nums:
    for m in nums:
      let sum = n + m
      if sum == 2020:
        result = n * m
  assert 1018944 == result

proc part2*(): int =
  for ni,n in nums:
    for mi,m in nums:
      for oi,o in nums:
        let sum = n + m + o
        if sum == 2020:
          result = n * m * o
  assert 8446464 == result

when isMainModule:
  echo &"Day{dayNum}"
  echo &"Part1 {part1()}"
  echo &"Part2 {part2()}"

