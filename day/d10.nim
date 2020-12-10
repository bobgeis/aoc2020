import lib/[imps]
const
  day = "10"
  inPath = inputPath(day)
  testPath = inputPath("10t1")
  testPath2 = inputPath("10t2")

inpath.part1is 1836
inpath.part2is 43406276662336.int
testpath.part1is 220
testpath.part2is 19208
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
when isMainModule: getCliPaths(inPath).doit(it.run.echoRR)

