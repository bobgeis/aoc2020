
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

<!-- ## d02 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d03 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d04 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d05 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d06 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d07 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d08 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d09 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d10 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d11 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d12 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d13 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d14 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d15 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d16 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d17 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d18 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d19 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d20 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->



<!-- ## d21 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d22 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d23 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d24 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->


<!-- ## d25 -->
<!-- [Link](https://adventofcode.com/2020/day/1) -->

