// Oblique asymptote: f(x) = (x^2+1)/x = x + 1/x tends to the line y = x as
// x -> +-infinity. (The vertical asymptote at x = 0 is incidental to this
// particular example, not a feature of oblique asymptotes in general.)

import graph;

size(12cm, 8cm);
defaultpen(fontsize(10pt));

real xmin = -5, xmax = 5;
real ymax = 5;
real eps = 0.2;

real f(real x) { return x + 1/x; }

// axes
draw((xmin - 0.3, 0)--(xmax + 0.3, 0), Arrow(TeXHead));
draw((0, -ymax - 0.5)--(0, ymax + 0.5), Arrow(TeXHead));
label("$x$", (xmax + 0.3, 0), E);
label("$y$", (0, ymax + 0.5), N);

// oblique asymptote y = x
draw((xmin - 0.3, xmin - 0.3)--(xmax + 0.3, xmax + 0.3), dashed + gray(0.5));
label("$y = x$", (xmax + 0.3, xmax + 0.3), NE, gray(0.5));

// two branches, one on each side of the pole at x = 0
draw(graph(f, eps, xmax), blue + linewidth(1.2));
draw(graph(f, xmin, -eps), blue + linewidth(1.2));
label("$y = \frac{x^2+1}{x}$", (3.5, f(3.5)), N, blue);

// clip(currentpicture, box((xmin - 0.5, -ymax - 0.5), (xmax + 0.5, ymax + 0.5)));
