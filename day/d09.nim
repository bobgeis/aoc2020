import std/[intsets]
import lib/[imps]
const
  day = "09"
  inPath = inputPath(day)

inpath.part1is 2089807806.int
# inpath.part2is 2

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

proc part2*(parsed: (seq[int],int)): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(inPath).doit(it.run.echoRR)

