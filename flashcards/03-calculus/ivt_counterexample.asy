// Counterexample showing the IVT's conclusion can fail without continuity:
// a jump discontinuity at m lets f skip over 0, a value strictly between
// f(a) = -1 and f(b) = 1.

import graph;
import common;

size(20cm, 10cm);
mathdefaults();

real a = 1;
real m = 3;
real b = 5;

// axes
drawAxes(-0.5, 6, -1.5, 1.5);

// f(x) = -1 for a <= x < m
draw((a, -1)--(m, -1), blue + linewidth(1.2));
closedPoint((a, -1), r=0.06);
openPoint((m, -1), r=0.06);

// f(x) = 1 for m <= x <= b
draw((m, 1)--(b, 1), blue + linewidth(1.2));
closedPoint((m, 1), r=0.06);
closedPoint((b, 1), r=0.06);

// vertical guides: to the x-axis at a and b, and across the jump at m
dropToXAxis((a, -1));
draw((m, -1)--(m, 1), dotted);
dropToXAxis((b, 1));

// axis labels
label("$a$", (a, 0), S);
label("$m$", (m, 0), S);
label("$b$", (b, 0), S);

// marked values
label("$f(a) = -1$", (a, -1), SE);
label("$f(b) = 1$", (b, 1), NE);

// the skipped value: 0 lies on the x-axis itself, strictly between f(a) and f(b)
draw((m, 0.6)--(m, 0.1), red, Arrow(TeXHead));
label("$f$ never equals $0$", (m, 0.65), N, red);
