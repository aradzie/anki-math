// Removable discontinuity: f(x) = (x^2-1)/(x-1) simplifies to x+1 for
// x != 1, so both one-sided limits at x = 1 exist, are finite, and agree
// -- but f(1) itself is undefined, leaving a hole exactly where the curve
// "should" pass through.

import graph;
import common;

size(12cm, 10cm);
mathdefaults();

real c = 1, L = 2;
real f(real x) { return x + 1; }

real xmin = -1, xmax = 3;
real ymin = -1, ymax = 4;
real eps = 0.06; // stay clear of the hole at x = c

// axes
drawAxes(xmin, xmax, ymin, ymax);

// curve, broken around the hole
draw(graph(f, xmin, c - eps), blue + linewidth(1.2));
draw(graph(f, c + eps, xmax), blue + linewidth(1.2));
label("$f(x)=\dfrac{x^2-1}{x-1}$", (2.1, f(2.1)), NW, blue);

// guides to the hole
dropToXAxis((c, L));
dropToYAxis((c, L));
label("$1$", (c, 0), S);
label("$2$", (0, L), W);

// the hole itself: limit exists and equals 2, but f(1) is undefined
openPoint((c, L), red);
label("$\lim_{x\to 1} f(x) = 2$", (c - 0.05, L + 0.55), N, red);
label("$f(1)\text{ undefined}$", (c + 0.9, L - 0.6), red);
