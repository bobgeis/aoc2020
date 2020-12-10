import lib/[imps]
const
  day = "03"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")
  otherPath = inputPath(day,"o1")
testPath.part1is 7
testPath.part2is 336
inpath.part1is 278
inpath.part2is 9709761600.int
otherPath.part1is 257
otherPath.part2is 1744787392.int

proc part0*(path: string): seq[string] =
  path.getLines

proc part1*(input: seq[string], slope: Vec2i = [3, 1]): int =
  var
    pos = [0, 0]
    w = input[0].len
  for y in 0..input.high:
    if pos.y > input.high: return
    if input[pos.y][pos.x] == '#':
      inc result
    pos += slope
    pos.x = pos.x.wrap(w)

proc part2*(input: seq[string]): int =
  let slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
  result = 1
  for slope in slopes:
    result *= part1(input, slope)

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

#[
  $ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
Day03 at #4eadcd4
Read file in 122 microseconds and 717 nanoseconds
Part1 is 278 in 1 microsecond and 576 nanoseconds
Part2 is 9709761600 in 6 microseconds and 464 nanoseconds

real    0m0.004s
user    0m0.001s
sys     0m0.002s
]#
