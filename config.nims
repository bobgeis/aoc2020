## this exists primarily to play with nimscript,
## but it's also a good place to put helper tasks
## https://nim-lang.org/docs/nimscript.html
import std/[os, strformat, strutils, sequtils]

const
  nimDayDir = "day"
  nimLibDir = "lib"
  nimOutDir = "out"
  nimDocDir = "doc"

switch("path", ".")
switch("out", &"{nimOutDir}/run")
hint("Processing", false)
hint("Conf", false)
switch("hints", "off")
switch("warnings", "off")
switch("verbosity", "0")

if defined(fast):
  --gc: arc # swap in --gc:orc if you get leaks
  --d: release
  --d: danger
  --opt: speed
  --passC: "-flto"
  --passL: "-flto"

if defined(check):
  --hints: on
  --warnings: on

proc excho(cmd: string) =
  echo cmd
  exec cmd

task cleanout, "empty the out dir":
  excho &"rm -rf {nimOutDir}"
  excho &"mkdir out"

task cleandoc, "empty the doc dir":
  excho &"rm -rf {nimDocDir}"
  excho &"mkdir doc"

task prettyall, "nimpretty all the code":
  for file in gorge("find . -type f -name *.nim").split:
    excho &"nimpretty --indent=2 {file}"

task prettyallr, "nimpretty all using walkdirrec":
  for file in walkDirRec(".", {pcFile, pcDir}):
    if file.splitFile().ext == ".nim":
      excho &"nimpretty --indent=2 {file}"
