
## solution for aoc 2020 day 04
## https://adventofcode.com/2020/day/4

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ algorithm, deques, math, memfiles, options, os, parsecsv, sequtils, sets, strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  githash = staticexec "git rev-parse --short HEAD"
  day = "04"
  inPath = inputPath(day)
  testPath = inputPath("04t1")

#[
byr (Birth Year)
iyr (Issue Year)
eyr (Expiration Year)
hgt (Height)
hcl (Hair Color)
ecl (Eye Color)
pid (Passport ID)
cid (Country ID)
]#

type
  PassPort = object
    byr,iyr,eyr,hgt,hcl,ecl,pid,cid:string
    valid:bool

proc readpp(s:string):PassPort =
  var reqs = 0
  for kv in s.split({'\n',' '}):
    [k,v] ..= kv.split(':')
    case k
    of "byr":
      result.byr = v
      inc reqs
    of "iyr":
      result.iyr = v
      inc reqs
    of "eyr":
      result.eyr = v
      inc reqs
    of "hgt":
      result.hgt = v
      inc reqs
    of "hcl":
      result.hcl = v
      inc reqs
    of "ecl":
      result.ecl = v
      inc reqs
    of "pid":
      result.pid = v
      inc reqs
    of "cid":
      result.byr = v
    else:
      err &"unrecognized passport key{k}"
  if reqs == 7:
    result.valid = true

const
  eyecolors = ["amb","blu","brn","gry","grn","hzl","oth"].toHashSet
  chars = {'0'..'9','a'..'f'}

proc readpp2(s:string):PassPort =
  var reqs = 0
  for kv in s.split({'\n',' '}):
    [k,v] ..= kv.split(':')
    case k
    of "byr":
      if v.parseInt in 1920..2002:
        result.byr = v
        inc reqs
    of "iyr":
      if v.parseInt in 2010..2020:
        result.iyr = v
        inc reqs
    of "eyr":
      if v.parseInt in 2020..2030:
        result.eyr = v
        inc reqs
    of "hgt":
      var
        h:int
        u:string
      if v.scanf("$i$w",h,u) and
      ((u == "in" and h in 59..76) or (u == "cm" and h in 150..193)):
        result.hgt = v
        inc reqs
    of "hcl":
      if v.len == 7 and v[0] == '#' and v[1..v.high].allit(it in chars):
        result.hcl = v
        inc reqs
    of "ecl":
      if v in eyecolors:
        result.ecl = v
        inc reqs
    of "pid":
      if v.len == 9 and v.parseInt >= 0:
        result.pid = v
        inc reqs
    of "cid":
      result.byr = v
    else:
      err &"unrecognized passport key{k}"
  if reqs == 7:
    result.valid = true

proc parse*(path:string): seq[string] =
  result = path.readFile.split("\n\n")

proc part1*(input:seq[string]): int =
  input.countit(it.readpp.valid)

proc part2*(input:seq[string]): int =
  input.countit(it.readpp2.valid)

proc run*(path:string=inPath) =
  echo &"Day{day} for {path}"
  var input:seq[string]
  timeit "Read file":
    input = path.parse
  var res1:int
  timeit &"Part1 is {res1}":
    res1 = part1(input)
  var res2:int
  timeit &"Part2 is {res2}":
    res2 = part2(input)
  case path
  of inPath:
    check res1 == 182
    check res2 == 109
  of testPath:
    check res1 == 2
    check res2 == 2

when isMainModule:
  var paths = getCliPaths(default=inPath)
  for path in paths:
    echo ""
    path.run

#[
  Compiler commands:
```sh
export DAY="src/day/d04.nim"
nim r $DAY
nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
nim check --warnings:on --hints:on $DAY
nim r --gc:arc --hints:on --warnings:on -d:danger --opt:speed $DAY
```
]#
