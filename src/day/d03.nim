
## solution for aoc 2020 day 3
## https://adventofcode.com/2020/day/3

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ strformat, tables, unittest]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, shenanigans, vecna]

const
  day = "03"
  inPath = inputPath(day)
  testPath = inputPath("03t1")
  otherPath = inputPath("03o1")
  checkpart1 = {
    inPath:278,
    testPath:7,
    otherPath:257,
    }.toTable
  checkpart2 = {
    inPath:9709761600.int,
    testPath:336.int,
    otherPath:1744787392.int,
    }.toTable

proc part0*(path:string): seq[string] =
  path.getLines

proc part1*(input:seq[string], slope:Vec2i=[3,1]): int =
  var
    pos = [0,0]
    w = input[0].len
  for y in 0..input.high:
    if pos.y > input.high: return
    if input[pos.y][pos.x] == '#':
      inc result
    pos += slope
    pos.x = pos.x.wrap(w)

proc part2*(input:seq[string]): int =
  let slopes = [[1,1],[3,1],[5,1],[7,1],[1,2]]
  result = 1
  for slope in slopes:
    result *= part1(input,slope)

makeRunProc()

when isMainModule:
  var paths = getCliPaths(default=inPath)
  for path in paths:
    path.run.echoRR

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

#[
  $ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
Day03 at #4eadcd4
Read file in 122 microseconds and 717 nanoseconds
Part1 is 278 in 1 microsecond and 576 nanoseconds
Part2 is 9709761600 in 6 microseconds and 464 nanoseconds

real    0m0.004s
user    0m0.001s
sys     0m0.002s
]#