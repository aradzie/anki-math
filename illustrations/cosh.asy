// Graph of y = cosh(x) = (e^x + e^{-x}) / 2: even, with minimum (0, 1),
// and no asymptotes (it grows without bound in both directions).

import graph;

size(9cm);
defaultpen(fontsize(10pt));

real xmin = -2.2, xmax = 2.2;

real f(real x) { return cosh(x); }

real ytop = f(xmax);

// axes
draw((xmin - 0.3, 0)--(xmax + 0.3, 0), Arrow(TeXHead));
draw((0, -0.5)--(0, ytop + 0.5), Arrow(TeXHead));
label("$x$", (xmax + 0.3, 0), E);
label("$y$", (0, ytop + 0.5), N);

// curve
draw(graph(f, xmin, xmax), blue + linewidth(1.2));
label("$y = \cosh x$", (xmax - 0.3, f(xmax - 0.3)), NW, blue);

// minimum point
dot("$(0, 1)$", (0, 1), SE);
