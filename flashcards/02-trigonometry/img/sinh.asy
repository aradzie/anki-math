// sinh(x) = e^x/2 - e^{-x}/2, decomposed into two dashed gray exponential
// halves. The labeled arrow at x0 shows adding the second half onto the
// first lands exactly on sinh(x0), demonstrating the sum.

import graph;
import common;

size(14cm, 12cm, false);
mathdefaults();

real xmin = -2.4, xmax = 2.4;
real ymax = 5.4;

real half1(real x) { return exp(x) / 2; }
real half2(real x) { return -exp(-x) / 2; }
real sinhx(real x) { return half1(x) + half2(x); }

drawAxes(xmin, xmax, -ymax, ymax);

// exponential halves
draw(graph(half1, xmin, xmax), gray + dashed);
draw(graph(half2, xmin, xmax), gray + dashed);
label("$e^{x}/2$", (xmin + 0.3, half1(xmin + 0.3)), N, gray);
label("$-e^{-x}/2$", (xmax - 0.3, half2(xmax - 0.3)), S, gray);

// sinh, as their sum
draw(graph(sinhx, xmin, xmax), blue + linewidth(1.3));
label("$\sinh x$", (2, sinhx(2)), NW, blue);

// vertical addition at x0: e^{x0}/2 plus (-e^{-x0}/2) lands on sinh(x0)
real x0 = 0.7;
pair p1 = (x0, half1(x0));
pair p2 = (x0, sinhx(x0));
draw(p1--p2, gray(0.4), Arrow(TeXHead));
label("$-e^{-x_0}/2$", (p1 + p2) / 2, SE, gray(0.4));
dot(p1, gray(0.4));
dot(p2, blue);
dropToXAxis(p2);
label("$x_0$", (x0, 0), S);
