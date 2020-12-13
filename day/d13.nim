import lib/[imps]
const
  day = "13"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")
  testPath2 = inputPath(day,"t2")

inpath.part1is 205
inpath.part2is 803025030761664.int
testPath.part1is 295
testPath.part2is 1068781
testPath2.part2is 3417

proc parsebuses(s:string):seq[int] =
  for bus in s.split(','):
    var b:int
    if bus.parseint(b,0) > 0:
      result.add b

proc part0*(path: string): seq[string] =
  path.getlines

proc parse1(ss:seq[string]):(int,seq[int]) =
  result[0] = ss[0].parseint
  result[1] = ss[1].parsebuses

proc part1*(input:seq[string]): int =
  let (deptr,buses) = input.parse1
  var
    wait = int.high
    id = 0
  for i in buses:
    let
      d = deptr div i
      w = (d + 1) * i - deptr
    if w < wait:
      wait = w
      id = i
  return id * wait

proc parse2(s:string):seq[(int,int)] =
  let ss = s.split(',')
  for i,bus in ss:
    var b:int
    if bus.parseint(b,0) > 0:
      result.add (i,b)

proc part2*(input:seq[string]): int =
  ## Once we sync any two buses correctly,
  ## then we can treat them as a single larger bus with a longer period, lcm(a,b).
  ## We can do this repeatedly until we have a single large "bus".
  ## The time that this "bus" first departs is our answer.
  var period = 1
  for (i,bus) in input[1].parse2:
    let
      wait = (bus-i).pmod(bus) # account for the offset using python's mod
      newper = period.lcm(bus)
    for j in result.countup(newper, period):
      if j mod bus == wait:
        result = j
        period = newper
        break

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

#[
  There is some work duplicated bt part 1 and 2, but it's so fast that it's probably not worth addressing.
$ nim dt 13
nim c  -d:fast day/d13.nim
time out/run
Day 13 at #fbb0b76 for in/i13.txt
Part1: 205
Part2: 803025030761664
Times:
Part0:   0s   0ms  77us 399ns
Part1:   0s   0ms  12us 436ns
Part2:   0s   0ms  20us 168ns
Total:   0s   0ms 116us  91ns

real    0m0.004s
user    0m0.001s
sys     0m0.001s
]#
