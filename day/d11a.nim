import lib/[imps]
const
  day = "11"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 2273
inpath.part2is 2064
testPath.part1is 37
testPath.part2is 26

const dirs = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[1,-1],[-1,1],[-1,-1]]
var tolerance = 3

proc getAdjs(pos:Vec2i,ss:seq[string]):seq[Vec2i] =
  let
    c1 = [0,0]
    c2 = [ss[0].high,ss.high]
  for dir in dirs:
    let adj = pos + dir
    if adj.aabb(c1,c2) and ss[adj] == 'L': result.add adj

proc getVisible(pos:Vec2i,ss:seq[string]):seq[Vec2i] =
  let
    c1 = [0,0]
    c2 = [ss[0].high,ss.high]
  for dir in dirs:
    var adj = pos + dir
    while adj.aabb(c1,c2):
      if ss[adj] == 'L':
        result.add adj
        break
      else: adj += dir

proc makeSeats1(input:seq[string]):Table[Vec2i,seq[Vec2i]] =
  for j,line in input:
    for i,c in line:
      if c == 'L':
        let pos = [i,j]
        result[pos] = pos.getAdjs(input)

proc makeSeats2(input:seq[string]):Table[Vec2i,seq[Vec2i]] =
  for j,line in input:
    for i,c in line:
      if c == 'L':
        let pos = [i,j]
        result[pos] = pos.getVisible(input)

proc getChanges(state:Tab2i[bool],seats:Tab2i[seq[Vec2i]],tocheck:Set2i):seq[(Vec2i,bool)] =
  for v in tocheck:
    let curr = state[v]
    var sum = 0
    for pos in seats[v]: sum.inc state[pos].int
    if sum == 0 and not curr: result.add (v,true)
    elif sum > tolerance and curr: result.add (v,false)

proc applyChanges(state: var Tab2i[bool],seats:Tab2i[seq[Vec2i]],changes:seq[(Vec2i,bool)]):Set2i =
  for (v,b) in changes:
    state[v] = b
    for pos in seats[v]:
      result.incl pos

proc simulate(seats:Tab2i[seq[Vec2i]]):int =
  var
    changes: seq[(Vec2i,bool)] = seats.toSeq(keys).mapit((it,false))
    state = initTable[Vec2i,bool]()
    tocheck: Set2i
  while changes.len > 0:
    debug changes.len
    tocheck = state.applychanges(seats,changes)
    changes = state.getchanges(seats,tocheck)
  return state.toseq(values).mapit(it.int).sum

proc part0*(path: string): seq[string] = path.getLines

proc part1*(input: seq[string]): int =
  tolerance = 3
  input.makeSeats1.simulate

proc part2*(input: seq[string]): int =
  tolerance = 4
  input.makeSeats2.simulate

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

#[
  I tried adding a changelist. This was NOT actually faster than my first attempt.
$ time out/run11 && time out/run11a

d11.nim
Day 11 at #7e795de for in/i11.txt
Part1: 2273
Part2: 2064
Times:
Part0:   0s   0ms 493us 825ns
Part1:   1s  43ms 847us  97ns
Part2:   0s 658ms 672us 936ns
Total:   1s 703ms  22us  65ns

real    0m1.709s
user    0m1.406s
sys     0m0.018s

d11a.nim
Day 11 at #7e795de for in/i11.txt
Part1: 2273
Part2: 2064
Times:
Part0:   0s   0ms 107us 254ns
Part1:   0s 772ms 789us 538ns
Part2:   0s 883ms 502us 144ns
Total:   1s 656ms 406us 417ns

real    0m1.662s
user    0m1.388s
sys     0m0.021s

]#