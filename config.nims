
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

--gc:arc # swap in --gc:orc if you get leaks
switch("path",nimSrc)
switch("out",&"{nimOutDir}/run")
hint("Processing", false)
hint("Conf",false)
switch("hints","off")
switch("warnings","off")
switch("verbosity", "0")

if defined(fast):
  --d:release
  --d:danger
  --opt:speed
  --passC:"-flto"
  --passL:"-flto"

if defined(check):
  --hints:on
  --warnings:on

proc excho(cmd:string) =
  echo cmd
  exec cmd

task cleanout, "delete the out dir":
  excho &"rm -rf {nimOutDir}"

