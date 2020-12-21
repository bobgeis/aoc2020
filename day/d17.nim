import lib/[imps]
const
  day = "17"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 388
inpath.part2is 2280
testPath.part1is 112
testPath.part2is 848

proc part0*(path: string): Set3i =
  for y,line in path.getlines:
    for x,c in line:
      if c == '#':
        result.incl [x,y,0]

proc getAdj(pos:Vec3i): seq[Vec3i] =
  for x in -1..1:
    for y in -1..1:
      for z in -1..1:
        if not (x == 0 and y == 0 and z == 0):
          result.add [x,y,z]

const adjs = [0,0,0].getAdj

proc getLive(live:Set3i,peers:Set3i): Set3i =
  for pos in peers:
    var sum = 0
    for adj in adjs:
      if live.contains(pos + adj): sum.inc
    if sum == 3 or ( sum == 2 and live.contains(pos)):
      result.incl pos

proc getPeers(live:Set3i):Set3i =
  for pos in live:
    result.incl pos
    for adj in adjs:
      result.incl( pos + adj )

proc tick(start:Set3i,iters:int = 1):Set3i =
  var
    live = start
    peers = start.getPeers
  for i in 1..iters:
    live = getLive(live,peers)
    peers = live.getPeers
  live

proc part1*(input: Set3i): int =
  input.tick(6).len

proc hyperize(input:Set3i):Set4i =
  for v in input:
    result.incl v.toVec4

proc getAdj(pos:Vec4i): seq[Vec4i] =
  for x in -1..1:
    for y in -1..1:
      for z in -1..1:
        for w in -1..1:
          if not (x == 0 and y == 0 and z == 0 and w == 0):
            result.add [x,y,z,w]

const adjs4 = [0,0,0,0].getAdj

proc getLive(live:Set4i,peers:Set4i): Set4i =
  for pos in peers:
    var sum = 0
    for adj in adjs4:
      if live.contains(pos + adj): sum.inc
    if sum == 3 or ( sum == 2 and live.contains(pos)):
      result.incl pos

proc getPeers(live:Set4i):Set4i =
  for pos in live:
    result.incl pos
    for adj in adjs4:
      result.incl( pos + adj )

proc tick(start:Set4i,iters:int = 1):Set4i =
  var
    live = start
    peers = start.getPeers
  for i in 1..iters:
    live = getLive(live,peers)
    peers = live.getPeers
  live

proc part2*(input: Set3i): int =
  input.hyperize.tick(6).len

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

