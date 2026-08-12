// f(x) = (x^2+1)/x = x + 1/x has both a vertical asymptote x = 0 (pole)
// and an oblique asymptote y = x (since 1/x -> 0 as x -> +-infinity); no
// horizontal asymptote.

import graph;
import common;

size(12cm, 8cm);
mathdefaults();

real xmin = -5, xmax = 5;
real ymax = 5;
real eps = 0.2;

real f(real x) { return x + 1/x; }

drawAxes(xmin - 0.3, xmax + 0.3, -ymax - 0.5, ymax + 0.5);

// oblique asymptote y = x
draw((xmin - 0.3, xmin - 0.3)--(xmax + 0.3, xmax + 0.3), dashed + gray(0.5));
label("$y = x$", (xmax, xmax), NW, gray(0.5));

// vertical asymptote x = 0
draw((0, -ymax - 0.3)--(0, ymax + 0.3), dashed + gray(0.5));
label("$x = 0$", (0, ymax), NW, gray(0.5));

draw(graph(f, eps, xmax), blue + linewidth(1.2));
draw(graph(f, xmin, -eps), blue + linewidth(1.2));
label("$y = \frac{x^2+1}{x}$", (3.5, f(3.5)), NW, blue);
