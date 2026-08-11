// f(x) = x^2: domain and codomain are both R, but only y >= 0 is ever
// attained. The thin y-axis below 0 stands for the declared codomain R;
// the thick red overlay on y >= 0 marks the actual range [0, infinity).

import graph;
import common;

size(9cm);
texpreamble("\usepackage{amssymb}");
mathdefaults();

real xmin = -2.4, xmax = 2.4;
real ymin = -0.2, ymax = 4.6;

real f(real x) { return x^2; }

drawAxes(xmin, xmax, ymin, ymax);

draw(graph(f, -2.15, 2.15), blue + linewidth(1.2));
label("$y = x^2$", (2.15, f(2.15)), NW, blue);

// range overlay: y in [0, ymax) is attained, drawn thick over the y-axis
draw((0, 0)--(0, ymax - 0.3), red + linewidth(2.5));
closedPoint((0, 0), red);

label("domain $= \mathbb{R}$", (0, ymin - 0.5), N);
label("range $= [0,\infty)$", (0, ymin - 0.5), S, red);
