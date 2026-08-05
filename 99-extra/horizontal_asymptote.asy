// Horizontal asymptote: f(x) = arctan(x) tends to the constant pi/2 as
// x -> +infinity and to -pi/2 as x -> -infinity, giving two horizontal
// asymptotes, one in each direction.

import graph;

size(12cm, 6cm);
defaultpen(fontsize(10pt));

real xmin = -6, xmax = 6;
real ymax = 2.2;

real f(real x) { return atan(x); }

// axes
draw((xmin - 0.3, 0)--(xmax + 0.3, 0), Arrow(TeXHead));
draw((0, -ymax - 0.3)--(0, ymax + 0.3), Arrow(TeXHead));
label("$x$", (xmax + 0.3, 0), E);
label("$y$", (0, ymax + 0.3), N);

// horizontal asymptotes y = ±pi/2
draw((xmin - 0.3, pi/2)--(xmax + 0.3, pi/2), dashed + gray(0.5));
draw((xmin - 0.3, -pi/2)--(xmax + 0.3, -pi/2), dashed + gray(0.5));
label("$y = \pi/2$", (xmax + 0.3, pi/2), NE, gray(0.5));
label("$y = -\pi/2$", (xmax + 0.3, -pi/2), SE, gray(0.5));

draw(graph(f, xmin, xmax), blue + linewidth(1.2));
label("$y = \arctan x$", (3, f(3)), N, blue);

// clip(currentpicture, box((xmin - 0.5, -ymax - 0.5), (xmax + 0.5, ymax + 0.5)));
