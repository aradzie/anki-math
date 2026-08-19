// Euler's characterization of e: the area under y=1/x from 1 to e is
// exactly 1 -- e is the point that cuts off unit area under the hyperbola.

import graph;
import common;

size(11cm, 9cm);
mathdefaults();

real xmin = -0.4, xmax = 3.6;
real ymax = 3.4;

real e0 = exp(1);

real curve(real x) { return 1 / x; }

draw((xmin, 0)--(xmax, 0), Arrow(TeXHead));
draw((0, -0.4)--(0, ymax), Arrow(TeXHead));
label("$x$", (xmax, 0), E);
label("$y$", (0, ymax), N);

// full branch, for context
guide branch;
real xCurveMin = 0.3, xCurveMax = 3.5;
int n = 100;
for (int i = 0; i <= n; ++i) {
    real x = xCurveMin + (xCurveMax - xCurveMin) * i / n;
    pair pt = (x, curve(x));
    branch = (i == 0) ? pt : branch--pt;
}
draw(branch, blue + linewidth(1.1));
label("$y=1/x$", (2.9, curve(2.9)), NE, blue);

// shaded region under the curve, from 1 to e
guide region = (1, 0)--(1, curve(1));
int m = 60;
for (int i = 0; i <= m; ++i) {
    real x = 1 + (e0 - 1) * i / m;
    region = region--(x, curve(x));
}
region = region--(e0, 0)--cycle;
fill(region, orange + opacity(0.3));
draw(region, orange + linewidth(0.9));

label("area $=1$", (1.8, 0.3), orange);

dot((1, 0), black);
label("$1$", (1, 0), S);

dot((e0, 0), black);
label("$e$", (e0, 0), S);
