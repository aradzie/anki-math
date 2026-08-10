// Infinite (essential) discontinuity: f(x) = 1/x is undefined at x = 0,
// and neither one-sided limit is finite there -- the left branch dives to
// -infinity, the right branch climbs to +infinity, giving a vertical
// asymptote rather than a hole or a jump.

import graph;
import common;

size(12cm, 12cm);
mathdefaults();

real f(real x) { return 1 / x; }

real xmax = 3;
real ymax = 3;
real eps = 0.28; // stay clear of the pole at x = 0

// axes
drawAxes(-xmax - 0.3, xmax + 0.3, -ymax - 0.7, ymax + 0.7);

// vertical asymptote x = 0
draw((0, -ymax - 0.5)--(0, ymax + 0.5), dashed + gray(0.5));

// two branches, one on each side of the pole
draw(graph(f, -xmax, -eps), blue + linewidth(1.2));
draw(graph(f, eps, xmax), blue + linewidth(1.2));
label("$f(x)=\dfrac{1}{x}$", (2, f(2)), NE, blue);

label("$\lim_{x\to 0^+} f(x) = +\infty$", (1.0, ymax - 0.7), N, red);
label("$\lim_{x\to 0^-} f(x) = -\infty$", (-1.0, -ymax + 0.7), S, red);
