import lib/[imports]

const
  day = "07"
  inPath = inputPath(day)
  testPath = inputPath("07t1")
  otherPath = inputPath("07o1")
  checkpart1 = {
    inpath: 119,
    testPath: 4,
    otherPath:205,
    }.toTable
  checkpart2 = {
    inpath: 155802,
    testPath: 32,
    otherPath:80902
    }.toTable

const
  myBag = "shiny gold"

type
  Bag = seq[(string, int)]
  BagTab = Table[string, Bag]

proc scanline(s: string, contains, containedby: var BagTab) =
  var
    bname, contents: string
    bag: Bag = @[]
  if s.scanf("$+ bags contain $+", bname, contents):
    if bname notin containedby:
      containedby[bname] = @[]
    for content in contents.split(", "):
      var
        num: int
        name: string
      if content.scanf("$i $+ bag", num, name):
        bag.add (name, num)
        if name notin containedby:
          containedby[name] = @[]
        containedby[name].add (bname, num)
    contains[bname] = bag

proc part0*(path: string): (BagTab, BagTab) =
  var
    contains = initTable[string, Bag]()
    containedby = initTable[string, Bag]()
  for line in path.getLines:
    line.scanline(contains, containedby)
  return (contains, containedby)

proc part1*(input: (BagTab, BagTab)): int =
  let bt = input[1]
  proc adjs(s: string): seq[string] = bt[s].mapit(it[0])
  bfs(mybag, adjs).len - 1 # - 1 because mybag doesn't contain itself

proc part2*(input: (BagTab, BagTab)): int =
  let bt = input[0]
  var
    q = @[(mybag, 1)]
  while q.len > 0:
    [name, num] ..= q.pop
    result.inc num
    q.add bt[name].mapit((it[0], it[1]*num))
  result.dec # because mybag doesn't contain itself

makeRunProc()

when isMainModule:
  getCliPaths(default = inPath).doit(it.run.echoRR)

#[
  First solution. Wow it's slow (compared to previous days anyway). Most time is spent in the parsing, but part1 could also be faster.
$ nim c -d:fast src/day/d07.nim && time out/run
Day 07 at 846e99f for in/i07.txt
Part1: 119
Part2: 155802
Times:
Part0:   0s   3ms 297us 756ns
Part1:   0s   0ms 621us 922ns
Part2:   0s   0ms  45us 856ns
Total:   0s   3ms 975us 200ns

real    0m0.008s
user    0m0.005s
sys     0m0.002s
]#
