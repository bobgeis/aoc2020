import lib/[imps]
const
  day = "21"
  inPath = inputPath(day)
  testPath = inputPath(day,"t1")

inpath.part1is 2493
# inpath.part2is 2 # kqv,jxx,zzt,dklgl,pmvfzk,tsnkknk,qdlpbt,tlgrhdh
testPath.part1is 5
# testPath.part2is 2 # kqv,jxx,zzt,dklgl,pmvfzk,tsnkknk,qdlpbt,tlgrhdh

proc part0*(path: string): (CountTable[string],Table[string,HashSet[string]]) =
  var
    itab = initCountTable[string]()
    atab = initTable[string,HashSet[string]]()
  for line in path.getLines:
    var
      ingreds:seq[string] = @[]
      allergens: seq[string] = @[]
    let parts = line.split(" (contains ")
    for ingr in parts[0].split(" "):
      ingreds.add ingr
      itab.inc(ingr)
    let iset = ingreds.toHashSet
    for allr in parts[1][0..^2].split(", "):
      allergens.add allr
      if allr notin atab: atab[allr] = iset
      else:
        atab[allr] = intersection(atab[allr],iset)
  var changed = true
  while changed:
    changed = false
    for allr,ings in atab.pairs:
      if ings.len == 1:
        for a,i in atab.mpairs:
          if a != allr and not disjoint(ings,i):
            i.excl ings
            changed = true
  (itab,atab)

proc part1*(input: (CountTable[string],Table[string,HashSet[string]])): int =
  var allrings = initHashSet[string]()
  for ings in input[1].values:
    allrings.incl ings
  for ing,cnt in input[0].pairs:
    if ing notin allrings: result.inc cnt

proc sortproc(x,y:(string,string)):int = cmp(x[0],y[0])

proc part2*(input: (CountTable[string],Table[string,HashSet[string]])): int =
  var allrseq: seq[(string,string)] = @[]
  for allr,ings in input[1].pairs:
    for i in ings: allrseq.add (allr,i)
  allrseq.sort(sortproc)
  let answ = allrseq.mapit(it[1]).join(",")
  # debug answ
  result = 0

makeRunProc()
when isMainModule: getCliPaths(day).doit(it.run.echoRR)

