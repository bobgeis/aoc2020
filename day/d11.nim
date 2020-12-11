import lib/[imps]
const
  day = "11"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 2273
# inpath.part2is 2
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

proc checkseat(tab:CountTable[Vec2i],seat:Seat):int =
  let sum = seat.adjs.mapit(tab[it]).sum
  if sum == 0: 1
  elif sum > 3: 0
  else: tab[seat.pos]

proc iterate(seats:seq[Seat],src:CountTable[Vec2i],tar:var CountTable[Vec2i]):int =
  tar.clear
  for seat in seats:
    tar[seat.pos] = src.checkseat(seat)
  tar.sum

proc simulate(seats:seq[Seat]): int =
  var
    odds = initCountTable[Vec2i]()
    evens = initCountTable[Vec2i]()
    lastnum = 0
    num = seats.iterate(evens,odds)
  while true:
    lastnum = num
    num = seats.iterate(odds,evens)
    if lastnum == num and evens == odds: break
    lastnum = num
    num = seats.iterate(evens,odds)
    if lastnum == num and evens == odds: break
  return num

proc part1*(input: seq[string]): int =
  return input.makeSeats1.simulate

proc part2*(input: seq[string]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

