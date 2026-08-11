// f(x) = sqrt(x-1): domain [1, infinity) is overlaid in orange on the
// x-axis, range [0, infinity) in red on the y-axis, each starting at a
// closed point since both endpoints are attained. The dotted segment ties
// the domain's left endpoint back to the range's left endpoint, i.e.
// f(1) = 0.

import graph;
import common;

size(9cm);
texpreamble("\usepackage{amssymb}");
mathdefaults();

real xmin = -0.2, xmax = 6.2;
real ymin = -0.2, ymaxPlot = 2.8;

real f(real x) { return sqrt(x - 1); }

drawAxes(xmin, xmax, ymin, ymaxPlot);

draw(graph(f, 1, xmax - 0.3), blue + linewidth(1.2));
label("$y = \sqrt{x-1}$", (xmax - 0.3, f(xmax - 0.3)), NW, blue);

// domain overlay on the x-axis: [1, infinity)
draw((1, 0)--(xmax - 0.3, 0), orange + linewidth(2.5));
closedPoint((1, 0), orange);
label("$1$", (1, 0), S);

// range overlay on the y-axis: [0, infinity)
draw((0, 0)--(0, ymaxPlot - 0.4), red + linewidth(2.5));
closedPoint((0, 0), red);

label("domain $= [1,\infty)$", (3.5, ymin - 0.5), N, orange);
label("range $= [0,\infty)$", (3.5, ymin - 0.5), S, red);
