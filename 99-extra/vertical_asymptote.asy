// Vertical asymptote: f(x) = 1/(x-2) is undefined at x = 2 and blows up to
// +-infinity as x approaches 2 from the right/left, giving the vertical
// asymptote x = 2.

import graph;

size(9cm);
defaultpen(fontsize(10pt));

real xmin = -1, xmax = 5;
real ymax = 4;
real eps = 0.23; // stay clear of the pole at x = 2

real f(real x) { return 1 / (x - 2); }

// axes
draw((xmin - 0.3, 0)--(xmax + 0.3, 0), Arrow(TeXHead));
draw((0, -ymax - 0.5)--(0, ymax + 0.5), Arrow(TeXHead));
label("$x$", (xmax + 0.3, 0), E);
label("$y$", (0, ymax + 0.5), N);

// vertical asymptote x = 2
draw((2, -ymax - 0.3)--(2, ymax + 0.3), dashed + gray(0.5));
label("$x = 2$", (2, ymax + 0.3), N, gray(0.5));
label("$2$", (2, 0), S);

// two branches, one on each side of the pole
draw(graph(f, xmin, 2 - eps), blue + linewidth(1.2));
draw(graph(f, 2 + eps, xmax), blue + linewidth(1.2));
label("$y = \frac{1}{x-2}$", (3.3, f(3.3)), NE, blue);

// clip(currentpicture, box((xmin - 0.5, -ymax - 0.5), (xmax + 0.5, ymax + 0.5)));
