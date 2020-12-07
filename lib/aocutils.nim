
## This files useful for this advent of code repo.  The classic example is getting the input file.

import std/[monotimes,os,sequtils,strformat,strutils,times]

import lib/[bedrock, timetemple]

const
  inputDir* = "in"
  githash* = staticexec "git rev-parse --short HEAD"

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

type
  RunResult* = tuple
    day: string
    path: string
    res: array[2,int]
    dur: array[4,Duration]

template makeRunProc*():untyped =
  proc run*(path:string=inPath):RunResult =
    timevar durall:
      timevar dur0:
        let input = part0(path)
      var res1:int
      timevar dur1:
        res1 = part1(input)
      var res2:int
      timevar dur2:
        res2 = part2(input)
      if path in checkpart1:
        check checkpart1[path] == res1
      if path in checkpart2:
        check checkpart2[path] == res2
    return (day:day,path:path,res:[res1,res2],dur:[dur0,dur1,dur2,durAll])

proc pretty*(d:Duration):string =
  let parts = d.toParts
  # we aren't going to wait longer than a minute (I hope)
  const units = ["ns","us","ms","s","m"]
  for i in Nanoseconds..Seconds:
    result = &"{parts[i]:>3}{units[i.ord]} {result}"
  if parts[Minutes] > 0:
    result = &"{parts[Minutes]:>3}{units[Minutes.ord]} {result}"

proc echoRR*(rr:RunResult) =
  echo &"Day {rr.day} at {githash} for {rr.path}"
  echo &"Part1: {rr.res[0]}"
  echo &"Part2: {rr.res[1]}"
  when defined(fast):
    echo "Times:"
    echo &"Part0: {rr.dur[0].pretty}"
    echo &"Part1: {rr.dur[1].pretty}"
    echo &"Part2: {rr.dur[2].pretty}"
    echo &"Total: {rr.dur[3].pretty}"

