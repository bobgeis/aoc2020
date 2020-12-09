import lib/[imps]
const
  day = "08"
  inPath = inputPath(day)
  testPath = inputPath("08t1")
inpath.part1is 1217
inpath.part2is 501
testPath.part1is 5
testPath.part2is 8

type
  OpKind = enum
    oknop = "nop"
    okacc = "acc"
    okjmp = "jmp"
  Operation = (OpKind, int)
  HGC = ref object
    code: seq[Operation]
    acc: int
    seen: HashSet[int]

proc newHgc(code: seq[Operation]): HGC =
  result = HGC(
    code: code,
    acc: 0,
  )

proc copyHgc(hgc: HGC): HGC =
  result = HGC(code: hgc.code, acc: 0)

proc scanOp(s: string): Operation =
  var op: string; var i: int
  if s.scanf("$w $i", op, i):
    return (parseEnum[OpKind](op), i)
  else: err &"Would not scan: {s}"

proc pathToHgc(path: string): HGC =
  path.getLines.mapit(it.scanOp).newHgc

proc doOp(hgc: var HGC, curr: int): int =
  [op, i] ..= hgc.code[curr]
  case op
  of oknop: return curr + 1
  of okjmp: return curr + i
  of okacc:
    hgc.acc.inc(i)
    return curr + 1

proc run(hgc: var HGC): int =
  var
    curr = 0
    seen = initHashSet[int]()
  while curr notin seen:
    seen.incl curr
    curr = hgc.doOp curr
  return hgc.acc

proc part0*(path: string): HGC =
  path.pathToHgc

proc part1*(input: HGC): int =
  var hgc = input.copyHgc
  hgc.run

proc changeLastJmpOrkNop(hgc: var HGC, start: int): int =
  for i in start.countdown(0):
    [op] ..= hgc.code[i]
    if op == okjmp:
      hgc.code[i][0] = oknop
      return i - 1
    elif op == oknop:
      hgc.code[i][0] = okjmp
      return i - 1

proc run2(hgc: var HGC): int =
  var
    curr = 0
    seen = initHashSet[int]()
  while curr < hgc.code.len:
    if curr in seen: return 0
    seen.incl curr
    curr = hgc.doOp curr
  return hgc.acc

proc part2*(input: HGC): int =
  var
    hgc = input.copyHgc
    start = input.code.high
  while hgc.run2 == 0:
    hgc = input.copyHgc
    start = hgc.changeLastJmpOrkNop(start)
  hgc.acc

makeRunProc()
when isMainModule: getCliPaths(inPath).doit(it.run.echoRR)

#[
  First approach I thought of, probably room for improvement.
$ nim c -d:fast day/d08.nim && time out/run
Day 08 at #55facf9 for in/i08.txt
Part1: 1217
Part2: 501
Times:
Part0:   0s   0ms 559us 824ns
Part1:   0s   0ms  57us 255ns
Part2:   0s   5ms 559us 327ns
Total:   0s   6ms 183us 124ns

real    0m0.010s
user    0m0.007s
sys     0m0.002s
]#

#[
  Trying with parallel made it slower! Might be because I have an old laptop with only 2 cores...
$ nim c --threads:on -d:fast day/d08.nim && time out/run
Day 08 at #4ef64b2 for in/i08.txt
Part1: 1217
Part2: 501
Times:
Part0:   0s   0ms 735us 275ns
Part1:   0s   0ms  86us 178ns
Part2:   0s  16ms 193us 432ns
Total:   0s  17ms  22us 760ns

real    0m0.022s
user    0m0.033s
sys     0m0.009s
]#