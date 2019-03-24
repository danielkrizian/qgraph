# Utilities for hierarchical and graph structures

## Nested lists and dictionaries (trees)

It is easier to work with vectors than nested lists or dictionaries.
Functions `.tree.list`,`.tree.dict`, `.tree.dir` will flatten infinitely nested lists,dictionaries and directories, respectively, into table containing parent vector, names and values. Function `.tree.t099` will flatten *both* nested lists (type `0h`) within dictionaries (type `99h`) or vice versa.

Function `.tree.nest` will take the table representation as the argument and return the original nested structure. This is useful when we can take advantage of bulk manipulation of the node names,values or hierarchy in the flat format and when we are done, convert back to the nested representation.

```q
q) show j:.j.k raze read0 `:test/fixtures/test.json
array  | (1f;"HiFromArray";3f)
boolean| 1b
color  | "#82b92c"
null   | 0n
number | 123f
string | "HelloWorld"
object | `a`c`g!(,"b";`d`e!(1f;,"f");,"h")


q) show t:.tree.t099 j     / unnest into flat table of (p)arent vector, (n)ame and (v)alue of each branch and leaf
p  n        v
---------------------------------------------------------------------------------
   " "      `array`boolean`color`null`number`string`object!(();();();();();();())
0  `array   (();();())
0  `boolean 1b
0  `color   "#82b92c"
0  `null    0n
0  `number  123f
0  `string  "HelloWorld"
0  `object  `a`c`g!(();();())
1  0        1f
1  1        "HiFromArray"
1  2        3f
7  `a       ,"b"
7  `c       `d`e!(();())
7  `g       ,"h"
12 `d       1f
12 `e       ,"f"

q) j~.tree.nest t     / nest back to original structure if needed
1b
```
