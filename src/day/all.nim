
## run all the days in sequence
## nim c --gc:arc -d:danger --opt:speed src/day/all.nim && time out/run

import std/[
  strformat
]

import lib/[aocutils]

import d01, d02, d03, d04, d05, d06

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
  ]
  for day in days:
    echo &"Day {day.day}: {day.dur[3].pretty}"

when isMainModule:
  runAll()