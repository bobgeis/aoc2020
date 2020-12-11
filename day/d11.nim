import lib/[imps]
const
  day = "11"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 2273
inpath.part2is 2064
testPath.part1is 37
testPath.part2is 26

type Seat = tuple[pos:Vec2i,adjs:seq[Vec2i]]
const dirs = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[1,-1],[-1,1],[-1,-1]]
proc sum[T](tab:CountTable[T]): int = tab.toSeq(values).sum
proc getAdjs(pos:Vec2i):seq[Vec2i] = dirs.mapit(it + pos)
proc part0*(path: string): seq[string] = path.getLines

proc makeSeats1(input:seq[string]):seq[Seat] =
  for j,line in input:
    for i,c in line:
      if c == 'L':
        let pos = [i,j].Vec2i
        result.add (pos,pos.getAdjs)

var tolerance = 3
proc checkseat(tab:CountTable[Vec2i],seat:Seat):int =
  let sum = seat.adjs.mapit(tab[it]).sum
  if sum == 0: 1
  elif sum > tolerance: 0
  else: tab[seat.pos]

proc iterate(seats:seq[Seat],src:CountTable[Vec2i],tar:var CountTable[Vec2i]):int =
  tar.clear
  for seat in seats:
    tar[seat.pos] = src.checkseat(seat)
  tar.sum

proc simulate(seats:seq[Seat]): int =
  var
    odds = initCountTable[Vec2i]().Ctab2i
    evens = initCountTable[Vec2i]().Ctab2i
    lastnum = 0
    num = seats.iterate(evens,odds)
  while true:
    lastnum = num
    num = seats.iterate(odds,evens)
    if lastnum == num and evens == odds:
      break
    lastnum = num
    num = seats.iterate(evens,odds)
    if lastnum == num and evens == odds:
      break
  return num

proc part1*(input: seq[string]): int =
  tolerance = 3
  return input.makeSeats1.simulate

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

proc makeseats2(ss:seq[string]):seq[Seat] =
  for j,line in ss:
    for i,c in line:
      if c == 'L':
        let pos = [i,j].Vec2i
        result.add (pos,pos.getVisible(ss))

proc part2*(input: seq[string]): int =
  tolerance = 4
  return input.makeSeats2.simulate

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

#[
  Speed is not good today :P
Times:
Part0:   0s   0ms 102us   2ns
Part1:   0s 914ms 642us 744ns
Part2:   0s 633ms 969us 258ns
Total:   1s 548ms 721us 687ns
]#

#[
  This day is slower by far than any that came before (~1.5 seconds!).
  THis is mostly because of my algorithm, which is a naive iteration.
  The simulation seems to flash but regions of stability grow in from the corners until the
  whole grid is static.
  It might be possible to leverage that using changelists.
  That is, each iteration, keep track of the seats that changed and only evaluate seats reachable
  from them.
  At first this should be the same or worse than the current method, but it will speed up as
  more of the grid becomes static.
  It might also be possible to use parallelization or a matrix package like arraymancer.
$ nim c -d:fast  day/d11.nim && time out/run
Day 11 at #a2a2cde for in/i11.txt
Part1: 2273
Part2: 2064
Times:
Part0:   0s   0ms 103us 709ns
Part1:   0s 908ms  57us 720ns
Part2:   0s 544ms 625us 210ns
Total:   1s 452ms 793us 655ns

real    0m1.469s
user    0m1.404s
sys     0m0.056s
]#