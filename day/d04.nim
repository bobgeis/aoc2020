import lib/[imps]
const
  day = "04"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")
  otherPath = inputPath(day,"o1")
testPath.part1is 2
testPath.part2is 2
inpath.part1is 182
inpath.part2is 109
otherPath.part1is 233
otherPath.part2is 111

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

proc checkppCase(s: string): bool =
  var reqs = 0
  for kv in s.split({'\n', ' '}):
    [k, v] ..= kv.split(':')
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

# I like this more concise code from narimiran:
proc checkpp(s: string): bool =
  for k in ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]:
    if k notin s: return false
  return true

const
  eyecolors = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].toHashSet
  chars = {'0'..'9', 'a'..'f'}

template checkKey(key: string, body: untyped): untyped =
  if k == key:
    if body:
      inc reqs
    else:
      return false

proc checkpp2(s: string): bool =
  var reqs = 0
  for kv in s.split({'\n', ' '}):
    [k, v] ..= kv.split(':')
    checkKey "byr", v.parseInt in 1920..2002
    checkKey "iyr", v.parseInt in 2010..2020
    checkKey "eyr", v.parseInt in 2020..2030
    checkKey "hgt":
      var
        h: int
        u: string
      v.scanf("$i$w", h, u) and ((u == "in" and h in 59..76) or (u == "cm" and
          h in 150..193))
    checkKey "hcl", v.len == 7 and v[0] == '#' and v[1..v.high].allit(it in chars)
    checkKey "ecl", v in eyecolors
    checkKey "pid", v.len == 9 and v.parseInt >= 0
  if reqs == 7:
    return true

proc part0*(path: string): seq[string] =
  result = path.readFile.split("\n\n")

proc part1*(input: seq[string]): int =
  input.countit(it.checkpp)

proc part2*(input: seq[string]): int =
  input.countit(it.checkpp2)

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

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

#[
  Use template to reduce reptition. Slightly slower than case-of version, but it's harder to construct a template to generate correct of expressions (I'm sure it's possible in a macro).
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run

Day04 for in/i04.txt
Read file in 174 microseconds and 43 nanoseconds
Part1 is 182 in 404 microseconds and 558 nanoseconds
Part2 is 109 in 345 microseconds and 443 nanoseconds

real    0m0.004s
user    0m0.002s
sys     0m0.001s
]#
