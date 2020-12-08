
# Advent of Code 2020

[This repo](https://github.com/bobgeis/aoc2020) contains solutions for [Advent of Code 2020](https://adventofcode.com/2020) written in [nim](https://nim-lang.org/).

I probably won't have time to do all of the days. I definitely won't have time to do them all as they come out, but we'll see.

## Link

- [nim aoc 2020 thread](https://forum.nim-lang.org/t/7162)
- [aoc subreddit](https://old.reddit.com/r/adventofcode/)

## References

- [nim compiler](https://nim-lang.org/docs/nimc.html)
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

## d03
[Link](https://adventofcode.com/2020/day/3)

Not too complicated, just need to move across the grid and count trees. Part 2 can re-use the function from part 1 if you make the slope an argument.

```
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run

Day03 for in/i03.txt
Read file in 126 microseconds and 892 nanoseconds
Part1 is 278 in 1 microsecond and 874 nanoseconds
Part2 is 9709761600 in 6 microseconds and 517 nanoseconds

real    0m0.004s
user    0m0.001s
sys     0m0.001s
```

## d04
[Link](https://adventofcode.com/2020/day/4)

The parsing is more complicated but otherwise straightforward.

There's a version of the split proc that lets you split on a string, so a string of two newlines `input.split("\n\n")` got you a seq of passports. Then to get key-value pairs you can split on a character set of space and newline `s.split({' ','\n'})`, or on whitespace `s.splitWhitespace`, and then split again on colon. At that point I used parseint, scanf, or iterating over characters.

Initially I thought that we were going to do something more complicated with the passports, so I put them into an object type. Of course we just care if they're valid or not XD Later I used a template to reduce some repetition.

```
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run

Day04 for in/i04.txt
Read file in 174 microseconds and 43 nanoseconds
Part1 is 182 in 404 microseconds and 558 nanoseconds
Part2 is 109 in 345 microseconds and 443 nanoseconds

real    0m0.004s
user    0m0.002s
sys     0m0.001s
```

## d05
[Link](https://adventofcode.com/2020/day/5)

Another one where the parsing is the more complicated part. Basically we're being given unsorted binary numbers, but represented with 'B','F','L', and 'R'. They're in a single long one with on gap. For part 1 we have to find the highest, and for part 2 we have to find the one that's missing.

I took an easy but suboptimal method: I used multiReplace to swap all the letters out for ones or zeroes, then used parseBin, then sorted the result. After that it was easy to look at the last index and then run through the seq and find the missing number.

```
$ nim c --gc:arc -d:danger --opt:speed $DAY && time out/run
Day 05 at 0279e48 for in/i05.txt
Part1: 835
Part2: 649
Times:
Part0:   0s   0ms 346us 972ns
Part1:   0s   0ms   0us  67ns
Part2:   0s   0ms   0us 506ns
Total:   0s   0ms 359us 405ns

real    0m0.004s
user    0m0.001s
sys     0m0.001s
```

## d06
[Link](https://adventofcode.com/2020/day/6)

This day was a good opportunity to use nim's bitsets (system.set). At first I used the toBitSet proc in my lib, but then realized it was making character sets, when they just needed to be 'a'..'z' (which is much smaller). At the same time, I realized I was making a lot more strings than I needed. So I refactored one function to scan through a string of an entire "group" and make a seq of sets out of them. There's still one extra round of string allocation that I could come and look at again later.

```
$ nim c -d:fast src/day/d06.nim && time out/run
Day 06 at 963d09d for in/i06.txt
Part1: 6506
Part2: 3243
Times:
Part0:   0s   0ms 447us 170ns
Part1:   0s   0ms   9us 735ns
Part2:   0s   0ms   8us  94ns
Total:   0s   0ms 481us 673ns

real    0m0.004s
user    0m0.001s
sys     0m0.001s
```

## d07
[Link](https://adventofcode.com/2020/day/7)

This is the slowest day so far by a wide margin. Almost all the time is spent in part0 (parsing and processing common to part1 and part2). This is probably due to reading the input multiple times (once to split by lines, twice to split the bagname from what it contains, and then again to parse those into keys in a table or add to a seq). There's lots of room for improvement here.

After that, part1 and part2 are just graphwalks. Part1 could be improved upon, part2 is pretty quick!

```
$ nim c -d:fast day/d07.nim && time out/run
Day 07 at #19c33d0 for in/i07.txt
Part1: 119
Part2: 155802
Times:
Part0:   0s   2ms 545us 787ns
Part1:   0s   0ms 934us  38ns
Part2:   0s   0ms  47us 465ns
Total:   0s   3ms 543us 642ns

real    0m0.009s
user    0m0.005s
sys     0m0.002s
```


## d08
[Link](https://adventofcode.com/2020/day/8)

Oo a "Handheld Game Console". This could be this year's analogue to last year's intcode machines. It's premature to put it into its own lib, but that will probably happen if we see more of it.

Part 1 is fast: run it and watch for an infinite loop. My implementation of part 2 is simple but not very fast. There's room to do something smarter there.

```
$ nim c -d:fast day/d08.nim && time out/run
Day 08 at #19c33d0 for in/i08.txt
Part1: 1217
Part2: 501
Times:
Part0:   0s   0ms 361us 962ns
Part1:   0s   0ms  53us 515ns
Part2:   0s   5ms 737us 390ns
Total:   0s   6ms 159us 965ns

real    0m0.010s
user    0m0.007s
sys     0m0.002s
```


<!-- ## d09 -->
<!-- [Link](https://adventofcode.com/2020/day/9) -->
<!-- NOT DONE -->


<!-- ## d10 -->
<!-- [Link](https://adventofcode.com/2020/day/10) -->
<!-- NOT DONE -->


<!-- ## d11 -->
<!-- [Link](https://adventofcode.com/2020/day/11) -->
<!-- NOT DONE -->


<!-- ## d12 -->
<!-- [Link](https://adventofcode.com/2020/day/12) -->
<!-- NOT DONE -->


<!-- ## d13 -->
<!-- [Link](https://adventofcode.com/2020/day/13) -->
<!-- NOT DONE -->


<!-- ## d14 -->
<!-- [Link](https://adventofcode.com/2020/day/14) -->
<!-- NOT DONE -->


<!-- ## d15 -->
<!-- [Link](https://adventofcode.com/2020/day/15) -->
<!-- NOT DONE -->


<!-- ## d16 -->
<!-- [Link](https://adventofcode.com/2020/day/16) -->
<!-- NOT DONE -->


<!-- ## d17 -->
<!-- [Link](https://adventofcode.com/2020/day/17) -->
<!-- NOT DONE -->


<!-- ## d18 -->
<!-- [Link](https://adventofcode.com/2020/day/18) -->
<!-- NOT DONE -->


<!-- ## d19 -->
<!-- [Link](https://adventofcode.com/2020/day/19) -->
<!-- NOT DONE -->


<!-- ## d20 -->
<!-- [Link](https://adventofcode.com/2020/day/20) -->
<!-- NOT DONE -->


<!-- ## d21 -->
<!-- [Link](https://adventofcode.com/2020/day/21) -->
<!-- NOT DONE -->


<!-- ## d22 -->
<!-- [Link](https://adventofcode.com/2020/day/22) -->
<!-- NOT DONE -->


<!-- ## d23 -->
<!-- [Link](https://adventofcode.com/2020/day/23) -->
<!-- NOT DONE -->


<!-- ## d24 -->
<!-- [Link](https://adventofcode.com/2020/day/24) -->
<!-- NOT DONE -->


<!-- ## d25 -->
<!-- [Link](https://adventofcode.com/2020/day/25) -->
<!-- NOT DONE -->

