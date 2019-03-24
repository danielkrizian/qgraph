.tst.desc["Nested dictionaries/directories"]{
  before{
    `nestDict mock ("aa";"bb";"cc")!(
      ("bb";"cc";"dd")!(1;2 3;4);
      42;
      (("ee";"ff")!(5 6)));
    `nestDir mock `a`b`c!(
      `d`e`f!1 2 3;
      `g`h!(`i`j!4 5;6);
      7);
    `dict mock enlist[()]!enlist(::);              / dictionary placeholder
    };
  should["flatten"]{
    n:.tree.nest t:.tree.dir nestDict;
    0N 0 0 0 1 1 1 3 3 mustmatch t[;`p];           / parent vector; i.e. parent 0 has three children at positions 1 2 3
    (dict;dict;42;dict;1;2 3;4;5;6) mustmatch t[`v];
    1 musteq n["aa";"bb"];
    };
  should["nest"]{
    `a set .tree.nest .tree.dir nestDir;
    a.b.g.i musteq 4;
    };
  };

.tst.desc["Nested general lists"]{
  before{
    `nestList mock (1 2 3;(4;5 6));
    `t mock .tree.list nestList;
    };
  should["flatten"]{
    0N 0 0 2 2 mustmatch t[;`p];                   / parent vector
    ((();());
     1 2 3;
     (();());
     4;
     5 6) mustmatch t[;`v];
    };
  should["nest"]{
    nestList mustmatch .tree.nest t;
    };
  };

.tst.desc["JSON nested objects and arrays"]{
  before{
    p:(` vs .tst.tstPath)[0],`fixtures`test.json;
    `jsonfile mock raze read0 ` sv p;
    `t mock .tree.t099 .j.k jsonfile;
    };
  should["flatten"]{
    t[;`p] mustmatch 0N 0 0 0 0 0 0 0 1 1 1 7 7 7 12 12;
    };
  should["nest back to original"]{
    n:.j.j .tree.nest t;
    n mustmatch ssr[jsonfile;" ";""];
    };
  };