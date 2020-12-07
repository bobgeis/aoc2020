
# std lib modules: https://nim-lang.org/docs/lib.html
import std/[ algorithm, deques, math, memfiles, options, os, parsecsv, parseutils, sequtils, sets, strformat, strscans, strtabs, strutils, sugar, tables, unittest]

# nimble pkgs: https://nimble.directory/
import pkg/[itertools, memo, stint]

# local lib modules: src/lib/
import lib/[aocutils, bedrock, graphwalk, shenanigans, timetemple, vecna]


export algorithm, deques, math, memfiles, options, os, parsecsv, parseutils, sequtils, sets, strformat, strscans, strtabs, strutils, sugar, tables, unittest

export itertools, memo, stint

export aocutils, bedrock, graphwalk, shenanigans, timetemple, vecna
