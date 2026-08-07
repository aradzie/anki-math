// Riemann sum S(f,P) = sum f(t_i) Delta x_i for a tagged partition of [a,b].
// Same f and partition points as upper_darboux_sum.asy / lower_darboux_sum.asy,
// but the sample points t_i are placed off-center in their subintervals
// (not at either endpoint) to make clear a tag can be any point of
// [x_{i-1}, x_i], not just an endpoint.

import graph;

size(14cm, 8cm, false);
defaultpen(fontsize(10pt));

real f(real x) { return 1 + 2 * sin(0.8 * x); }

real[] xpt = {0, 1, 1.8, 2.6, 4};
real[] t = {0.6, 1.2, 2.3, 3.0};
int n = xpt.length - 1;

real a = xpt[0];
real b = xpt[n];
real ymax = 4.0;

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

// Riemann rectangles of height f(t_i)
for (int i = 0; i < n; ++i) {
  real h = f(t[i]);
  filldraw((xpt[i], 0)--(xpt[i], h)--(xpt[i + 1], h)--(xpt[i + 1], 0)--cycle,
           red + opacity(0.15), red + linewidth(0.8));
  dot((t[i], 0), red);
  label("$t_" + string(i + 1) + "$", (t[i], 0), S, red);
}

// curve
draw(graph(f, a, b), blue + linewidth(1.6));
label("$y = f(x)$", (b, f(b)), NE, blue);

label("$\displaystyle S(f,P) = \sum_{i=1}^{4} f(t_i)\,\Delta x_i$", ((a + b) / 2, ymax - 0.4));
