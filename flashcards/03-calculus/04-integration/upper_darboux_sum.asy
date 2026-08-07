// Upper Darboux sum U(f,P) = sum M_i Delta x_i, M_i = sup on [x_{i-1},x_i].
// Same f and partition as riemann_sum.asy / lower_darboux_sum.asy. On the
// subinterval [1.8,2.6] the supremum is attained at an interior critical
// point (not an endpoint), marked explicitly, to show sup is a genuine
// least-upper-bound, not just "the larger endpoint value".

import graph;

size(14cm, 8cm, false);
defaultpen(fontsize(10pt));

real f(real x) { return 1 + 2 * sin(0.8 * x); }

real[] xpt = {0, 1, 1.8, 2.6, 4};
int n = xpt.length - 1;
real a = xpt[0];
real b = xpt[n];
real ymax = 4.0;

// M_i = sup f on [x_{i-1}, x_i]; the third subinterval straddles the
// critical point x* = pi/1.6, where f attains its max value 3 exactly.
real xstar = pi / 1.6;
real[] M = {f(xpt[1]), f(xpt[2]), 3, f(xpt[3])};

// axes
draw((-0.3, 0)--(b + 0.6, 0), Arrow(TeXHead));
draw((0, -0.3)--(0, ymax), Arrow(TeXHead));
label("$x$", (b + 0.6, 0), E);
label("$y$", (0, ymax), N);

// partition guides
for (int i = 0; i <= n; ++i) {
  draw((xpt[i], 0)--(xpt[i], f(xpt[i])), dotted);
  label("$x_" + string(i) + "$", (xpt[i], 0), S);
}

// upper rectangles of height M_i, overshooting the curve
for (int i = 0; i < n; ++i) {
  filldraw((xpt[i], 0)--(xpt[i], M[i])--(xpt[i + 1], M[i])--(xpt[i + 1], 0)--cycle,
           red + opacity(0.15), red + linewidth(0.8));
}

// mark the interior point where M_3 is attained
dot((xstar, 3), red);
label("$M_3 = f(x^*)$", (xstar, 3.35), red);
draw((xstar, 0)--(xstar, 3), dashed + red);

// curve
draw(graph(f, a, b), blue + linewidth(1.6));
label("$y = f(x)$", (b, f(b)), NE, blue);

label("$\displaystyle U(f,P) = \sum_{i=1}^{4} M_i\,\Delta x_i$", ((a + b) / 2, ymax - 0.15));
