
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

proc checkpp(s:string):bool =
  var reqs = 0
  for kv in s.split({'\n',' '}):
    [k,v] ..= kv.split(':')
    case k
    of "byr": inc reqs
    of "iyr": inc reqs
    of "eyr": inc reqs
    of "hgt": inc reqs
    of "hcl": inc reqs
    of "ecl": inc reqs
    of "pid": inc reqs
  if reqs == 7:
    return true

const
  eyecolors = ["amb","blu","brn","gry","grn","hzl","oth"].toHashSet
  chars = {'0'..'9','a'..'f'}

proc checkpp2(s:string):bool =
  var reqs = 0
  for kv in s.split({'\n',' '}):
    [k,v] ..= kv.split(':')
    case k
    of "byr":
      if v.parseInt in 1920..2002: inc reqs
      else: return false
    of "iyr":
      if v.parseInt in 2010..2020: inc reqs
      else: return false
    of "eyr":
      if v.parseInt in 2020..2030: inc reqs
      else: return false
    of "hgt":
      var
        h:int
        u:string
      if v.scanf("$i$w",h,u) and
      ((u == "in" and h in 59..76) or (u == "cm" and h in 150..193)):
        inc reqs
      else: return false
    of "hcl":
      if v.len == 7 and v[0] == '#' and v[1..v.high].allit(it in chars):
        inc reqs
      else: return false
    of "ecl":
      if v in eyecolors: inc reqs
      else: return false
    of "pid":
      if v.len == 9 and v.parseInt >= 0: inc reqs
      else: return false
  if reqs == 7:
    return true

proc parse*(path:string): seq[string] =
  result = path.readFile.split("\n\n")

proc part1*(input:seq[string]): int =
  input.countit(it.checkpp)

proc part2*(input:seq[string]): int =
  input.countit(it.checkpp2)

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

#[
  Y'know, we don't actually do anything with the passports, we just check that they are valid, I don't need to be creating an object from them XD
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run

Day04 for in/i04.txt
Read file in 179 microseconds and 11 nanoseconds
Part1 is 182 in 406 microseconds and 162 nanoseconds
Part2 is 109 in 332 microseconds and 867 nanoseconds

real    0m0.004s
user    0m0.002s
sys     0m0.001s
]#