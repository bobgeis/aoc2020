import std/[intsets]
import lib/[imps]
const
  day = "09"
  inPath = inputPath(day)

inpath.part1is 2089807806.int
inpath.part2is 245848639.int

proc checkPrev25(si:seq[int],idx:int):bool =
  let num = si[idx]
  for i in (idx-25)..(idx-1):
    for j in (idx-25)..(idx-1):
      if i != j and si[i] + si[j] == num:
        return false
  return true

proc getTargetNumber(si: seq[int]): int =
  for idx in 25..si.high:
    if si.checkPrev25(idx): return si[idx]
  return 0

proc part0*(path: string):(seq[int],int) =
  let si = path.readIntLines
  let n = si.getTargetNumber
  return (si,n)

proc part1*(parsed: (seq[int],int)): int =
  return parsed[1]

proc sum[T](d:Deque[T]):T =
  for t in d:
    result += t

proc min[T](d:Deque[T]):T =
  result = d[0]
  for t in d:
    if t < result: result = t

proc max[T](d:Deque[T]):T =
  result = d[0]
  for t in d:
    if result < t: result = t

proc walk(si:seq[int],target:int):int =
  var
    i = 0
    sum = 0
    d = initDeque[int]()
  while sum != target:
    if sum < target:
      d.addlast si[i]
      i.inc
    if sum > target:
      discard d.popfirst
    sum = d.sum
  return d.min + d.max

proc part2*(parsed: (seq[int],int)): int =
  parsed[0].walk(parsed[1])

makeRunProc()
when isMainModule: getCliPaths(inPath).doit(it.run.echoRR)

