
## This files useful for this advent of code repo.  The classic example is getting the input file.

import std/[strformat]

const
  inputDir = "data"

proc inputFilePath*(day: string): string =
  &"{inputDir}/i{day}.txt"

proc inputTestFilePath*(day: string, test: int): string =
  &"{inputDir}/i{day}t{test}.txt"
