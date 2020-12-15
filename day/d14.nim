import lib/[imps]
import std/[bitops]
const
  day = "14"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 8566770985168.int
# inpath.part2is 2
testPath.part1is 165
testPath.part2is 208

proc part0*(path: string): seq[string] =
  path.getLines

proc part1*(input: seq[string]): int =
  var
    mem = initTable[int,int]()
    maskClear: int
    maskSet:int
  for line in input:
    if line[0..6] == "mask = ":
      var
        clearStr:string
        setStr:string
      for x in line[6..^1]:
        if x == 'X':
          clearStr.add '0'
          setStr.add '0'
        elif x == '1':
          clearStr.add '0'
          setStr.add '1'
        elif x == '0':
          clearStr.add '1'
          setStr.add '0'
      discard clearStr.parsebin(maskClear)
      discard setStr.parsebin(maskset)
    else:
      var
        pos: int
        val: int
      if line.scanf("mem[$i] = $i",pos,val):
        val.clearMask(maskClear)
        val.setMask(maskSet)
        mem[pos] = val
  mem.toseq(values).sum

proc part2*(input: seq[string]): int =
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

