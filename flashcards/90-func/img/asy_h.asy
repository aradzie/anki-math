// Horizontal asymptote: f(x) = arctan(x) tends to the constant pi/2 as
// x -> +infinity and to -pi/2 as x -> -infinity, giving two horizontal
// asymptotes, one in each direction.

import graph;
import common;

size(12cm, 6cm);
mathdefaults();

real xmin = -6, xmax = 6;
real ymax = 2.2;

real f(real x) { return atan(x); }

// axes
drawAxes(xmin - 0.3, xmax + 0.3, -ymax - 0.3, ymax + 0.3);

// horizontal asymptotes y = ±pi/2
draw((xmin - 0.3, pi/2)--(xmax + 0.3, pi/2), dashed + gray(0.5));
draw((xmin - 0.3, -pi/2)--(xmax + 0.3, -pi/2), dashed + gray(0.5));
label("$y = \pi/2$", (xmax + 0.3, pi/2), E, gray(0.5));
label("$y = -\pi/2$", (xmax + 0.3, -pi/2), E, gray(0.5));

draw(graph(f, xmin, xmax), blue + linewidth(1.2));
label("$y = \arctan x$", (3, f(3)), SE, blue);

// clip(currentpicture, box((xmin - 0.5, -ymax - 0.5), (xmax + 0.5, ymax + 0.5)));
