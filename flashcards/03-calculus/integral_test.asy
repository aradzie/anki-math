// Integral test: for a decreasing positive f with f(n) = a_n, the left-endpoint
// rectangles of height a_n on [n, n+1] lie above the curve, so
//   sum_{n=N}^infty a_n  >=  int_N^infty f(x) dx,
// which is why the series and the improper integral share the same
// convergence/divergence behavior.

import graph;

size(11cm, 6.5cm);
defaultpen(fontsize(10pt));

real f(real x) { return 4 / x; }

int nStart = 1;
int nmax = 6;           // last rectangle: [nmax, nmax+1]
real R = nmax + 1;      // right edge of the shaded integral region
real xmax = R + 1;
real ymax = f(nStart) + 0.5;

// axes
draw((0, 0)--(xmax, 0), Arrow(TeXHead));
draw((0, 0)--(0, ymax + 0.3), Arrow(TeXHead));
label("$x$", (xmax, 0), E);
label("$y$", (0, ymax + 0.3), N);

// shaded region under the curve: int_N^R f(x) dx
path underCurve = (nStart, 0)--graph(f, nStart, R)--(R, 0)--cycle;
fill(underCurve, blue + opacity(0.2));

// left-endpoint rectangles of height a_n = f(n) on [n, n+1]
for (int n = nStart; n <= nmax; ++n) {
  filldraw((n, 0)--(n, f(n))--(n + 1, f(n))--(n + 1, 0)--cycle,
           red + opacity(0.12), red + linewidth(0.8));
}

// curve, solid on [N,R], dashed beyond to suggest continuing to infinity
draw(graph(f, nStart, R), blue + linewidth(1.6));
draw(graph(f, R, xmax), blue + linewidth(0.8) + dashed);
label("$y = f(x)$", (R, f(R)), NE, blue);

// x-axis tick labels: N, N+1, N+2, ...
for (int n = nStart; n <= nmax + 1; ++n) {
  draw((n, 0)--(n, -0.08));
  int offset = n - nStart;
  string lbl = (offset == 0) ? "N" : "N+" + string(offset);
  label("$" + lbl + "$", (n, -0.15), S);
}

// rectangle height labels
label("$a_N$", (nStart + 0.5, f(nStart)), N, red);
label("$a_{N+1}$", (nStart + 1.5, f(nStart + 1)), N, red);
label("$\cdots$", (nStart + 3.5, f(nStart + 3) + 0.1), N, red);

label("$\displaystyle \sum_{n=N}^{\infty} a_n \;\ge\; \int_N^{\infty} f(x)\,dx$",
      ((nStart + R) / 2, ymax - 0.2));
