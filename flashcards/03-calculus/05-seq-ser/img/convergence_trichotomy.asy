// Trichotomy of power series convergence for sum c_n (x-a)^n:
// R = 0 (converges only at a), R = infinity (converges everywhere),
// and 0 < R < infinity (converges inside (a-R,a+R), endpoints uncertain).

import graph;
import common;

size(16cm, 8cm);
mathdefaults();

real xmin = -4.5;
real xmax = 4.5;
real a = 0;
real R = 2;

real y1 = 2.5;
real y2 = 0;
real y3 = -2.5;

// Case 1: R = 0 -- converges only at x = a
draw((xmin, y1)--(xmax, y1), gray + dashed, Arrows(TeXHead));
closedPoint((a, y1));
label("$R=0$", (a, y1), N, blue);
label("converges only at $x=a$", ((xmin + xmax) / 2, y1 - 0.9));

// Case 2: R = infinity -- converges for all real x
draw((xmin, y2)--(xmax, y2), blue + linewidth(2), Arrows(TeXHead));
label("$R=\infty$", (a, y2), N, blue);
label("converges for all $x$", ((xmin + xmax) / 2, y2 - 0.9));

// Case 3: 0 < R < infinity -- converges inside (a-R, a+R), diverges outside,
// endpoints x = a-R and x = a+R may converge or diverge
real lo = a - R;
real hi = a + R;
draw((xmin, y3)--(lo, y3), gray + dashed, Arrow(TeXHead));
draw((hi, y3)--(xmax, y3), gray + dashed, Arrow(TeXHead));
draw((lo, y3)--(hi, y3), blue + linewidth(2));
dot((a, y3));
label("$a$", (a, y3 - 0.3));
openPoint((lo, y3), color=gray);
openPoint((hi, y3), color=gray);
label("$a-R$", (lo, y3 - 0.3));
label("$a+R$", (hi, y3 - 0.3));
label("?", (lo, y3), N, gray);
label("?", (hi, y3), N, gray);
label("$0<R<\infty$", (a, y3), N, blue);
label("converges inside, diverges outside, endpoints uncertain",
      ((xmin + xmax) / 2, y3 - 0.9));
