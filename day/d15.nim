import lib/[imps]
const
  day = "15"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 387
# inpath.part2is 2
testPath.part1is 436
# testPath.part2is 2

proc part0*(path: string): seq[int] =
  path.readfile.split(',').mapit(it.parseInt)

proc part1*(input: seq[int]): int =
  var
    tab = initCountTable[int]()
    last = input[^1]
  for i,num in input:
    tab[num] = i + 1
  for i in input.len+1..2020:
    let lasttime = tab[last]
    if lasttime == 0:
      tab[last] = i - 1
      last = 0
    else:
      tab[last] = i - 1
      last = i - 1 - lasttime
  result = last

proc part2*(input: seq[int]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

