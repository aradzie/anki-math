// The horizontal line test: a function is injective iff every horizontal
// line meets its graph at most once. Left panel: a line, one crossing.
// Right panel: a parabola, two crossings.

import graph;
import common;

size(11cm, 5cm);
mathdefaults();

real ymin = -0.5, ymax = 3.2;
real testY = 1;

// panel 1: y = x, injective
real xminA = -2.5, xmaxA = 2.5;
real f1(real x) { return x; }

drawAxes(xminA, xmaxA, ymin, ymax, xlabel="", ylabel="");
draw((xminA, testY)--(xmaxA, testY), dashed + gray(0.5));
draw(graph(f1, xminA, xmaxA), blue + linewidth(1.2));
closedPoint((testY, testY), deepgreen);
label("injective: passes", ((xminA + xmaxA) / 2, ymin - 0.4), deepgreen);

// panel 2: y = (x - ox)^2, not injective
real ox = 8;
real xminB = ox - 2.5, xmaxB = ox + 2.5;
real f2(real x) { return (x - ox)^2; }

drawAxes(xminB, xmaxB, ymin, ymax, xlabel="", ylabel="", originx=ox);
draw((xminB, testY)--(xmaxB, testY), dashed + gray(0.5));
draw(graph(f2, xminB, xmaxB), blue + linewidth(1.2));
closedPoint((ox - 1, testY), red);
closedPoint((ox + 1, testY), red);
label("not injective: fails", ((xminB + xmaxB) / 2, ymin - 0.4), red);
