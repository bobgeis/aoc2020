import std/[memfiles]
import lib/[imports]

const
  day = "05"
  inPath = inputPath(day)
  checkpart1 = {
    inPath:835,
    }.toTable
  checkpart2 = {
    inPath:649,
    }.toTable

proc parseToNumber(s:string):int =
  discard s.multiReplace(("L","0"),("F","0"),("R","1"),("B","1")).parseBin(result)

proc part0*(path:string): seq[int] =
  var f = memfiles.open(path)
  defer: f.close
  for line in f.lines:
    result.add line.parseToNumber
  result.sort

proc part1*(input:seq[int]): int =
  input[^1]

proc part2*(input:seq[int]): int =
  for i,n in input:
    if input[i+1] != n+1:
      return n+1
  err &"Could not find your seat!"

makeRunProc()

when isMainModule:
  var paths = getCliPaths(default=inPath)
  for path in paths:
    path.run.echoRR

#[
  First solution. My parsing method is suboptimal
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
Day 05 at 0279e48 for in/i05.txt
Part1: 835
Part2: 649
Times:
Part0:   0s   0ms 346us 972ns
Part1:   0s   0ms   0us  67ns
Part2:   0s   0ms   0us 506ns
Total:   0s   0ms 359us 405ns

real    0m0.004s
user    0m0.001s
sys     0m0.001s
]#