// A = {-1/n : n in N}. sup A = 0, but 0 is not in A, so A has no maximum.

import graph;

texpreamble("\usepackage{amssymb}");

size(20cm, 5cm);
defaultpen(fontsize(10pt));

real xmin = -5.5;
real xmax = 1;

draw((xmin, 0)--(xmax, 0), Arrows(TeXHead));

// spacing compressed for legibility, not to true numeric scale
real scale = 5;
for (int n = 1; n <= 35; ++n) {
  real x = -scale / n;
  filldraw(circle((x, 0), 0.07), blue);
}
label("$-1$", (-scale, -0.1), S);
label("$-\frac12$", (-scale / 2, -0.1), S);
label("$-\frac13$", (-scale / 3, -0.1), S);
label("$-\frac14$", (-scale / 4, -0.1), S);
label("$A = \{-1/n : n \in \mathbb{N}\}$", (-2.5, 0.5), N, blue);

// the gap: 0, sup A but not attained
draw((0, 0)--(0, 0.5), red + dashed);
filldraw(circle((0, 0), 0.07), white, red);
label("$\sup A = 0 \notin A$", (0, 0.5), N, red);
