
import strformat, strutils, parseutils
from os import splitFile
from parseutils import parseInt

const
  nimSrc = "src"
  nimDirs = ["day", "lib", "test"]
  nimDayDir = &"{nimSrc}/day"
  nimLibDir = &"{nimSrc}/lib"
  nimOutDir = "out"
  nimDocDir = "doc"

  fastOn = "-d:danger -d:release --opt:speed"
  secretOn = "_secret"

var
  fast = ""
  secret = ""

proc setFast(goFast=true) = fast = if goFast: fastOn else: ""

proc setSecret(goSecret=true) = secret = if goSecret: secretOn else: ""

switch("path",nimSrc)

proc echoex(cmd:string) =
  echo cmd
  exec cmd

task cleanout, "delete the out dir":
  echoex &"rm -rf {nimOutDir}"

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
    else:
      days.add num
  for day in days:
    let
      inputFile = &"{nimDayDir}/d{day:02}{secret}.nim"
      outputFile = &"{nimOutDir}/d{day:02}"
    echoex &"nim c {fast} -o:{outputFile} {inputFile}"
    echoex &"time ./{outputFile}"
