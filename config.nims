## This exists primarily to play with nimscript,
## but it's also a good place to put helper tasks.
##
## Reference: https://nim-lang.org/docs/nimscript.html
##
## For more ideas, see https://github.com/kaushalmodi/nim_config/blob/master/config.nims

import std/[os, strformat, strutils, sequtils]

const
  nimDayDir = "day"
  nimLibDir = "lib"
  nimTestDir = "test"
  nimDirs = @[nimDayDir,nimLibDir,nimTestDir]
  nimOutDir = "out"
  nimDocDir = "doc"

switch("path", ".")
switch("out", &"{nimOutDir}/run")
hint("Processing", false)
hint("Conf", false)
switch("hints", "off")
switch("warnings", "off")
switch("verbosity", "0")

--gc: arc # swap in --gc:orc if you get leaks

proc setFast() =
  --d: fast
  --d: release
  --d: danger
  --opt: speed
  --passC: "-flto"
  --passL: "-flto"

if defined(fast):
  setFast()

proc setCheck() =
  --d: check
  --hints: on
  --warnings: on

if defined(check):
  setCheck()

proc findNimFile(f:string):string =
  if f.fileExists: return f
  for dir in nimDirs:
    if fileExists(&"{dir}/{f}.nim"): return &"{dir}/{f}.nim"
    if fileExists(&"{dir}/d{f}.nim"): return &"{dir}/d{f}.nim"
  echo &"Could not find a .nim file matching `{f}`."
  return ""

proc parseArgs():(seq[string],seq[string]) =
  for i in 2..paramCount():
    if paramStr(i)[0] == '-':
      result[0].add paramstr(i)
    else:
      result[1].add paramstr(i)

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

task docs, "generate code doc":
  --project
  switch("out",nimDocdir)
  setCommand("doc")

task dc, "Compile a day. eg: `nim dc 01`":
  let
    (switches,args) = parseArgs()
    path = args[0].findNimFile
    switchStr = switches.join(" ")
  if path.len > 0: excho &"nim c {switchStr} {path}"

task dcf, "Compile(opt:speed) a day. eg: `nim dcf 01`":
  let
    (switches,args) = parseArgs()
    path = args[0].findNimFile
    switchStr = switches.join(" ")
  if path.len > 0: excho &"nim c {switchStr} -d:fast {path}"

task dr, "Compile and run a day. eg: `nim dr 01`":
  let
    (switches,args) = parseArgs()
    path = args[0].findNimFile
    switchStr = switches.join(" ")
    argsStr = args[1..args.high].join(" ")
  if path.len > 0: excho &"nim r {switchStr} {path} {argsStr}"

task drf, "Compile(opt:speed) and run a day. eg: `nim drf 01`":
  let
    (switches,args) = parseArgs()
    path = args[0].findNimFile
    switchStr = switches.join(" ")
    argsStr = args[1..args.high].join(" ")
  if path.len > 0: excho &"nim r {switchStr} -d:fast {path} {argsStr}"

task dt, "Compile(opt:speed) and time a day. eg `nim dt 01`":
  dcfTask()
  excho &"time out/run"
