// The right branch of the unit hyperbola x^2 - y^2 = 1, traced out by
// t -> (cosh t, sinh t). A sample point at parameter t0 is marked with
// dashed guides down to its coordinates, showing they are literally
// cosh(t0) and sinh(t0) -- the identity cosh^2 t - sinh^2 t = 1 is exactly
// why every such point lands on the curve.

import graph;
import common;

size(11cm, 9cm);
mathdefaults();

real xmin = -0.4, xmax = 3.6;
real ymax = 3.2;

real tmin = -1.85, tmax = 1.85;

drawAxes(xmin, xmax, -ymax, ymax);

// asymptotes y = +-x, characteristic of the hyperbola's shape; capped at
// ymax so their far ends don't stretch the frame beyond the y-axis extent
real aLen = min(xmax, ymax);
draw((0, 0)--(aLen, aLen), gray + dashed);
draw((0, 0)--(aLen, -aLen), gray + dashed);
label("$y=x$", (aLen, aLen), NW, gray);
label("$y=-x$", (aLen, -aLen), SW, gray);

// right branch, traced parametrically by t -> (cosh t, sinh t)
guide branch;
int n = 100;
for (int i = 0; i <= n; ++i) {
    real t = tmin + (tmax - tmin) * i / n;
    pair pt = (cosh(t), sinh(t));
    branch = (i == 0) ? pt : branch--pt;
}
draw(branch, blue + linewidth(1.3));
label("$x^2-y^2=1$", (cosh(1.4), sinh(1.4)), NW, blue);

// vertex at t = 0
dot((1, 0), black);
label("$(1,0)$", (1, 0), SW);

// sample point at parameter t0
real t0 = 1.2;
pair p0 = (cosh(t0), sinh(t0));
dropToXAxis(p0);
dropToYAxis(p0);
dot(p0, blue);
label("$(\cosh t_0,\sinh t_0)$", p0, SE);
label("$\cosh t_0$", (p0.x, 0), S);
label("$\sinh t_0$", (0, p0.y), W);
