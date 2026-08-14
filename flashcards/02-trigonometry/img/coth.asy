// coth(x) = cosh(x)/sinh(x): odd, with a vertical asymptote at x = 0
// (where sinh vanishes) and horizontal asymptotes y = 1 and y = -1 as
// x -> +-infinity.

import graph;
import common;

size(14cm, 10cm, false);
mathdefaults();

real xmin = -3.2, xmax = 3.2;
real ymax = 5.4;
real eps = 0.2; // gap around the pole at x = 0

real sinhx(real x) { return (exp(x) - exp(-x)) / 2; }
real coshx(real x) { return (exp(x) + exp(-x)) / 2; }
real f(real x) { return coshx(x) / sinhx(x); }

drawAxes(xmin, xmax, -ymax, ymax);

// vertical asymptote x = 0
draw((0, -ymax)--(0, ymax), dashed + gray(0.5));

// horizontal asymptotes
draw((xmin, 1)--(xmax, 1), gray + dashed);
draw((xmin, -1)--(xmax, -1), gray + dashed);
label("$y=1$", (xmax, 1), NW, gray);
label("$y=-1$", (xmax, -1), SW, gray);

// two branches, one on each side of the pole
draw(graph(f, eps, xmax), blue + linewidth(1.3));
draw(graph(f, xmin, -eps), blue + linewidth(1.3));
label("$\coth x$", (1, f(1)), NE, blue);
