// Illustrates the cusp of the semicubical parabola r(t) = <t^2, t^3> at t=0,
// where r'(0) = 0 and the curve fails to be regular.

import graph;
import common;

size(8cm, 8cm);
mathdefaults();

real xfun(real t) { return t^2; }
real yfun(real t) { return t^3; }

real t = 1.3;
path curve = graph(xfun, yfun, -t, t);

drawAxes(-0.6, 2.3, -2.6, 2.6);
draw(curve, blue + linewidth(1.2));
closedPoint((0, 0));

label("$\mathbf{r}(t) = \langle t^2, t^3 \rangle$", (xfun(t), yfun(t)), NW, blue);
label("cusp at $t=0$", (0, 0), SW);
