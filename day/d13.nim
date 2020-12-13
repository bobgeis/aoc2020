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

