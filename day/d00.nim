
import lib/[imports]

const
  day = "00"
  inPath = inputPath(day)
  checkpart1 = {
    "path":0,
    }.toTable
  checkpart2 = {
    "path":0,
    }.toTable

proc part0*(path:string): seq[string] =
  path.getLines

proc part1*(input:seq[string]): int =
  result = 0

proc part2*(input:seq[string]): int =
  result = 0

makeRunProc()

when isMainModule:
  getCliPaths(default=inPath).doit(it.run.echoRR)

