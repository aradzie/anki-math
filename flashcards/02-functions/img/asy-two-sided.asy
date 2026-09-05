// f(x) = sqrt(x^2+1) has different oblique asymptotes in each direction:
// y = x as x -> +infinity, y = -x as x -> -infinity.

import graph;
import common;

size(9cm);
mathdefaults();

real xmin = -5, xmax = 5;
real ymax = 5.6, ymin = -5.6;

real f(real x) { return sqrt(x^2 + 1); }

drawAxes(xmin - 0.3, xmax + 0.3, ymin, ymax);

draw((xmin - 0.3, xmin - 0.3)--(xmax + 0.3, xmax + 0.3), dashed + gray(0.5));
label("$y=x$", (xmax + 0.3, xmax + 0.3), NW, gray(0.5));

draw((xmin - 0.3, -(xmin - 0.3))--(xmax + 0.3, -(xmax + 0.3)), dashed + gray(0.5));
label("$y=-x$", (xmin - 0.3, -(xmin - 0.3)), NE, gray(0.5));

draw(graph(f, xmin, xmax), blue + linewidth(1.2));
label("$y = \sqrt{x^2+1}$", (4, f(4)), NW, blue);
