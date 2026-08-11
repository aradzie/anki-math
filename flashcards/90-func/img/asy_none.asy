// f(x) = (x^2-1)/(x-1) simplifies to x+1 for x != 1: the factor cancels,
// leaving a removable hole at (1,2) rather than a vertical asymptote, and
// the simplified function is itself a line, so it has no horizontal or
// oblique asymptote either.

import common;

size(8cm);
mathdefaults();

real xmin = -3, xmax = 4;

real f(real x) { return x + 1; }

drawAxes(xmin - 0.3, xmax + 0.3, f(xmin) - 0.5, f(xmax) + 0.5);

draw((xmin, f(xmin))--(1, f(1)), blue + linewidth(1.2));
draw((1, f(1))--(xmax, f(xmax)), blue + linewidth(1.2));
openPoint((1, 2), blue);
label("$y = x+1$", (xmax, f(xmax)), NW, blue);
label("$(1,2)$ excluded", (1, 2), SE, gray(0.4) + fontsize(8pt));
