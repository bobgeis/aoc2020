
## this exists primarily to play with nimscript,
## but it's also a good place to put helper tasks
## https://nim-lang.org/docs/nimscript.html

import std/[strformat, strutils, parseutils]
from os import splitFile
from parseutils import parseInt

const
  nimSrc = "src"
  nimDirs = ["day", "lib", "test"]
  nimDayDir = &"{nimSrc}/day"
  nimLibDir = &"{nimSrc}/lib"
  nimOutDir = "out"
  nimDocDir = "doc"

  fastOn = "-d:danger -d:release --opt:speed "
  secretOn = "_secret"
  arcOn = "--gc:arc "
  orcOn = "--gc:orc "
  verboseOn = "--warnings=on "
  veryVerboseOn = "--hints=on --warnings=on "
  # veryVerboseOn = "--hints=on --warnings=on --verbosity=3" # let's not go crazy

var
  fast = ""
  secret = ""
  gc = ""
  verbose = ""

proc setFast() = fast =  fastOn
proc setSecret() = secret = secretOn
proc setArc() = gc = arcOn
proc setOrc() = gc = orcOn
proc setVerbose() = verbose = verboseOn
proc setVeryVerbose() = verbose = veryVerboseOn


switch("path",nimSrc)
hint("Processing", false)
hint("Conf",false)
switch("hints","off")
switch("warnings","off")
switch("verbosity", "0")
switch("out",&"{nimOutDir}/run")

proc excho(cmd:string) =
  echo cmd
  exec cmd

proc selfexcho(cmd:string) =
  echo &"nim[self] {cmd}"
  selfexec cmd

task cleanout, "delete the out dir":
  excho &"rm -rf {nimOutDir}"

task day, "build and run the given day(s), usage: `nim day 1 2 3 -f`":
  echo "day"
  var days:seq[int] = @[]
  for i in 2..paramCount(): # exclude path to bin and word "day"
    let arg = paramStr(i)
    var num:int;
    if parseInt(arg,num) == 0:
      case arg
      of "-f","--fast": setFast()
      of "-s","--secret": setSecret()
      of "-a","--arc": setArc()
      of "-o","--orc": setOrc()
      of "-v","--verbose": setVerbose()
      of "--vv","--veryverbose": setVeryVerbose()
    else:
      days.add num
  for day in days:
    let
      inputFile = &"{nimDayDir}/d{day:02}{secret}.nim"
      outputFile = &"{nimOutDir}/d{day:02}"
    if fast == fastOn:
      selfexcho &"c {fast}{gc}{verbose}-o:{outputFile} {inputFile}"
      excho &"time ./{outputFile}"
    else:
      selfexcho &"c -r {fast}{gc}{verbose}-o:{outputFile} {inputFile}"

