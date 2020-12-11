import lib/[imps]
const
  day = "11"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 2273
# inpath.part2is 2
testPath.part1is 37
testPath.part2is 26

proc part0*(path: string): seq[string] =
  path.getLines

proc getSeats(input:seq[string]):seq[Vec2i] =
  for j,line in input:
    for i,c in line:
      if c == 'L': result.add [i,j]

const adjs = [
  [0,1],
  [0,-1],
  [1,0],
  [-1,0],
  [1,1],
  [1,-1],
  [-1,1],
  [-1,-1],
]

proc getAdjs(pos:Vec2i):seq[Vec2i] = adjs.mapit(it + pos)

proc checkpos(tab:CountTable[Vec2i],pos:Vec2i): int =
  let sum = pos.getadjs.mapit(tab[it]).sum
  if sum == 0: 1
  elif sum > 3: 0
  else: tab[pos]

proc sum[T](tab:CountTable[T]): int = tab.toSeq(values).sum

proc iterate(seats:seq[Vec2i],src:CountTable[Vec2i],tar:var CountTable[Vec2i]):int =
  tar.clear
  for pos in seats:
    tar[pos] = src.checkpos(pos)
  tar.sum

proc part1*(input: seq[string]): int =
  var
    seats = input.getSeats
    odds = initCountTable[Vec2i]()
    evens = initCountTable[Vec2i]()
    lastnum = 0
    num = seats.iterate(evens,odds)
  while true:
    lastnum = num
    num = seats.iterate(evens,odds)
    if lastnum == num and evens == odds: break
    lastnum = num
    num = seats.iterate(odds,evens)
    if lastnum == num and evens == odds: break
  result = num

proc part2*(input: seq[string]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

