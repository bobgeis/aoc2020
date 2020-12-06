
## solution for aoc 2020 day 00
## https://adventofcode.com/2020/day/00

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ algorithm, deques, math, memfiles, options, os, parsecsv, parseutils, sequtils, sets, strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  day = "00"
  inPath = inputPath(day)
  checkpart1 = {
    inPath:1,
    }.toTable
  checkpart2 = {
    inPath:2,
    }.toTable

proc part0*(path:string): seq[string] =
  path.getLines

proc part1*(input:seq[string]): int =
  result = 1

proc part2*(input:seq[string]): int =
  result = 2

makeRunProc()

when isMainModule:
  var paths = getCliPaths(default=inPath)
  for path in paths:
    path.run.echoRR

#[
  Compiler commands:
```sh
export DAY="src/day/d00.nim"
nim r $DAY
nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
nim check --warnings:on --hints:on $DAY
nim r --gc:arc --hints:on --warnings:on -d:danger --opt:speed $DAY
```
]#
