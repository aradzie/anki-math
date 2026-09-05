// The right branch of x^2-y^2=1 in the x,y-plane, with the u,v coordinate
// directions overlaid: the u-axis runs along y=x (where v=x-y=0) and the
// v-axis along y=-x (where u=x+y=0). In these directions the hyperbola's
// equation becomes uv=1.

import common;

size(11cm, 9cm);
mathdefaults();

real xmin = -0.4, xmax = 2.6;
real ymax = 2.2;

real tmin = -1.4, tmax = 1.4;

draw((xmin, 0)--(xmax, 0), Arrow(TeXHead));
draw((0, -ymax)--(0, ymax), Arrow(TeXHead));
label("$x$", (xmax, 0), E);
label("$y$", (0, ymax), N);

// u,v axis directions, aligned with the asymptotes y=x and y=-x
real aLen = min(xmax, ymax);
draw((0, 0)--(aLen, aLen), heavygreen + dashed, Arrow(TeXHead));
draw((0, 0)--(aLen, -aLen), heavyred + dashed, Arrow(TeXHead));
label("$u$-axis", (aLen, aLen), NW, heavygreen);
label("$v$-axis", (aLen, -aLen), SW, heavyred);

// right branch, for context
guide branch;
int n = 100;
for (int i = 0; i <= n; ++i) {
    real t = tmin + (tmax - tmin) * i / n;
    pair pt = (cosh(t), sinh(t));
    branch = (i == 0) ? pt : branch--pt;
}
draw(branch, blue + linewidth(1.1));
label("$x^2-y^2=1$", (cosh(0.4), sinh(0.4)), E, blue);

label("$u=x+y,\ v=x-y$", (0.05, ymax - 0.15), E, fontsize(9pt));
