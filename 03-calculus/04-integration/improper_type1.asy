// Type I improper integral: int_a^infty f(x) dx, illustrated with
// f(x) = 1/x^2 and a = 1. The defining limit is
//   int_a^infty f(x) dx = lim_{R -> infty} int_a^R f(x) dx,
// shown as the shaded area under the curve from a to a finite R, with the
// curve continuing (dashed) past R as R is pushed to infinity.

import graph;

size(11cm, 6cm);
defaultpen(fontsize(10pt));

real a = 1;
real R = 5;
real xmin = a;
real xmax = R + 2;
real ymax = 2.2;

real f(real x) { return 2 / x^1.6; }

// axes
draw((0, 0)--(xmax + 0.4, 0), Arrow(TeXHead));
draw((0, 0)--(0, ymax + 0.3), Arrow(TeXHead));
label("$x$", (xmax + 0.4, 0), E);
label("$y$", (0, ymax + 0.3), N);

// shaded region: int_a^R f(x) dx
path underCurve = (a, 0)--graph(f, a, R)--(R, 0)--cycle;
fill(underCurve, blue + opacity(0.25));

// curve, solid on [a,R], dashed beyond R to suggest R -> infty
draw(graph(f, xmin, a), blue + linewidth(0.8));
draw(graph(f, a, R), blue + linewidth(1.6));
draw(graph(f, R, xmax), blue + linewidth(0.8) + dashed);
label("$y = 1/x^2$", (a, f(a)), NE, blue);

// guides down to the axes
draw((a, 0)--(a, f(a)), dotted);
draw((R, 0)--(R, f(R)), dotted);
label("$a$", (a, -0.15));
label("$R \to \infty$", (R, -0.15));

label("$\displaystyle\int_a^R f(x)\,dx$", ((a + R) / 2, 1));
