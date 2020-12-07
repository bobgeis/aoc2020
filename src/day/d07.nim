
## solution for aoc 2020 day 07
## https://adventofcode.com/2020/day/7

# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ algorithm, deques, math, memfiles, options, os, parsecsv, parseutils, sequtils, sets, strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, vecna]

const
  day = "07"
  inPath = inputPath(day)
  testPath = inputPath("07t1")
  checkpart1 = {
    inpath:119,
    testPath:4,
    }.toTable
  checkpart2 = {
    inpath:155802,
    testPath:32,
    }.toTable

const
  myBag = "shiny gold"

type
  Bag = Table[string,int]
  BagTab = Table[string,Bag]

proc scanline(s:string, contains,containedby: var BagTab) =
  var
    b,contents:string
    tab = initTable[string,int]()
  if s.scanf("$+ bags contain $+",b,contents):
    if b notin containedby:
      containedby[b] = initTable[string,int]()
    for content in contents.split(", "):
      var
        num:int
        name:string
      if content.scanf("$i $+ bag",num,name):
        tab[name] = num
        if name notin containedby:
          containedby[name] = initTable[string,int]()
        containedby[name][b] = num
      elif content == "no other bags.": discard
      else: err &"Could not scanf content: '{content}'"
    contains[b] = tab
  else: err &"Could not scanline: '{s}'"

proc part0*(path:string): (BagTab,BagTab) =
  var
    contains = initTable[string,Bag]()
    containedby = initTable[string,Bag]()
  for line in path.getLines:
    line.scanline(contains,containedby)
  return (contains,containedby)

proc part1*(input:(BagTab,BagTab)): int =
  let bt = input[1]
  proc adjs(s:string):seq[string] =
    toSeq(bt[s].keys)
  bfs(mybag,adjs).len - 1 # - 1 because mybag doesn't contain itself

proc part2*(input:(BagTab,BagTab)): int =
  let bt = input[0]
  var
    q = @[(mybag,1)]
    visited = initHashSet[string]()
    count = 0
  while q.len > 0:
    [name, num] ..= q.pop
    visited.incl name
    count += num
    q.add toSeq(bt[name].pairs).mapit((it[0],it[1]*num))
  return count - 1 # - 1 because mybag doesn't contain itself

makeRunProc()

when isMainModule:
  getCliPaths(default=inPath).doit(it.run.echoRR)

#[
  Compiler commands:
```sh
export DAY="src/day/d07.nim"
nim r $DAY
nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
nim check --warnings:on --hints:on $DAY
nim r --gc:arc --hints:on --warnings:on -d:danger --opt:speed $DAY
```
]#
