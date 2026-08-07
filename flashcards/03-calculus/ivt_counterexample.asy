// Counterexample showing the IVT's conclusion can fail without continuity:
// a jump discontinuity at m lets f skip over 0, a value strictly between
// f(a) = -1 and f(b) = 1.

import graph;

size(20cm, 10cm);
defaultpen(fontsize(10pt));

real a = 1;
real m = 3;
real b = 5;

// axes
draw((-0.5, 0)--(6, 0), Arrow(TeXHead));
draw((0, -1.5)--(0, 1.5), Arrow(TeXHead));
label("$x$", (6, 0), E);
label("$y$", (0, 1.5), N);

// f(x) = -1 for a <= x < m
draw((a, -1)--(m, -1), blue + linewidth(1.2));
filldraw(circle((a, -1), 0.06), blue);
filldraw(circle((m, -1), 0.06), white, blue);

// f(x) = 1 for m <= x <= b
draw((m, 1)--(b, 1), blue + linewidth(1.2));
filldraw(circle((m, 1), 0.06), blue);
filldraw(circle((b, 1), 0.06), blue);

// vertical guides: to the x-axis at a and b, and across the jump at m
draw((a, 0)--(a, -1), dotted);
draw((m, -1)--(m, 1), dotted);
draw((b, 0)--(b, 1), dotted);

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
