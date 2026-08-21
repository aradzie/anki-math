// A = {-1/n : n in N}. sup A = 0, but 0 is not in A, so A has no maximum.

import graph;
import common;

texpreamble("\usepackage{amssymb}");

size(20cm, 5cm);
mathdefaults();

real xmin = -5.5;
real xmax = 1;

numberLine(xmin, xmax, true);

// spacing compressed for legibility, not to true numeric scale
real scale = 5;
for (int n = 1; n <= 35; ++n) {
  real x = -scale / n;
  closedPoint((x, 0), r=0.07);
}
label("$-1$", (-scale, -0.1), S);
label("$-\frac12$", (-scale / 2, -0.1), S);
label("$-\frac13$", (-scale / 3, -0.1), S);
label("$-\frac14$", (-scale / 4, -0.1), S);
label("$A = \{-1/n : n \in \mathbb{N}\}$", (-2.5, 0.5), N, blue);

// the gap: 0, sup A but not attained
draw((0, 0)--(0, 0.5), red + dashed);
openPoint((0, 0), red, 0.07);
label("$\sup A = 0 \notin A$", (0, 0.5), N, red);
