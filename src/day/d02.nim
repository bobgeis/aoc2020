
## solution for aoc 2020 day 2
## https://adventofcode.com/2020/day/2

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[algorithm, deques, math, memfiles, options, os, parsecsv, sequtils, sets,
    strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  githash = staticexec "git rev-parse --short HEAD"
  dayNum = "02"
  inputFile = &"data/i{dayNum}.txt"

proc testFile(i: int): string = inputTestFilePath(dayNum, i)

type Input = tuple
  min,max:int
  c:char
  pw:string

proc scanline(s:string):Input =
  var
    minCount,maxCount:int
    letter:string
    pw:string
  if s.scanf("$i-$i $w: $w",minCount,maxCount,letter,pw):
    return (minCount,maxCount,letter[0],pw)

proc parse(path:string):seq[Input] =
  var mm = memfiles.open(path)
  defer: close(mm)
  for line in mm.lines:
    result.add line.scanline

proc valid(inp:Input):bool =
  var count = 0
  for c in inp.pw:
    if c == inp.c:
      inc count
  count in inp.min..inp.max

proc valid2(inp:Input):bool =
  (inp.pw[inp.min-1] == inp.c) xor (inp.pw[inp.max-1] == inp.c)

proc part1*(inputs:seq[Input]): int =
  defer: doAssert 569 == result
  inputs.countIt(it.valid)

proc part2*(inputs:seq[Input]): int =
  defer: doAssert 346 == result
  inputs.countIt(it.valid2)

when isMainModule:
  echo &"Day{dayNum} at #{githash}"
  var inputs:seq[Input]
  timeit "Read file and parse":
    inputs = inputFile.parse
  var res1:int
  timeit &"Part1 is {res1}":
    res1 = part1(inputs)
  var res2:int
  timeit &"Part2 is {res2}":
    res2 = part2(inputs)

#[
## Compiler commands:
nim r src/day/d02.nim
nim c --gc:arc -d:danger --opt:speed src/day/d02.nim && time out/runme
nim check --warnings:on --hints:on src/day/d01.nim
]#

#[
  First attempt
$ nim c --gc:arc -d:danger --opt:speed src/day/d02.nim && time out/runme
Day02 at #19c4133
Read file and parse in 517 microseconds and 801 nanoseconds
Part1 is 569 in 17 microseconds and 442 nanoseconds
Part2 is 346 in 1 microsecond and 794 nanoseconds

real    0m0.004s
user    0m0.002s
sys     0m0.001s
]#