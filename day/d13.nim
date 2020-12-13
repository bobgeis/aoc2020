import lib/[imps]
const
  day = "13"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 205
# inpath.part2is 2
testPath.part1is 295
testPath.part2is 1068781

proc parsebuses(s:string):seq[int] =
  for bus in s.split(','):
    var b:int
    if bus.parseint(b,0) > 0:
      result.add b

proc part0*(path: string): seq[string] =
  path.getlines

proc parse1(ss:seq[string]):(int,seq[int]) =
  result[0] = ss[0].parseint
  result[1] = ss[1].parsebuses

proc part1*(input:seq[string]): int =
  let (dept,buses) = input.parse1
  var
    wait = int.high
    id = 0
  for i in buses:
    let
      d = dept div i
      w = (d + 1) * i - dept
    if w < wait:
      wait = w
      id = i
  return id * wait

proc part2*(input:seq[string]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

