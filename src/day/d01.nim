
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

let nums = inputFile.readIntLines

proc part1*(): int =
  defer: doAssert 1018944 == result
  for n in nums:
    for m in nums:
      let sum = n + m
      if sum == 2020 and n != m:
        return n * m

proc part2*(): int =
  defer: doAssert 8446464 == result
  for n in nums:
    for m in nums:
      for o in nums:
        let sum = n + m + o
        if sum == 2020 and n != m and m != o and o != n:
          return n * m * o

when isMainModule:
  echo &"Day{dayNum}"
  timeit " ":
    echo &"Part1 {part1()}"
  timeit " ":
    echo &"Part2 {part2()}"

#[
## Timing for brute force approach (full loops which are O(n^2) and O(n^3) respectively):
$ nim c --gc:arc -d:danger --opt:speed src/day/d01.nim
$ time out/runme
Day01
Part1 1018944
  in 15 microseconds and 271 nanoseconds
Part2 8446464
  in 1 millisecond, 990 microseconds, and 73 nanoseconds

real    0m0.007s
user    0m0.003s
sys     0m0.002s
]#
