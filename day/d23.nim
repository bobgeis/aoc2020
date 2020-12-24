import lib/[imps]
const
  day = "23"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

# inpath.part1is 1
# inpath.part2is 2
# testPath.part1is 92658374.int # for 10 rounds
testPath.part1is 67384529.int
# testPath.part2is 2

type
  Cups = array[1..9,int] # we're dealing with 1-9
  Plukt = array[3,int]

proc toNums(cups:Cups,curr:int):seq[int] =
  var p = curr
  for i in 1..9:
    result.add p
    p = cups[p]

proc part0*(path: string): (Cups,int) =
  let
    nums = path.readfile.mapit(it.parseint)
    first = nums[0]
  var
    cups:Cups = [0,0,0,  0,0,0,  0,0,0]
    last = first
  for n in nums:
    cups[last] = n
    last = n
  cups[last] = first
  (cups,first)

proc getPluckt(cups: Cups, curr:int):Plukt =
  [cups[curr],cups[cups[curr]],cups[cups[cups[curr]]]]

proc wrapLow(i:int):int =
  if i > 0: i
  else: 9

proc getDest(cups:Cups, curr:int, plukt: Plukt ):int =
  result = wrapLow(curr - 1)
  while result in plukt:
    result = wrapLow(result - 1)

proc move(cups: var Cups, curr:int):int =
  let
    plukt = cups.getPluckt(curr)
    dest = cups.getDest(curr,plukt)
  cups[curr] = cups[plukt[^1]]
  cups[plukt[^1]] = cups[dest]
  cups[dest] = plukt[0]
  cups[curr]

proc score(cups:Cups):int =
  var
    curr = cups[1]
    s = ""
  while curr != 1:
    s &= $curr
    curr = cups[curr]
  return s.parseint

proc play(icups:Cups,icurr:int):int =
  var
    cups = icups
    curr = icurr
  for i in 1..100:
    curr = cups.move(curr)
  cups.score

proc part1*(input: (Cups,int)): int =
  play(input[0],input[1])

proc part2*(input: (Cups,int)): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

