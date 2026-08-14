// The hyperbolic sector swept from (1,0) to (cosh t0, sinh t0) on the right
// branch of x^2-y^2=1: bounded by the two straight radii from the origin
// and the hyperbola arc between them. Its area is t0/2, so t0 is twice the
// shaded area -- the hyperbolic angle.

import graph;
import common;

size(11cm, 9cm);
mathdefaults();

real xmin = -0.4, xmax = 3.0;
real ymax = 2.6;

real t0 = 1.2;
real tmin = -1.6, tmax = 1.6;

real coshx(real t) { return cosh(t); }
real sinhx(real t) { return sinh(t); }

drawAxes(xmin, xmax, -ymax, ymax);

// asymptotes y = +-x, characteristic of the hyperbola's shape; capped at
// ymax so their far ends don't stretch the frame beyond the y-axis extent
real aLen = min(xmax, ymax);
draw((0, 0)--(aLen, aLen), gray + dashed);
draw((0, 0)--(aLen, -aLen), gray + dashed);
label("$y=x$", (aLen, aLen), NW, gray);
label("$y=-x$", (aLen, -aLen), SW, gray);

// full right branch, for context
guide branch;
int n = 100;
for (int i = 0; i <= n; ++i) {
    real t = tmin + (tmax - tmin) * i / n;
    pair pt = (coshx(t), sinhx(t));
    branch = (i == 0) ? pt : branch--pt;
}
draw(branch, blue + linewidth(1.1));

// shaded sector: origin -> (1,0) -> arc up to (cosh t0, sinh t0) -> origin
guide sector = (0, 0)--(1, 0);
int m = 60;
for (int i = 0; i <= m; ++i) {
    real t = t0 * i / m;
    sector = sector--(coshx(t), sinhx(t));
}
sector = sector--cycle;
fill(sector, orange + opacity(0.3));
draw(sector, orange + linewidth(0.9));

label("$\dfrac{t_0}{2}$", (1.55, 0.55), orange);

// endpoints of the sector
dot((1, 0), black);
label("$(1,0)$", (1, 0), SW);

pair p0 = (coshx(t0), sinhx(t0));
dot(p0, blue);
label("$(\cosh t_0,\sinh t_0)$", p0, SE);
