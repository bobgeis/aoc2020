import lib/[imps]
const
  day = "10"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")
  testPath2 = inputPath(day,"t2")

inpath.part1is 1836
inpath.part2is 43406276662336.int
testpath.part1is 220
testpath.part2is 19208
testpath2.part1is 35
testpath2.part2is 8

proc part0*(path: string): seq[int] =
  path.readIntLines.sorted

proc part1*(input: seq[int]): int =
  var ones, threes = 1 # ones=1 for outlet, threes=1 for device
  for i in 1..input.high:
    case input[i] - input[i-1]
    of 1: ones.inc
    of 3: threes.inc
    else: discard
  return ones * threes

proc part2*(input: seq[int]): int =
  var paths = [0].toCountTable
  for val in input:
    paths[val] = paths[val-1] + paths[val-2] + paths[val-3]
  return paths[input[^1]]

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

#[
$ nim c -d:fast day/d10.nim && time out/run
Day 10 at #2a81254 for in/i10.txt
Part1: 1836
Part2: 43406276662336
Times:
Part0:   0s   0ms 112us 659ns
Part1:   0s   0ms   0us 363ns
Part2:   0s   0ms  31us 637ns
Total:   0s   0ms 152us 873ns

real    0m0.003s
user    0m0.001s
sys     0m0.001s
]#