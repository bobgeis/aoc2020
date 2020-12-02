
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

proc part1*(nums:seq[int]): int =
  defer: doAssert 1018944 == result
  for i in 0..nums.high:
    for j in i..nums.high:
      let sum = nums[i] + nums[j]
      if sum == 2020 and i != j:
        return nums[i] * nums[j]

proc part1binary*(nums:seq[int]): int =
  defer: doAssert 1018944 == result
  let ns = nums.sorted
  for i in 0..ns.high:
    let
      x = 2020 - ns[i]
      j = ns.binarySearch(x)
    if j != -1 and i != j:
      return x * ns[i]

proc part2*(nums:seq[int]): int =
  defer: doAssert 8446464 == result
  for i in 0..nums.high:
    for j in i..nums.high:
      for k in j..nums.high:
        let sum = nums[i] + nums[j] + nums[k]
        if sum == 2020  and i != j and i != k and k != j:
          return nums[i] * nums[j] * nums[k]

proc part2binary*(nums:seq[int]): int =
  defer: doAssert 8446464 == result
  let ns = nums.sorted
  for i in 0..ns.high:
    for j in i..ns.high:
      let
        x = 2020 - ns[i] - ns[j]
        k = ns.binarySearch(x)
      if k != -1 and i != j and i != k and k != j:
        return x * ns[i] * ns[j]

when isMainModule:
  echo &"Day{dayNum}"
  timeit "Read file":
    let nums = inputFile.readIntLines
  timeit " ":
    echo &"Part1 is {part1(nums)}"
  timeit " ":
    echo &"Part2 is {part2(nums)}"
  timeit " ":
    echo &"Part1binary is {part1binary(nums)}"
  timeit " ":
    echo &"Part2binary is {part2binary(nums)}"

#[
## Timing for brute force approach (full loops which are O(n^2) and O(n^3)
## respectively), also for binary search approach (sort then binary search
## for last number, O(nlgn) and O(n^2lgn) respectively)
$ nim c --gc:arc -d:danger --opt:speed src/day/d01.nim && time out/runme
Day01
Read file in 143 microseconds and 360 nanoseconds
Part1 is 1018944
  in 5 microseconds and 383 nanoseconds
Part2 is 8446464
  in 857 microseconds and 658 nanoseconds
Part1binary is 1018944
  in 14 microseconds and 576 nanoseconds
Part2binary is 8446464
  in 13 microseconds and 794 nanoseconds

real    0m0.004s
user    0m0.002s
sys     0m0.002s
]#
