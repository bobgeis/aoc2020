
## run all the days in sequence
## nim c --gc:arc -d:danger --opt:speed src/day/all.nim && time out/run

import std/[
  strformat
]

import d01, d02, d03

const githash = staticexec "git rev-parse --short HEAD"

proc runAll*() =
  echo &"All days at #{githash}"
  echo ""
  d01.run()
  echo ""
  d02.run()
  echo ""
  d03.run()

when isMainModule:
  runAll()