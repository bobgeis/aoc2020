import lib/[imps]
const
  day = "01"
  inPath = inputPath(day)
inpath.part1is 1018944
inpath.part2is 8446464

proc part0*(path:string):seq[int] =
  path.readIntLines.sorted

proc part1brute*(nums: seq[int]): int =
  for i in 0..nums.high:
    for j in i..nums.high:
      let sum = nums[i] + nums[j]
      if sum == 2020 and i != j:
        return nums[i] * nums[j]

proc part1*(nums: seq[int]): int =
  for i in 0..nums.high:
    let
      x = 2020 - nums[i]
      j = nums.binarySearch(x)
    if j != -1 and i != j:
      return x * nums[i]

proc part2brute*(nums: seq[int]): int =
  for i in 0..nums.high:
    for j in i..nums.high:
      for k in j..nums.high:
        let sum = nums[i] + nums[j] + nums[k]
        if sum == 2020 and i != j and i != k and k != j:
          return nums[i] * nums[j] * nums[k]

proc part2*(nums: seq[int]): int =
  for i in 0..nums.high:
    for j in i..nums.high:
      let
        x = 2020 - nums[i] - nums[j]
        k = nums.binarySearch(x)
      if k != -1 and i != j and i != k and k != j:
        return x * nums[i] * nums[j]

makeRunProc()
when isMainModule: getCliPaths(inPath).doit(it.run.echoRR)

#[
## Timing for brute force approach (full loops which are O(n^2) and O(n^3)
## respectively), also for binary search approach (sort then binary search
## for last number, O(nlgn) and O(n^2lgn) respectively)
nim c --gc:arc -d:danger --opt:speed src/day/d01.nim && time out/runme
Day01
Read file in 143 microseconds and 360 nanoseconds
Part1 is 1018944
  in 5 microseconds and 383 nanoseconds
Part2 is 8446464
  in 857 microseconds and 658 nanoseconds
Part1binary is 1018944
  in 14 microseconds and 576 nanoseconds
Part2binary is 8446464
  in 13 microseconds and 794 nanoseconds

real    0m0.004s
user    0m0.002s
sys     0m0.002s
]#

#[
## Sorting the input actually makes ALL methods significantly faster.
## Inspecting the input, the vast majority of numbers are >1010, which
## means one or two of the numbers used will be early in the sorted seq.
## This effectively turns the problem into a near linear search :P
$ nim c --gc:arc -d:danger --opt:speed src/day/d01.nim && time out/runme
Day01
Read file and sort in 144 microseconds and 933 nanoseconds
Part1 is 1018944
  in 1 microsecond and 881 nanoseconds
Part2 is 8446464
  in 1 microsecond and 458 nanoseconds
Part1binary is 1018944
  in 1 microsecond and 506 nanoseconds
Part2binary is 8446464
  in 1 microsecond and 369 nanoseconds

real    0m0.003s
user    0m0.001s
sys     0m0.001s
]#

#[
## Running the same sorted program over someone else's input,
## that was a bit more varied than the one I got, gave slightly less absurd times:
$ nim c --gc:arc -d:danger --opt:speed src/day/d01.nim && time out/runme
Day01
Read file and sort in 166 microseconds and 544 nanoseconds
Part1 is 840324
  in 5 microseconds and 504 nanoseconds
Part2 is 170098110
  in 42 microseconds and 75 nanoseconds
Part1binary is 840324
  in 1 microsecond and 684 nanoseconds
Part2binary is 170098110
  in 14 microseconds and 174 nanoseconds

real    0m0.006s
user    0m0.001s
sys     0m0.002s
]#

#[
## Also deferring the echo until after the calculation is complete
## also makes each computation faster.
$ nim c --gc:arc -d:danger --opt:speed src/day/d01.nim && time out/runme
Day01

running my input
Read file and sort in 159 microseconds and 239 nanoseconds
Part1 is 1018944 in 1 microsecond and 337 nanoseconds
Part2 is 8446464 in 236 nanoseconds
Part1binary is 1018944 in 313 nanoseconds
Part2binary is 8446464 in 201 nanoseconds

running other's input
Read file and sort in 96 microseconds and 80 nanoseconds
Part1 is 840324 in 3 microseconds and 175 nanoseconds
Part2 is 170098110 in 46 microseconds and 633 nanoseconds
Part1binary is 840324 in 440 nanoseconds
Part2binary is 170098110 in 17 microseconds and 44 nanoseconds

real    0m0.004s
user    0m0.001s
sys     0m0.001s
]#

#[
  After re-aligning with the template:

$ nim c --gc:arc -d:danger --opt:speed src/day/d01.nim && time out/run

Day01 at #e8363de
Read file and sort in 156 microseconds and 805 nanoseconds
Part1 is 1018944 in 3 microseconds and 923 nanoseconds
Part2 is 8446464 in 268 nanoseconds

real    0m0.006s
user    0m0.001s
sys     0m0.002s

$ nim c --gc:arc -d:danger --opt:speed src/day/d01.nim && time out/run data/i01others.txt

Day01 at #e8363de
Read file and sort in 150 microseconds and 775 nanoseconds
Part1 is 840324 in 425 nanoseconds
Part2 is 170098110 in 12 microseconds and 699 nanoseconds

real    0m0.003s
user    0m0.001s
sys     0m0.001s
]#