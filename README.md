# TROLL ALL THE ROFLSCALERS

I don't in any way endorse the benchmarks contained in this repository.

The only reason this fork exists is to provide some demonstrations to the
original authors.

The patches made to the benchmarks in the fork-local commits are functionally
equivalent faster / interesting variants and/or more accurate scenarios,
depending on the case.

It's really important not to do this kind of "this or that" style stuff and
ecourage people to memorize it. As seen in the local changes, trying to have the
same semantic impact (e.g. generate the same output / generate same inner-loop
method calls) can lead to significantly better solutions. Corpus' like this give
people EVEN MORE excuses to stop thinking about what their runtime is doing,
instead they'll think "oh yeah, map! is faster for this kind of case" BZZZT.
WRONG.

I made no attempt to fix the fact that none of these benchmarks assert
correctness (I asserted correctness of most of my impls), and I also made no
attempt to address the general problem of input size, unrelated allocations,
etc. in a general way. *All benchmarks contained herein will mislead you, and
you should ignore all benchmark output as a form of comparison of these
"vs"*. If you just want to see some stupid tricks, then some of the changes
might educate you, but again, none of the stupid tricks are entirely portable to
other scenarios, they're just common ones I use for *TROLLING* *ROFLSCALERS*

## License

![CC-BY-SA](CC-BY-SA.png)

This work is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/).


## Code License

### CC0 1.0 Universal

To the extent possible under law, @JuanitoFatas has waived all copyright and related or neighboring rights to "fast-ruby".

This work belongs to the community.
