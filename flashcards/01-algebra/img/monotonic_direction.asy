// Monotonic functions and inequality direction, for a <= b:
// an increasing f preserves it (f(a) <= f(b)), a decreasing f flips it
// (f(a) >= f(b)).

import graph;
import common;

size(24cm, 9cm);
mathdefaults();

real a = 1;
real b = 4;

// --- left panel: increasing function ---
real fInc(real x) { return 0.1 * x^2 + 0.5; }

real x0 = 0;
drawAxes(x0 - 0.5, x0 + 5.5, -0.5, 3.5, originx=x0);

draw(graph(fInc, x0, x0 + 5), blue + linewidth(1.2));

draw((a, 0)--(a, fInc(a))--(x0, fInc(a)), dotted);
draw((b, 0)--(b, fInc(b))--(x0, fInc(b)), dotted);
label("$a$", (a, 0), S);
label("$b$", (b, 0), S);
label("$f(a)$", (x0, fInc(a)), W);
label("$f(b)$", (x0, fInc(b)), W);
dot((a, fInc(a)));
dot((b, fInc(b)));
label("increasing: $a \le b \Rightarrow f(a) \le f(b)$", (x0 + 2.5, -0.5), S, blue);

// --- right panel: decreasing function ---
real dx = 9;
real fDec(real x) { return -0.1 * (x - dx)^2 + 3; }

drawAxes(dx - 0.5, dx + 5.5, -0.5, 3.5, originx=dx);

draw(graph(fDec, dx, dx + 5), red + linewidth(1.2));

draw((dx + a, 0)--(dx + a, fDec(dx + a))--(dx, fDec(dx + a)), dotted);
draw((dx + b, 0)--(dx + b, fDec(dx + b))--(dx, fDec(dx + b)), dotted);
label("$a$", (dx + a, 0), S);
label("$b$", (dx + b, 0), S);
label("$f(a)$", (dx, fDec(dx + a)), W);
label("$f(b)$", (dx, fDec(dx + b)), W);
dot((dx + a, fDec(dx + a)));
dot((dx + b, fDec(dx + b)));
label("decreasing: $a \le b \Rightarrow f(a) \ge f(b)$", (dx + 2.5, -0.5), S, red);
