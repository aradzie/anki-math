// Radius of convergence R of sum c_n (x-a)^n: converges on |x-a| < R,
// diverges on |x-a| > R. Endpoints are punctured in gray -- marking the
// boundary of the open interval (a-R, a+R), not asserting that the series
// actually diverges there, since R alone does not determine that.

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

dot((a, 0));
label("$a$", (a, -0.4));

openPoint((lo, 0), color=gray);
openPoint((hi, 0), color=gray);
label("$a-R$", (lo, -0.4));
label("$a+R$", (hi, -0.4));

draw((lo, 0.4)--(lo, 0.6)--(a, 0.6)--(a, 0.4));
label("$R$", ((lo + a) / 2, 0.6), N);

draw((a, 0.4)--(a, 0.6)--(hi, 0.6)--(hi, 0.4));
label("$R$", ((a + hi) / 2, 0.6), N);

label("converges", ((lo + hi) / 2, -0.8), blue);
label("diverges", ((xmin + lo) / 2, -0.8), gray);
label("diverges", ((hi + xmax) / 2, -0.8), gray);
