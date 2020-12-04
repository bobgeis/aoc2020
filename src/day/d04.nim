
## solution for aoc 2020 day 04
## https://adventofcode.com/2020/day/4

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ sequtils, sets, strformat, strscans, strutils, unittest]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, shenanigans]

const
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
  FieldKind = enum
    fkByr,fkIyr,fkEyr,fkHgt,fkHcl,fkEcl,fkPid,fkCid
  PassPort = object
    byr,iyr,eyr,hgt,hcl,ecl,pid,cid:string
    valid:bool

proc toFieldKind(s:string):FieldKind =
  case s
    of "byr": fkByr
    of "iyr": fkIyr
    of "eyr": fkEyr
    of "hgt": fkHgt
    of "hcl": fkHcl
    of "ecl": fkEcl
    of "pid": fkPid
    of "cid": fkCid
    else:
      err &"Unrecognized passport field: {s}"
      fkCid

proc readpp(s:string):PassPort =
  var reqs = 0
  for kv in s.split({'\n',' '}):
    [k,v] ..= kv.split(':')
    case k.toFieldKind
    of fkByr:
      result.byr = v
      inc reqs
    of fkIyr:
      result.iyr = v
      inc reqs
    of fkEyr:
      result.eyr = v
      inc reqs
    of fkHgt:
      result.hgt = v
      inc reqs
    of fkHcl:
      result.hcl = v
      inc reqs
    of fkEcl:
      result.ecl = v
      inc reqs
    of fkpid:
      result.pid = v
      inc reqs
    of fkcid:
      result.byr = v
  if reqs == 7:
    result.valid = true

const
  eyecolors = ["amb","blu","brn","gry","grn","hzl","oth"].toHashSet
  chars = {'0'..'9','a'..'f'}

proc readpp2(s:string):PassPort =
  var reqs = 0
  for kv in s.split({'\n',' '}):
    [k,v] ..= kv.split(':')
    case k.toFieldKind
    of fkbyr:
      if v.parseInt in 1920..2002:
        result.byr = v
        inc reqs
    of fkiyr:
      if v.parseInt in 2010..2020:
        result.iyr = v
        inc reqs
    of fkeyr:
      if v.parseInt in 2020..2030:
        result.eyr = v
        inc reqs
    of fkhgt:
      var
        h:int
        u:string
      if v.scanf("$i$w",h,u) and
      ((u == "in" and h in 59..76) or (u == "cm" and h in 150..193)):
        result.hgt = v
        inc reqs
    of fkhcl:
      if v.len == 7 and v[0] == '#' and v[1..v.high].allit(it in chars):
        result.hcl = v
        inc reqs
    of fkecl:
      if v in eyecolors:
        result.ecl = v
        inc reqs
    of fkpid:
      if v.len == 9 and v.parseInt >= 0:
        result.pid = v
        inc reqs
    of fkcid:
      result.byr = v
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

#[
  First solution:
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run

Day04 for in/i04.txt
Read file in 349 microseconds and 171 nanoseconds
Part1 is 182 in 616 microseconds and 107 nanoseconds
Part2 is 109 in 688 microseconds and 88 nanoseconds

real    0m0.007s
user    0m0.003s
sys     0m0.002s
]#

#[
  Slight changes
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run

Day04 for in/i04.txt
Read file in 285 microseconds and 246 nanoseconds
Part1 is 182 in 471 microseconds and 272 nanoseconds
Part2 is 109 in 591 microseconds and 991 nanoseconds

real    0m0.006s
user    0m0.002s
sys     0m0.002s
]#