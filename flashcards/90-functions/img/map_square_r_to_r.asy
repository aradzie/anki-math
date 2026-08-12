// f : R -> R, f(x) = x^2. Not injective: the horizontal line y=1 meets the
// graph twice, at x = -1 and x = 1. Not surjective: only y >= 0 (thick red)
// is ever attained on the y-axis, leaving the negative half of the
// declared codomain R (thin) untouched.

import graph;
import common;

size(9cm);
texpreamble("\usepackage{amssymb}");
mathdefaults();

real xmin = -2.2, xmax = 2.2;
real ymin = -1.2, ymax = 5.0;
real testY = 1;

real f(real x) { return x^2; }

drawAxes(xmin, xmax, ymin, ymax);

draw((xmin, testY)--(xmax, testY), dashed + gray(0.5));
draw(graph(f, -2.15, 2.15), blue + linewidth(1.2));
label("$y = x^2$", (1.7, f(1.7)), E, blue);

closedPoint((-1, testY), red);
closedPoint((1, testY), red);
label("not injective", (0, testY), N, red);

draw((0, 0)--(0, ymax - 0.4), red + linewidth(2.5));
closedPoint((0, 0), red);
label("range $=[0,\infty)$", (0, ymax - 0.4), E, red);

label("$f : \mathbb{R} \to \mathbb{R}$ is neither injective nor surjective", (0, ymin - 0.4));
