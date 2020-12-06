
## solution for aoc 2020 day 2
## https://adventofcode.com/2020/day/2

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ memfiles, os, sequtils,
    strformat, strscans, tables, unittest]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, shenanigans]

const
  day = "02"
  inPath = inputPath(day)
  checkpart1 = {
    inPath:569,
    }.toTable
  checkpart2 = {
    inPath:346,
    }.toTable

proc getPath():string = commandLineParams().getOr(0,inPath)

type Input = tuple
  lo,hi:int
  c:char
  pw:string

proc scanline(s:string):Input =
  var
    lo,hi:int
    cs:string
    pw:string
  if s.scanf("$i-$i $w: $w",lo,hi,cs,pw):
    return (lo,hi,cs[0],pw)

proc parse(path:string):seq[Input] =
  var mm = memfiles.open(path)
  defer: close(mm)
  for line in mm.lines:
    result.add line.scanline

proc valid(inp:Input):bool =
  inp.pw.countIt(it == inp.c) in inp.lo..inp.hi

proc valid2(inp:Input):bool =
  (inp.pw[inp.lo-1] == inp.c) xor (inp.pw[inp.hi-1] == inp.c)

proc part0*(path:string): seq[Input] =
  path.parse

proc part1*(inputs:seq[Input]): int =
  inputs.countIt(it.valid)

proc part2*(inputs:seq[Input]): int =
  inputs.countIt(it.valid2)

makeRunProc()

when isMainModule:
  var paths = getCliPaths(default=inPath)
  for path in paths:
    path.run.echoRR


#[
## Compiler commands:
nim r src/day/d02.nim
nim c --gc:arc -d:danger --opt:speed src/day/d02.nim && time out/run
nim check --warnings:on --hints:on src/day/d02.nim
nim r --gc:arc --hints:on --warnings:on -d:danger --opt:speed src/day/d02.nim
]#

#[
$ nim c --gc:arc -d:danger --opt:speed src/day/d02.nim && time out/run
Day02 at #19c4133
Read file and parse in 517 microseconds and 801 nanoseconds
Part1 is 569 in 17 microseconds and 442 nanoseconds
Part2 is 346 in 1 microsecond and 794 nanoseconds

real    0m0.004s
user    0m0.002s
sys     0m0.001s
]#

#[
  Strangely, removing the defer:doAssert from part1() and part2() made things _slower!_ I suspect this is due to some poor interaction between defer and my timing template. It doesn't make sense that adding a doAssert would make things faster.
$ nim c --gc:arc -d:danger --opt:speed src/day/d02.nim && time out/run

Day02 at #1957146
Read file and parse in 392 microseconds and 509 nanoseconds
Part1 is 569 in 22 microseconds and 486 nanoseconds
Part2 is 346 in 5 microseconds and 965 nanoseconds

real    0m0.004s
user    0m0.001s
sys     0m0.001s
]#