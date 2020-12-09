{.experimental: "parallel".}
import std/[threadpool]
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

proc findSpots(hgc:HGC):seq[int] =
  for i,opi in hgc.code:
    if opi[0] == okacc: result.add i

proc runSpot(input: HGC, spot:int):int =
  var
    hgc = input.copyHgc
    curr = 0
    seen = initHashSet[int]()
  hgc.code[spot][0] = if hgc.code[spot][0] == oknop: okjmp else: oknop
  while curr < hgc.code.len:
    if curr in seen: return 0
    seen.incl curr
    curr = hgc.doOp curr
  return hgc.acc

proc runpara(input:HGC):int =
  let spots = input.findspots.reversed
  var ch = newSeq[int](spots.len)
  parallel:
    for i in 0..ch.high:
      ch[i] = spawn input.runSpot(i)
  ch.max

proc part2*(input: HGC): int =
  input.runpara

makeRunProc()
when isMainModule: getCliPaths(inPath).doit(it.run.echoRR)

#[
  Trying with parallel made it slower!
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