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
  CmdKind = enum
    ckN = "N"
    ckE = "E"
    ckS = "S"
    ckW = "W"
    ckL = "L"
    ckR = "R"
    ckF = "F"
  Cmd = (CmdKind,int)

const
  dirTab = {ckN:[0,1],ckE:[1,0],ckS:[0,-1],ckW:[-1,0]}.toTable
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
  var cmd: CmdKind
  result[0] = parseEnum[CmdKind]($s[0])
  result[1] = parseInt(s[1..^1])

proc part0*(path: string): seq[Cmd] =
  for line in path.getLines:
    result.add line.scanCmd

proc part1*(input: seq[Cmd]): int =
  var
    angle = 0
    pos = [0,0]
  for (cmd,amt) in input:
    case cmd
    of ckN: pos += dirTab[ckN] * amt
    of ckE: pos += dirTab[ckE] * amt
    of ckS: pos += dirTab[ckS] * amt
    of ckW: pos += dirTab[ckW] * amt
    of ckF: pos += angTab[angle] * amt
    of ckR: angle = wrapA(angle - amt)
    of ckL: angle = wrapA(angle + amt)
  pos.mdist

proc part2*(input: seq[Cmd]): int =
  var
    pos = [0,0]
    way = [10,1]
  for (cmd,amt) in input:
    case cmd
    of ckN: way += dirTab[ckN] * amt
    of ckE: way += dirTab[ckE] * amt
    of ckS: way += dirTab[ckS] * amt
    of ckW: way += dirTab[ckW] * amt
    of ckF: pos += way * amt
    of ckL: way = way.rotate(amt)
    of ckR: way = way.rotate(360-amt)
  pos.mdist

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)


