// csch(x) = 1/sinh(x): odd, with a vertical asymptote at x = 0 (where
// sinh vanishes) and a horizontal asymptote y = 0 as x -> +-infinity.

import graph;
import common;

size(14cm, 12cm, false);
mathdefaults();

real xmin = -3.2, xmax = 3.2;
real ymax = 4.2;
real eps = 0.25; // gap around the pole at x = 0

real sinhx(real x) { return (exp(x) - exp(-x)) / 2; }
real f(real x) { return 1 / sinhx(x); }

drawAxes(xmin, xmax, -ymax, ymax);

// vertical asymptote x = 0
draw((0, -ymax)--(0, ymax), dashed + gray(0.5));

// two branches, one on each side of the pole
draw(graph(f, eps, xmax), blue + linewidth(1.3));
draw(graph(f, xmin, -eps), blue + linewidth(1.3));
label("$\operatorname{csch} x$", (1.7, f(1.7)), NE, blue);
