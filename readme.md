
# Advent of Code 2020

[This repo](https://github.com/bobgeis/aoc2020) contains solutions for [Advent of Code 2020](https://adventofcode.com/2020) written in [nim](https://nim-lang.org/).

I probably won't have time to do all of the days. I definitely won't have time to do them all as they come out, but we'll see.

## Link

- [nim aoc 2020 thread](https://forum.nim-lang.org/t/7162)
- [aoc subreddit](https://old.reddit.com/r/adventofcode/)

## References

- [nim manual](https://nim-lang.org/docs/manual.html)
- [nim std lib](https://nim-lang.org/docs/lib.html)
- [nimscript](https://nim-lang.org/docs/nimscript.html)
- [nimble](https://nimble.directory/)
- [itertools](https://github.com/narimiran/itertools)
- [memo](https://github.com/andreaferretti/memo)
- [stint](https://github.com/status-im/nim-stint)

___

___

___

# SPOILERS BELOW

___

___

___

## d00

Generic setup. I haven't had time this year to learn a new programming language, so I'll be doing it in nim again.

I'm coding using vscode with [nim](https://marketplace.visualstudio.com/items?itemName=kosz78.nim) and [indent-rainbow](https://marketplace.visualstudio.com/items?itemName=oderwat.indent-rainbow) extensions. Plus some others, but those two are nim-specific.

I've included a 'lib' of code I found useful last year. `aocutils` has some utility procs for dealing with this particular repo (finding data files for each day, etc). `bedrock` is a misc utilities file that has requirement that it import nothing else from this repo. It's the "bottom". `vecna` is a bunch of convenience functions for working with vectors (eg: x,y[,z] coordinates) which happens a lot in aoc. It makes vectors of "N" values of "A" type. `graphwalk` is a very generic implementation of BFS and Djikstra's algorithm. Because I got tired of re-implementing them. `shenanigans` is for experimentation, weird macros, and causing trouble.

For nimble packages, the `stint` package is vital for dealing with very large ints. `memo` and `itertools` are sometimes very helpful and convenient.

## d01

[Link](https://adventofcode.com/2020/day/1)

Straightfoward arithmetic. Probably some room for optimization but brute force works. Starts off easy, as is tradition.

I tried a couple ways of improving it: using indices instead of full for..in loops. This made things noticeably faster. Then I tried using algorithms.binarySearch. Surprisingly it made part 1 take about ~3 times longer, but it was so fast to start with, that that's not a big deal. What was more surprising, is that it made part 2 take the about the same amount of time as part 1 (within noise) XD

After that I tried sorting everything at read time and made the discovery that with my input, things run drastically faster when sorted! This sort of makes sense given that for my particular input, the vast majority of integers are >1010, so sorting them actually makes something that should be O(n^2) or worse act like something closer to O(n). Trying other people's inputs didn't give quite as drastic a speedup. Next I tried deferring the echo/output until after the timing of the calculation was complete. Some timings are in the codefile.

```
$ nim c --gc:arc -d:danger --opt:speed src/day/d01.nim && time out/runme
Day01

running my input
Read file and sort in 159 microseconds and 239 nanoseconds
Part1 is 1018944 in 1 microsecond and 337 nanoseconds
Part2 is 8446464 in 236 nanoseconds
Part1binary is 1018944 in 313 nanoseconds
Part2binary is 8446464 in 201 nanoseconds

running other's input
Read file and sort in 96 microseconds and 80 nanoseconds
Part1 is 840324 in 3 microseconds and 175 nanoseconds
Part2 is 170098110 in 46 microseconds and 633 nanoseconds
Part1binary is 840324 in 440 nanoseconds
Part2binary is 170098110 in 17 microseconds and 44 nanoseconds

real    0m0.004s
user    0m0.001s
sys     0m0.001s
```


## d02
[Link](https://adventofcode.com/2020/day/2)

Straightforward logic, but now we're parsing a more complicated input file.

Strangely, removing the defer:doAssert from `part1()` and `part2()` made things _slower!_ I suspect this is due to some poor interaction between defer and my timing template.

```
$ nim c --gc:arc -d:danger --opt:speed src/day/d02.nim && time out/run

Day02 at #1957146
Read file and parse in 392 microseconds and 509 nanoseconds
Part1 is 569 in 22 microseconds and 486 nanoseconds
Part2 is 346 in 5 microseconds and 965 nanoseconds

real    0m0.004s
user    0m0.001s
sys     0m0.001s
```

<!-- ## d03 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d04 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d05 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d06 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d07 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d08 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d09 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d10 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d11 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d12 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d13 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d14 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d15 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d16 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d17 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d18 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d19 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d20 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d21 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d22 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d23 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d24 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->


<!-- ## d25 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->
<!-- NOT DONE -->

