// Interval of convergence I of sum c_n (x-a)^n: the actual set of x where
// the series converges. Always contains the open interval (a-R, a+R); the
// endpoints x = a-R and x = a+R are in I iff the series converges there.

import graph;
import common;

size(16cm, 6cm);
mathdefaults();

real xmin = -4.5;
real xmax = 4.5;
real a = 0;
real R = 2;
real lo = a - R;
real hi = a + R;

draw((xmin, 0)--(lo, 0), gray + dashed, Arrow(TeXHead));
draw((hi, 0)--(xmax, 0), gray + dashed, Arrow(TeXHead));
draw((lo, 0)--(hi, 0), blue + linewidth(2));

openPoint((lo, 0), color=gray);
openPoint((hi, 0), color=gray);
label("?", (lo, 0), N, gray);
label("?", (hi, 0), N, gray);

label("$a-R$", (lo, -0.4));
label("$a$", (a, -0.4));
label("$a+R$", (hi, -0.4));

label("always in $I$", ((lo + hi) / 2, 0.7), blue);
label("in $I$ iff the series converges there", ((xmin + xmax) / 2, -0.9), gray);
