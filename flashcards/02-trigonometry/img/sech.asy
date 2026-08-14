// sech(x) = 1/cosh(x): even, bounded above by 1 (attained at x = 0), with
// a horizontal asymptote y = 0 as x -> +-infinity.

import graph;
import common;

size(14cm, 8cm, false);
mathdefaults();

real xmin = -3.2, xmax = 3.2;
real ymax = 1.3;

real coshx(real x) { return (exp(x) + exp(-x)) / 2; }
real f(real x) { return 1 / coshx(x); }

drawAxes(xmin, xmax, -0.3, ymax);

draw(graph(f, xmin, xmax), blue + linewidth(1.3));
label("$\operatorname{sech} x$", (1.3, f(1.3)), NE, blue);

label("$1$", (0, 1), W);
