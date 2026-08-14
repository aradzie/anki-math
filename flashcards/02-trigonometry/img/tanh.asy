// tanh(x) = sinh(x)/cosh(x): odd, bounded in (-1,1), with horizontal
// asymptotes y = 1 and y = -1 as x -> +-infinity.

import graph;
import common;

size(14cm, 10cm, false);
mathdefaults();

real xmin = -3.2, xmax = 3.2;
real ymax = 1.5;

real sinhx(real x) { return (exp(x) - exp(-x)) / 2; }
real coshx(real x) { return (exp(x) + exp(-x)) / 2; }
real f(real x) { return sinhx(x) / coshx(x); }

drawAxes(xmin, xmax, -ymax, ymax);

// horizontal asymptotes
draw((xmin, 1)--(xmax, 1), gray + dashed);
draw((xmin, -1)--(xmax, -1), gray + dashed);
label("$y=1$", (xmax, 1), NW, gray);
label("$y=-1$", (xmax, -1), SW, gray);

draw(graph(f, xmin, xmax), blue + linewidth(1.3));
label("$\tanh x$", (1.5, f(1.5)), SE, blue);
