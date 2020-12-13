import lib/[imps]
# import times
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

proc tick(seats:Tab2i[seq[Vec2i]],state:var Tab2i[bool],changed:var Set2i) =
  for v in changed:
    let curr = state[v]
    state[v] = not state[v]

proc getChanges(seats:Tab2i[seq[Vec2i]],state:Tab2i[int8],changes:var seq[(Vec2i,int8)],tocheck:Set2i) =
  changes.setlen 0
  for v in tocheck:
    let curr = state[v]
    var sum = 0.int8
    for pos in seats[v]: sum.inc state[pos]
    if sum == 0 and curr == 0: changes.add (v,1.int8)
    elif sum > tolerance and curr == 1: changes.add (v,0.int8)

proc applyChanges(seats:Tab2i[seq[Vec2i]],state: var Tab2i[int8],changes:seq[(Vec2i,int8)],tocheck:var Set2i) =
  tocheck.init
  for (v,b) in changes:
    state[v] = b
    tocheck.incl v

proc simulate(seats:Tab2i[seq[Vec2i]]):int =
  var
    changes: seq[(Vec2i,int8)] = seats.toSeq(keys).mapit((it,0.int8))
    state = initTable[Vec2i,int8]()
    tocheck: Set2i
  while changes.len > 0:
    seats.applychanges(state,changes,tocheck)
    seats.getchanges(state,changes,tocheck)
  return state.toseq(values).mapit(it.int).sum

proc part0*(path: string): seq[string] = path.getLines

proc part1*(input: seq[string]): int =
  tolerance = 3
  # timevar prep:
  let seats = input.makeSeats1
  # timevar sim:
  result = seats.simulate
  # debug prep.inMilliseconds,sim.inMilliseconds

proc part2*(input: seq[string]): int =
  tolerance = 4
  # timevar prep:
  let seats = input.makeSeats2
  # timevar sim:
  result = seats.simulate
  # debug prep.inMilliseconds,sim.inMilliseconds

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

#[
  Remove some unnecessary allocations and type conversions
$ nim dt 11a
nim c  -d:fast day/d11a.nim
time out/run
Day 11 at #49ac352 for in/i11.txt
Part1: 2273
Part2: 2064
Times:
Part0:   0s   0ms 102us 578ns
Part1:   0s 343ms 445us 793ns
Part2:   0s 410ms 586us 117ns
Total:   0s 754ms 141us 850ns

real    0m0.762s
user    0m0.737s
sys     0m0.019s
]#
