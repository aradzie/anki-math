// Graph of y = tanh(x) = sinh(x)/cosh(x): odd, through the origin, with
// horizontal asymptotes y = 1 (as x -> +infty) and y = -1 (as x -> -infty).

import graph;

size(9cm);
defaultpen(fontsize(10pt));

real xmin = -3.5, xmax = 3.5;

real f(real x) { return tanh(x); }

// axes
draw((xmin - 0.3, 0)--(xmax + 0.3, 0), Arrow(TeXHead));
draw((0, -1.6)--(0, 1.6), Arrow(TeXHead));
label("$x$", (xmax + 0.3, 0), E);
label("$y$", (0, 1.6), N);

// horizontal asymptotes
draw((xmin - 0.3, 1)--(xmax + 0.3, 1), dashed + gray(0.5));
draw((xmin - 0.3, -1)--(xmax + 0.3, -1), dashed + gray(0.5));
label("$y = 1$", (xmax + 0.3, 1), NE, gray(0.5));
label("$y = -1$", (xmax + 0.3, -1), SE, gray(0.5));

// curve
draw(graph(f, xmin, xmax), blue + linewidth(1.2));
label("$y = \tanh x$", (1.6, f(1.6)), N, blue);

// origin
dot("$(0,0)$", (0, 0), SE);
