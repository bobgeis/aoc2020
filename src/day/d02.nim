
## solution for aoc 2020 day 2
## https://adventofcode.com/2020/day/2

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ memfiles, os, sequtils,
    strformat, strscans, unittest]

# local lib modules: src/lib/
import lib/[bedrock, shenanigans]

const
  githash = staticexec "git rev-parse --short HEAD"
  dayNum = "02"
  dayFile = &"data/i{dayNum}.txt"

proc getPath():string = commandLineParams().getOr(0,dayFile)

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

proc part1*(inputs:seq[Input]): int =
  inputs.countIt(it.valid)

proc part2*(inputs:seq[Input]): int =
  inputs.countIt(it.valid2)

proc run*(path:string=dayFile) =
  echo &"Day{dayNum} at #{githash}"
  var inputs:seq[Input]
  timeit "Read file and parse":
    inputs = path.parse
  var res1:int
  timeit &"Part1 is {res1}":
    res1 = part1(inputs)
    if path == dayFile: check res1 == 569
  var res2:int
  timeit &"Part2 is {res2}":
    res2 = part2(inputs)
    if path == dayFile: check res2 == 346

when isMainModule:
  getPath().run()

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