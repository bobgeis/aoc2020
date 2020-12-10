import lib/[imps]
const
  day = "10"
  inPath = inputPath(day)
  testPath = inputPath("10t1")

inpath.part1is 1836
# inpath.part2is 2
testpath.part1is 220
testpath.part2is 19208

system.`-`.liftToMap2(minusMap)

proc part0*(path: string): seq[int] =
  path.readIntLines.sorted

proc part1*(input: seq[int]): int =
  let ds = minusMap(input[1..input.high],input[0..(input.high - 1)])
  # ones + 1 for the outlet and threes +1 for the device
  return (ds.countit(it == 1) + 1) * (ds.countit(it == 3) + 1)

proc part2*(input: seq[int]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(inPath).doit(it.run.echoRR)

