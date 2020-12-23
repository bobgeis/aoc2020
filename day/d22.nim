import lib/[imps]
const
  day = "22"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")
  testPath2 = inputPath(day,"t2")

inpath.part1is 32401
inpath.part2is 31436
testPath.part1is 306
testPath.part2is 291
testPath2.part2is 105

proc slice[T](d:Deque[T],m,n:int):Deque[T] =
  result = initDeque[T]()
  for i in m..n:
    result.addLast d[i]

proc slice[T](d:Deque[T],n:int):Deque[T] =
  result = initDeque[T]()
  for i in 0..n:
    result.addLast d[i]

proc part0*(path: string): seq[Deque[int]] =
  var cards: Deque[int]
  for line in path.getLines:
    if line.len == 0: continue
    if line[0] == 'P':
      if cards.len > 0: result.add cards
      cards = initDeque[int]()
    else: cards.addLast line.parseInt
  result.add cards

proc sumDeck(player:Deque[int]):int =
  for i,n in player:
    result += n * (player.len - i)

proc sumDecks(p1,p2:Deque[int]):int = sumDeck(if p1.len > 0: p1 else: p2)

proc part1*(input: seq[Deque[int]]): int =
  var
    p1 = input[0]
    p2 = input[1]
    sum = 0
  while p1.len > 0 and p2.len > 0:
    let
      v1 = p1.popFirst
      v2 = p2.popFirst
    if v1 > v2:
      p1.addLast v1
      p1.addLast v2
    else:
      p2.addLast v2
      p2.addLast v1
  sumDecks(p1,p2)

proc playRec(parent1,parent2:Deque[int],vpar1,vpar2:int):(bool,int) =
  var
    p1 = parent1.slice(vpar1-1)
    p2 = parent2.slice(vpar2-1)
    sums = initHashSet[int]()
  while p1.len > 0 and p2.len > 0:
    if sums.containsOrIncl(p1.sumDeck * p2.sumDeck):
      return (true,sumDeck(p1))
    let
      v1 = p1.popFirst
      v2 = p2.popFirst
    let win = if p1.len >= v1 and p2.len >= v2: playRec(p1,p2,v1,v2)[0]
      else: v1 > v2
    if win:
      p1.addlast v1
      p1.addlast v2
    else:
      p2.addlast v2
      p2.addlast v1
  return (p1.len > 0,sumDecks(p1,p2))

proc part2*(input: seq[Deque[int]]): int =
  result = playRec(input[0],input[1],input[0].len,input[1].len)[1]

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

#[
  There are probably better ways to do part 2
nim c  -d:fast day/d22.nim
time out/run
Day 22 at #eb5886a for in/i22.txt
Part1: 32401
Part2: 31436
Times:
Part0:   0s   0ms 377us 302ns
Part1:   0s   0ms  68us 545ns
Part2:   0s 258ms 185us 122ns
Total:   0s 258ms 640us 987ns

real    0m0.268s
user    0m0.256s
sys     0m0.004s
]#