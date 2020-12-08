## run all the days in sequence
import std/[strformat]
import lib/[aocutils]

import d01, d02, d03, d04, d05, d06, d07

const githash = staticexec "git rev-parse --short HEAD"

proc runAll*() =
  echo &"Advent of Code 2020. All days at #{githash}"
  let days = @[
    d01.run(),
    d02.run(),
    d03.run(),
    d04.run(),
    d05.run(),
    d06.run(),
    d07.run(),
  ]
  for day in days:
    echo &"Day {day.day}: {day.dur[3].pretty}"

when isMainModule:
  runAll()

#[
$ nim c -d:fast  src/day/all.nim && time out/run
Advent of Code 2020. All days at #1ae4e21
Day 01:   0s   0ms 165us  96ns
Day 02:   0s   0ms 607us 586ns
Day 03:   0s   0ms  92us 688ns
Day 04:   0s   1ms 202us 348ns
Day 05:   0s   0ms 518us 852ns
Day 06:   0s   0ms 455us 613ns

real    0m0.007s
user    0m0.004s
sys     0m0.002s
]#
