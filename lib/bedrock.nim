
## This file is for miscellanious utilities.  It may import from the std libs or nimble libs, but from no local files.  It should contain generally useful procs, things that you potentially might have wished were in the std lib.
## Note that lots of things are in modules in the std lib, such as `reverse` and `reversed` which are in the `algorithms` std module. Try to be thorough in your search before you add something here.

import std/[macros, memfiles, monotimes, sequtils, sets,
  strformat, strutils, sugar, tables, times]

type
  SomeSeq*[T] = seq[T] or openarray[T] or string or cstring
  SomeTable*[U, V] = Table[U, V] or TableRef[U, V] or
    OrderedTable[U, V] or OrderedTableRef[U, V]
  SomeCountTable*[T] = CountTable[T] or CountTableRef[T]

proc square*(n: SomeNumber): SomeNumber = n * n

proc flip*[T, U](t: (T, U)): (U, T) {.inline.} =
  ## Take a two item tuple, and return a tuple of the items in reverse order
  (t[1], t[0])

proc spy*[T](t: T, msg = ""): T =
  # For when you want to echo something in the middle of a chain of proc calls.
  echo &"{msg}{$t}"
  return t

proc toString*[T](t: T): string {.inline.} =
  ## For when you want to turn something into a string in the middle of a chain of proc calls.
  $t

proc toSeqChar*(s: string): seq[char] = cast[seq[char]](s)

proc getOr*[T](s: openArray[T], i: int, def: T): T {.inline.} =
  ## GetOrDefault for openArrays
  if i < s.len: s[i] else: def

proc parseInt*(c: char): int = parseInt($c)

proc toBitSet*[T](s: openArray[T]): set[T] {.inline.} =
  for t in s:
    result.incl t

proc itemSeq*[T](t: SomeSeq[T]): seq[T] {.inline.} = toSeq(t.items)
proc mitemSeq*[T](t: var SomeSeq[T]): var seq[T] {.inline.} = toSeq(t.mitems)
proc pairSeq*[T](t: SomeSeq[T]): seq[(int, T)] {.inline.} = toSeq(t.pairs)
proc mpairSeq*[T](t: var SomeSeq[T]): seq[(int, var T)] {.inline.} = toSeq(t.mpairs)

proc keySeq*[U, V](t: SomeTable[U, V]): seq[U] {.inline.} = toSeq(t.keys)
proc valSeq*[U, V](t: SomeTable[U, V]): seq[V] {.inline.} = toSeq(t.values)
proc pairSeq*[U, V](t: SomeTable[U, V]): seq[(U, V)] {.inline.} = toSeq(t.pairs)
proc mvalSeq*[U, V](t: var SomeTable[U, V]): var seq[V] {.inline.} = toSeq(t.mvalues)
proc mpairSeq*[U, V](t: var SomeTable[U, V]): var seq[(U, V)] {.
    inline.} = toSeq(t.mpairs)

template toSeq*(src, iter: untyped): untyped =
  ## A two argument version of the toSeq template.  This exists to enable UFCS with toSeq.  This enables code like: `foo.bar.toSeq(pairs).sorted.baz`, whereas before it would have to be written like: `toSeq(foo.bar.pairs).sorted.baz`, which can feel clunky.
  runnableExamples:
    import sequtils
    let arr = [2, 4, 6, 8]
    assert arr.toSeq(pairs).mapit(it[1] - 1) == @[1, 3, 5, 7]
  toSeq(src.iter)

proc flatten*[T](ss: seq[seq[T]]): seq[T] =
  ## Take a seq of seq of T and return a seq of T.
  for s in ss:
    for t in s:
      result.add t

func between*(m, a, b: SomeNumber): bool =
  ## Is m between a and b (inclusive)?  Doesn't care about order of a or b. Remember if you know a<b, then you can just do "m in a..b".
  m >= min(a, b) and m <= max(a, b)

func bt*(m, a, b: SomeNumber): bool {.inline.} =
  ## Alias for `between`. Is m between a and b (inclusive)?  Doesn't care about order of a or b.  Remember if you know a<b, then you can just do "m in a..b".
  runnableExamples:
    let
      a = 10
      b = -5
    assert 5.bt(a, b)
    assert 5.bt(b, a)
    assert not 11.bt(a, b)
    assert not (-6).bt(a, b)
    assert 10.bt(a, b)
    assert 10.bt(b, a)
  m.between(a, b)

iterator countbetween*(a, b: int, step: int = 1): int =
  ## Iterate from a to b with an optional step size.  Note that this is for cases where you don't know until runtime whether a < b.  If you know that before, then you should use a.countup(b) or a.countdown(b) for better performance.  If provided, step should always be positive.
  runnableExamples:
    var
      x = 5
      s: seq[int] = @[]
    for i in 0.countbetween(x): s.add i
    x -= 10
    for i in 0.countbetween(x): s.add i
    for i in 0.countbetween(x, 2): s.add i
    assert s == @[0, 1, 2, 3, 4, 5, 0, -1, -2, -3, -4, -5, 0, -2, -4]
  let delta = step * cmp(b, a)
  var curr = a
  while curr.bt(a, b):
    yield curr
    curr += delta

proc clamp*[A: SomeNumber](v, min, max: A): A {.inline.} =
  return if v < min: min
    elif v > max: max
    else: v

proc clamp*[A: SomeNumber](v, max: A): A {.inline.} =
  return clamp(v, A.default, max)

proc wrap*[A: SomeNumber](v, min, max: A): A {.inline.} =
  return if v < min: v + (max - min)
    elif v >= max: v - (max - min)
    else: v

proc wrap*[A: SomeNumber](v, max: A): A {.inline.} =
  return wrap(v, A.default, max)

proc lerp*[A: SomeFloat](a, b, v: A): A =
  ## a and b are the endpoints, v is 0-1 the transition a -> b
  a * (1.0.A - v) + b * v

proc err*(msg = "Error!") =
  ## easy terse error
  raise newException(Exception, msg)

proc getlines*(path: string): seq[string] =
  var f = memfiles.open(path)
  defer: f.close
  for line in f.lines:
    result.add line

proc parselines*[T](path: string, cb: (string)->T): seq[T] =
  var f = memfiles.open(path)
  defer: f.close
  for line in f.lines:
    result.add line.cb

proc transpose*[T](ss: seq[seq[T]]): seq[seq[T]] =
  result = newSeqOfCap[seq[T]](ss[0].len)
  for i in 0..<ss[0].len:
    var row = newSeqOfCap[T](ss.len)
    for j in 0..<ss.len:
      row.add ss[j][i]
    result.add row

proc groupsOf*[T](s: seq[T], g: Positive): seq[seq[T]] =
  ## Chop a seq `s` into a seq of subseqs each of length `g` (the last one may be shorter)
  var
    sub = newSeqofCap[T](g)
    i = 0
  for t in s:
    sub.add t
    i += 1
    if i >= g:
      result.add sub
      sub = newSeqOfCap[T](g)
      i = 0
  if sub.len > 0: result.add sub

proc findb*[T](s: openArray[T], t: T): int =
  ## Find backwards: find the offset of the last instance of the item `t` in the sequence `s`.
  for i in countdown(s.high, 0):
    if s[i] == t: return i
  return -1

proc pmod*(v, m: int): int =
  ## Pythonic modulus.  The output will have the same sign as the divisor `m`.
  runnableExamples:
    assert 5.pmod(3) == 2 # same as 5 mod 3
    assert pmod(-5, 3) == 1 # -5 mod 3 would give -2
    assert 5.pmod(-3) == -1 # 5 mod -3 would give 2
    assert pmod(-5, -3) == -2 # same as 5 mod 3
  ((v mod m) + m) mod m

proc pdiv*(a, b: int): int =
  ## Pythonic integer division.  Nim will round towards zero whereas python will always round down.
  runnableExamples:
    assert 9.pdiv(2) == 4 # same as 9 div 2
    assert pdiv(-9, 2) == -5 # -9 div 2 would give -4
    assert 9.pdiv(-2) == -5 # 9 div -2 would give -4
  result = a div b
  if a*b < 0: result = result - 1

proc imod*(v, m: int): int =
  ## Multiplicative inverse in a given modulus.
  ## Find the value x such that (x * v) % m == 1
  ## Adapted from: https://bugs.python.org/issue36027
  runnableExamples:
    assert imod(138, 191) == 18
    assert imod(38, 191) == 186
    assert imod(23, 120) == 47
  var
    x, q = 0
    lastx = 1
    a = m
    b = v
  while b != 0:
    (a, q, b) = (b, a div b, a mod b)
    (x, lastx) = (lastx - q * x, x)
  result = (1 - lastx * m) div v
  if result < 0:
    result += m
  # assert result.bt(0,m)
  # assert result * v mod m == 1

proc pow*(x, y, m: int): int =
  ## Unoptimized implementation of modulus power
  runnableExamples:
    assert pow(3, 2, 4) == 1
    assert pow(10, 9, 6) == 4
    assert pow(450, 768, 517) == 34
  if y == 0: return 1
  var p = pow(x, y div 2, m) mod m
  p = (p * p) mod m
  return if (y and 1) == 0: p else: (x * p) mod m

template doit*(s: typed, op: untyped): untyped =
  ## Call side-effecting code with each item of a sequence.
  ## Like mapIt or apply, but the code must have no return value.
  runnableExamples:
    let t = @[3, 5]
    var v: seq[int] = @[]
    t.doit(v.add it)
    assert t == v
    # v.doit(it.echo)
  ##
  for it {.inject.} in items(s):
    op

when isMainModule:

  block:
    assert @[@[1, 2, 3], @[4, 5, 6]].flatten == @[1, 2, 3, 4, 5, 6]

  block:
    assert 5.pmod(3) == 2 # same as 5 mod 3
    assert pmod(-5, 3) == 1 # -5 mod 3 would give -2
    assert 5.pmod(-3) == -1 # 5 mod -3 would give 2
    assert pmod(-5, -3) == -2 # same as 5 mod 3

  block:
    assert 9.pdiv(2) == 4 # same as 9 div 2
    assert pdiv(-9, 2) == -5 # -9 div 2 would give -4
    assert 9.pdiv(-2) == -5 # 9 div -2 would give -4

  block:
    assert imod(138, 191) == 18
    assert imod(38, 191) == 186
    assert imod(23, 120) == 47

    assert pow(3, 2, 4) == 1
    assert pow(10, 9, 6) == 4
    assert pow(450, 768, 517) == 34

  block:
    let
      arr = [2, 4, 6, 8]
      tab = {'a': 10, 'b': -2, 'c': 5}.toTable
    assert arr.toSeq.mapit(it + 1) == @[3, 5, 7, 9]
    assert arr.toSeq(pairs).mapit(it[1] - 1) == @[1, 3, 5, 7]
    assert tab.toSeq(values).mapit(it + 100) == @[110, 98, 105]

  block:
    let
      a = 10
      b = -5
    assert 5.bt(a, b)
    assert 5.bt(b, a)
    assert not 11.bt(a, b)
    assert not (-6).bt(a, b)
    assert 10.bt(a, b)
    assert 10.bt(b, a)

  block:
    var
      x = 5
      s: seq[int] = @[]
    for i in 0.countbetween(x): s.add i
    x -= 10
    for i in 0.countbetween(x): s.add i
    for i in 0.countbetween(x, 2): s.add i
    assert s == @[0, 1, 2, 3, 4, 5, 0, -1, -2, -3, -4, -5, 0, -2, -4]

  block:
    let t = @[3, 5]
    var v: seq[int] = @[]
    t.doit(v.add it)
    assert t == v

  echo "bedrock asserts passed"

