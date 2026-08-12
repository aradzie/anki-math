// f(x) = sin(x)/x has horizontal asymptote y = 0, yet crosses it at every
// nonzero multiple of pi -- an asymptote only describes end behavior, not
// that the graph avoids the line elsewhere.

import graph;
import common;

size(18cm, 12cm);
mathdefaults();

real xmin = -8, xmax = 8;
real ymin = -0.4, ymax = 1.3;

real f(real x) { return x == 0 ? 1 : sin(x) / x; }

drawAxes(xmin - 0.3, xmax + 0.3, ymin, ymax);
label("$y=0$", (7, -0.2), gray(0.4));

draw(graph(f, xmin, xmax, n=600), blue + linewidth(1.2));
label("$y = \sin x / x$", (1.7, f(1.7)), NE, blue);

// crossings at x = k*pi, k != 0
for (int k = -2; k <= 2; ++k) {
    if (k != 0) closedPoint((k * pi, 0), red, 0.07);
}
