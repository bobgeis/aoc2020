
## This files useful for this advent of code repo.  The classic example is getting the input file.

import std/[os,sequtils,strformat,strutils]

import lib/[bedrock]

const
  inputDir = "in"

proc inputPath*(day: string): string = &"{inputDir}/i{day}.txt"

proc getCliPaths*(default:string):seq[string] =
  if paramCount() == 0: result.add default
  for arg in commandLineParams():
    if arg.fileExists:
      result.add arg
    elif arg.inputPath.fileExists:
      result.add arg.inputPath
    else:
      echo &"Could not find file for {arg} or {arg.inputPath}"

proc readIntLines*(path:string):seq[int] =
  ## for reading in a text file of ints separated by newlines
  path.getlines.map(parseInt)
