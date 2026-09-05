// f : [0,infinity) -> [0,infinity), f(x) = x^2, restricted to x >= 0.
// Injective: the horizontal line y=1 meets the graph only once, at x=1.
// Surjective: the range [0,infinity) fills the whole declared codomain,
// shown as the domain (orange) and range (red) overlays each covering
// their whole axis with no excluded part.

import graph;
import common;

size(9cm);
texpreamble("\usepackage{amssymb}");
mathdefaults();

real xmin = -0.6, xmax = 2.4;
real ymin = -0.6, ymax = 5.0;
real testY = 1;

real f(real x) { return x^2; }

drawAxes(xmin, xmax, ymin, ymax);

draw((0, testY)--(xmax, testY), dashed + gray(0.5));
draw(graph(f, 0, 2.15), blue + linewidth(1.2));
label("$y = x^2$", (1.9, f(1.9)), W, blue);

closedPoint((1, testY), deepgreen);
label("injective", (1, testY), NE, deepgreen);

draw((0, 0)--(xmax, 0), orange + linewidth(2.5));
draw((0, 0)--(0, ymax - 0.4), red + linewidth(2.5));
closedPoint((0, 0), red);
label("domain $=[0,\infty)$", (xmax, 0), S, orange);
label("range $=[0,\infty)$", (0, ymax - 0.4), E, red);

label("$f : [0,\infty) \to [0,\infty)$ is bijective", (0.9, ymin - 0.2));
