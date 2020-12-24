import lib/[imps]
const
  day = "24"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 394
inpath.part2is 4036
testPath.part1is 10
testPath.part2is 2208

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

proc part0*(path: string): Set2i =
  var tiles = initHashSet[Vec2i]()
  for line in path.getLines:
    let v = line.domoves
    if v in tiles: tiles.excl v
    else: tiles.incl v
  tiles

proc part1*(input: Set2i): int =
  input.len

proc getAdjs(v:Vec2i):array[6,Vec2i] =
  [[2,0],[-2,0],[1,1],[-1,-1],[1,-1],[-1,1]] + v

proc getPeers(live:Set2i):Set2i =
  for pos in live:
    result.incl pos
    for adj in pos.getAdjs: result.incl adj

proc getLive(live,peers:Set2i):Set2i =
  for pos in peers:
    var sum = 0
    for adj in pos.getAdjs:
      if adj in live: sum.inc
    if sum == 2: result.incl pos
    elif sum == 1 and pos in live: result.incl pos

proc tick(start:Set2i,iters:int = 1):Set2i =
  var
    live = start
    peers = start.getPeers
  for i in 1..iters:
    live = getLive(live,peers)
    peers = live.getPeers
  live

proc part2*(input: Set2i): int =
  input.tick(100).len

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

