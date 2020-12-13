import lib/[imps]
const
  day = "12"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 521
inpath.part2is 22848
testPath.part1is 25
testPath.part2is 286

type
  Cmd = (char,int)

const
  dirTab = {'N':[0,1],'E':[1,0],'S':[0,-1],'W':[-1,0]}.toTable
  angTab = {0:[1,0],90:[0,1],180:[-1,0],270:[0,-1]}.toTable

proc wrapA(a:int):int = a.wrap(0,360)
proc rotate(v:Vec2i,a:int):Vec2i =
  case a
  of 90: [-v[1],v[0]]
  of 180: [-v[0],-v[1]]
  of 270: [v[1],-v[0]]
  else:
    err &"Unhandled a:{a}"
    [0,0]

proc scanCmd(s:string):Cmd =
  var num:int
  result[0] = s[0]
  discard parseInt(s,num,1)
  result[1] = num

proc part0*(path: string): seq[Cmd] =
  for line in path.getLines:
    result.add line.scanCmd

proc part1*(input: seq[Cmd]): int =
  var
    angle = 0
    pos = [0,0]
  for (cmd,amt) in input:
    case cmd
    of 'N': pos += dirTab['N'] * amt
    of 'E': pos += dirTab['E'] * amt
    of 'S': pos += dirTab['S'] * amt
    of 'W': pos += dirTab['W'] * amt
    of 'F': pos += angTab[angle] * amt
    of 'R': angle = wrapA(angle - amt)
    of 'L': angle = wrapA(angle + amt)
    else: discard
  pos.mdist

proc part2*(input: seq[Cmd]): int =
  var
    pos = [0,0]
    way = [10,1]
  for (cmd,amt) in input:
    case cmd
    of 'N': way += dirTab['N'] * amt
    of 'E': way += dirTab['E'] * amt
    of 'S': way += dirTab['S'] * amt
    of 'W': way += dirTab['W'] * amt
    of 'F': pos += way * amt
    of 'L': way = way.rotate(amt)
    of 'R': way = way.rotate(360-amt)
    else: discard
  pos.mdist

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

#[
  Initial timing.
  Processing into commands is the slowest step.
$ nim dt d12
nim c  -d:fast day/d12.nim
time out/run
Day 12 at #da2aa06 for in/i12.txt
Part1: 521
Part2: 22848
Times:
Part0:   0s   0ms 375us 194ns
Part1:   0s   0ms  37us 851ns
Part2:   0s   0ms  29us 582ns
Total:   0s   0ms 450us  18ns

real    0m0.004s
user    0m0.001s
sys     0m0.001s
]#

#[
  Changing parsing maybe sped things up a little.
$ nim dt d12
nim c  -d:fast day/d12.nim
time out/run
Day 12 at #ef9f4d3 for in/i12.txt
Part1: 521
Part2: 22848
Times:
Part0:   0s   0ms 219us 320ns
Part1:   0s   0ms  40us 655ns
Part2:   0s   0ms  30us 799ns
Total:   0s   0ms 297us 235ns

real    0m0.004s
user    0m0.001s
sys     0m0.001s
]#