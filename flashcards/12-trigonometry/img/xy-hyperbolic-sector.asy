// A hyperbolic sector in standard position on xy=1: bounded by the two
// straight rays from the origin through P=(1,1) and Q=(b,1/b), and the
// hyperbola arc between them. Its area is ln b.

import graph;
import common;

size(11cm, 9cm);
mathdefaults();

real xmin = -0.4, xmax = 3.6;
real ymax = 3.4;

real b0 = 2.5;

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
label("$xy=1$", (2.9, curve(2.9)), NE, blue);

// shaded sector: origin -> P -> arc up to Q -> origin
guide sector = (0, 0)--(1, 1);
int m = 60;
for (int i = 0; i <= m; ++i) {
    real x = 1 + (b0 - 1) * i / m;
    sector = sector--(x, curve(x));
}
sector = sector--cycle;
fill(sector, orange + opacity(0.3));
draw(sector, orange + linewidth(0.9));

label("$\ln b$", (1, 0.5), orange);

dot((1, 1), black);
label("$P=(1,1)$", (1, 1), NE);

pair Q = (b0, curve(b0));
dot(Q, blue);
label("$Q=(b,1/b)$", Q, SE);
