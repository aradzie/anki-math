// The same formula f(x) = x^2, judged against two different declared
// codomains. Left: codomain R -- the range [0,infinity) (thick red) is a
// strict subset, so f is not surjective. Right: codomain [0,infinity) --
// the y-axis is only ever drawn for y >= 0, and the range fills it
// completely, so f is surjective.

import graph;
import common;

size(11cm, 6cm);
texpreamble("\usepackage{amssymb}");
mathdefaults();

real xmin = -2.3, xmax = 2.3;
real ymax = 4.6;

real f(real x) { return x^2; }

// panel A: codomain R
drawAxes(xmin, xmax, -1, ymax);
draw(graph(f, -2.15, 2.15), blue + linewidth(1.2));
draw((0, 0)--(0, ymax - 0.4), red + linewidth(2.5));
closedPoint((0, 0), red);
label("codomain $=\mathbb{R}$: not surjective", (0, -1.4), red);

// panel B: codomain [0, infinity)
real ox = 7;
real g(real x) { return (x - ox)^2; }

drawAxes(ox - 2.3, ox + 2.3, 0, ymax, originx=ox);
draw(graph(g, ox - 2.15, ox + 2.15), blue + linewidth(1.2));
draw((ox, 0)--(ox, ymax - 0.4), red + linewidth(2.5));
closedPoint((ox, 0), red);
label("codomain $=[0,\infty)$: surjective", (ox, -0.4), red);
