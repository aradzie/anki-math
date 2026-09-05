// Lower Darboux sum L(f,P) = sum m_i Delta x_i, m_i = inf on [x_{i-1},x_i].
// Same f and partition as riemann_sum.asy / upper_darboux_sum.asy. Every
// m_i here happens to be attained at a subinterval endpoint (the curve has
// a single interior hump, so its minima on each piece sit at the edges),
// in contrast to the interior supremum shown in upper_darboux_sum.asy.

import graph;
import common;

size(14cm, 8cm, false);
mathdefaults();

real f(real x) { return 1 + 2 * sin(0.8 * x); }

real[] xpt = {0, 1, 1.8, 2.6, 4};
int n = xpt.length - 1;
real a = xpt[0];
real b = xpt[n];
real ymax = 4.0;

// m_i = inf f on [x_{i-1}, x_i]; on the third subinterval, the smaller of
// the two endpoint values is the infimum (the curve only rises then falls
// between them, never dipping below both).
real[] m = {f(xpt[0]), f(xpt[1]), f(xpt[3]), f(xpt[4])};

// axes
drawAxes(-0.3, b + 0.6, -0.3, ymax);

// partition guides
for (int i = 0; i <= n; ++i) {
  dropToXAxis((xpt[i], f(xpt[i])));
  label("$x_" + string(i) + "$", (xpt[i], 0), S);
}

// lower rectangles of height m_i, undershooting the curve
for (int i = 0; i < n; ++i) {
  filldraw((xpt[i], 0)--(xpt[i], m[i])--(xpt[i + 1], m[i])--(xpt[i + 1], 0)--cycle,
           heavygreen + opacity(0.15), heavygreen + linewidth(0.8));
}

// curve
draw(graph(f, a, b), blue + linewidth(1.6));
label("$y = f(x)$", (b, f(b)), NE, blue);

label("$\displaystyle L(f,P) = \sum_{i=1}^{4} m_i\,\Delta x_i$", ((a + b) / 2, ymax - 0.4));
