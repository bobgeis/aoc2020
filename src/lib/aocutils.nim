
## This files useful for this advent of code repo.  The classic example is getting the input file.

import std/[sequtils,strformat,strutils]

import lib/[bedrock]

const
  inputDir = "data"

proc inputFilePath*(day: string): string =
  &"{inputDir}/i{day}.txt"

proc inputTestFilePath*(day: string, test: int): string =
  &"{inputDir}/i{day}t{test}.txt"

proc readIntLines*(path:string):seq[int] =
  ## for reading in a text file of ints separated by newlines
  path.getlines.map(parseInt)
