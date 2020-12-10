import lib/[imps]
const
  day = "10"
  inPath = inputPath(day)
  testPath = inputPath("10t1")

inpath.part1is 1836
# inpath.part2is 2
testpath.part1is 220
testpath.part2is 19208

proc part0*(path: string): seq[int] =
  path.readIntLines.sorted

proc part1*(input: seq[int]): int =
  var
    ones = 1    # +1 for the outlet
    threes = 1  # +1 for the device
  for i in 1..input.high:
    let diff = input[i] - input[i-1]
    if diff == 1: ones.inc
    elif diff == 3: threes.inc
  return ones * threes

proc part2*(input: seq[int]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(inPath).doit(it.run.echoRR)

