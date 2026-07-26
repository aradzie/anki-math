// Graph of y = coth(x) = cosh(x)/sinh(x): odd, undefined at x = 0. The
// y-axis (x = 0) is a vertical asymptote, and y = ±1 are horizontal
// asymptotes as x -> +-infty.

import graph;

size(9cm);
defaultpen(fontsize(10pt));

real xmin = -3, xmax = 3;
real ymax = 3;
real eps = 0.15; // stay clear of the pole at x = 0

real f(real x) { return cosh(x) / sinh(x); }

// axes
draw((xmin - 0.3, 0)--(xmax + 0.3, 0), Arrow(TeXHead));
draw((0, -ymax - 0.5)--(0, ymax + 0.5), Arrow(TeXHead));
label("$x$", (xmax + 0.3, 0), E);
label("$y$", (0, ymax + 0.5), N);

// horizontal asymptotes y = ±1
draw((xmin - 0.3, 1)--(xmax + 0.3, 1), dashed + gray(0.5));
draw((xmin - 0.3, -1)--(xmax + 0.3, -1), dashed + gray(0.5));
label("$y = 1$", (xmax + 0.3, 1), NE, gray(0.5));
label("$y = -1$", (xmax + 0.3, -1), SE, gray(0.5));

// vertical asymptote x = 0 coincides with the y-axis
label("$x = 0$", (0.3, ymax + 0.2), gray(0.5));

// two branches, one on each side of the pole
draw(graph(f, eps, xmax), blue + linewidth(1.2));
draw(graph(f, xmin, -eps), blue + linewidth(1.2));
label("$y = \coth x$", (0.6, f(0.6)), N, blue);

clip(currentpicture, box((xmin - 0.5, -ymax - 0.5), (xmax + 0.5, ymax + 0.5)));
