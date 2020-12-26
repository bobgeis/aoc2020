import lib/[imps]
const
  day = "25"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 7032853
testPath.part1is 14897079.int

const connum = 20201227

proc part0*(path: string): seq[int] =
  path.getLines.mapit(it.parseInt)

proc findLoopSize(num:int):int =
  let sub = 7
  var i = sub
  result = 1
  while i != num:
    i = (i * sub) mod connum
    result.inc

proc findEncKey(sub:int,loops:int):int =
  result = 1
  for i in 1..loops:
    result = (result * sub) mod connum

proc part1*(input: seq[int]): int =
  let
    pub1loops = input[0].findLoopSize
    pub2loops = input[1].findLoopSize
    pri1 = findEncKey(input[0],pub2loops)
  when not defined(release):
    let pri2 =  findEncKey(input[1],pub1loops)
    if pri1 != pri2:
      err &"Error! {pri1} != {pri2}"
  result = pri1

proc part2*(input: seq[int]): int = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

