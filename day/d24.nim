import lib/[imps]
const
  day = "24"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 394
# inpath.part2is 2
testPath.part1is 10
# testPath.part2is 2

proc move(v: Vec2i,dir:string):Vec2i =
  case dir
  of "se": v + [1,-1]
  of "sw": v + [-1,-1]
  of "ne": v + [1,1]
  of "nw": v + [-1,1]
  of "e": v + [2,0]
  of "w": v + [-2,0]
  else:
    err &"unknown dir {dir}"
    v

proc domoves(ms:string):Vec2i =
  var
    v = [0,0]
    off = 0
    dir = ""
  while off < ms.len:
    dir = ms[off].toString
    off.inc
    if dir == "s" or dir == "n":
      dir &= ms[off]
      off.inc
    v = v.move(dir)
  v

proc part0*(path: string): seq[string] =
  path.getLines

proc part1*(input: seq[string]): int =
  var
    tiles = initHashSet[Vec2i]()
  for line in input:
    let v = line.domoves
    if v in tiles: tiles.excl v
    else: tiles.incl v
  tiles.len

proc part2*(input: seq[string]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

