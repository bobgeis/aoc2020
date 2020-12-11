import lib/[imps]
const
  day = "11"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

# inpath.part1is 1
# inpath.part2is 2
testPath.part1is 37
# testPath.part2is 2

proc part0*(path: string): seq[string] =
  path.getLines

proc part1*(input: seq[string]): int =
  input.doit(it.echo)
  result = 0

proc part2*(input: seq[string]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

