// Counterexample showing the EVT's conclusion can fail without continuity:
// f(x) approaches b as x -> b^-, but never attains it since f(b) = a, so
// f has no maximum on the closed bounded interval [a,b].

import graph;
import common;

size(10cm, 10cm);
mathdefaults();

real a = 1;
real b = 3;

// axes
drawAxes(-0.5, 4, -0.5, 4);

// f(x) = x for a <= x < b
draw((a, a)--(b, b), blue + linewidth(1.2));
closedPoint((a, a), r=0.06);
openPoint((b, b), r=0.06);

// f(b) = a
closedPoint((b, a), r=0.06);

// supremum guide: f approaches b but never reaches it
draw((a, b)--(b + 0.8, b), red + dashed);
label("$y = b$", (b + 0.8, b), E, red);

// vertical guides: to the x-axis at a and b, and across the drop at b
dropToXAxis((a, a));
draw((b, a)--(b, b), dotted);

// axis labels
label("$a$", (a, 0), S);
label("$b$", (b, 0), S);

// marked values
label("$f(b) = a$", (b, a), SE);
label("no maximum on $[a,b]$", ((a + b) / 2, b + 0.5), N, red);
