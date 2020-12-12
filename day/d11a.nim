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
$ nim dcf -o:out/run11 11 && nim dcf -o:out/run11a 11a && time out/run11 && time out/run11a
nim c -o:out/run11 -d:fast day/d11.nim
nim c -o:out/run11a -d:fast day/d11a.nim
Day 11 at #452e853 for in/i11.txt
Part1: 2273
Part2: 2064
Times:
Part0:   0s   0ms  89us 151ns
Part1:   0s 779ms 838us 767ns
Part2:   0s 484ms  58us 757ns
Total:   1s 263ms 993us 752ns

real    0m1.268s
user    0m1.257s
sys     0m0.004s
Day 11 at #452e853 for in/i11.txt
Part1: 2273
Part2: 2064
Times:
Part0:   0s   0ms 102us 228ns
Part1:   0s 565ms 802us 416ns
Part2:   0s 643ms 473us 143ns
Total:   1s 209ms 385us 146ns

real    0m1.214s
user    0m1.202s
sys     0m0.005s
]#