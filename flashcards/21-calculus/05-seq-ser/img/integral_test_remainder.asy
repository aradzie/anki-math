// Integral test remainder bound: R_N = sum_{n=N+1}^infty a_n is squeezed
// between two integrals of the same decreasing positive f with f(n) = a_n.
// Right-endpoint rectangles of height a_n on [n-1, n] (spanning [N, nmax])
// sit below the curve, so R_N <= int_N^infty f(x) dx. Left-endpoint
// rectangles of height a_n on [n, n+1] (spanning [N+1, nmax+1]) sit above
// the curve, so R_N >= int_{N+1}^infty f(x) dx. Both staircases are built
// from the same heights a_{N+1}, a_{N+2}, ..., just offset by one unit.

import graph;
import common;

size(11cm, 6.5cm);
mathdefaults();

real f(real x) { return 4 / x; }

int nStart = 1;    // N
int nmax = 6;      // last term included: a_{nmax}
real R = nmax + 1; // right edge of the drawn range
real xmax = R + 1;
real ymax = f(nStart) + 0.5;

// axes
drawAxes(0, xmax, 0, ymax + 0.3);

// right-endpoint rectangles on [n-1,n] for n = N+1,...,nmax: below the
// curve, total area R_N <= int_N^infty f(x) dx
for (int n = nStart + 1; n <= nmax; ++n) {
  filldraw((n - 1, 0)--(n - 1, f(n))--(n, f(n))--(n, 0)--cycle,
           heavygreen + opacity(0.12), heavygreen + linewidth(0.8));
}

// left-endpoint rectangles on [n,n+1] for n = N+1,...,nmax: above the
// curve, total area R_N >= int_{N+1}^infty f(x) dx
for (int n = nStart + 1; n <= nmax; ++n) {
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

// emphasize N and N+1: staircase start points for each bound
draw((nStart, 0)--(nStart, ymax), heavygreen + dashed);
draw((nStart + 1, 0)--(nStart + 1, ymax), red + dashed);

label("$\displaystyle \int_{N+1}^{\infty} f(x)\,dx \;\le\; R_N \;\le\; \int_{N}^{\infty} f(x)\,dx$",
      ((nStart + R) / 2, ymax - 0.2));

// legend
label("$a_n$ on $[n-1,n]$: below curve", (4.6, 2.8), S, heavygreen);
label("$a_n$ on $[n,n+1]$: above curve", (4.6, 2.8), N, red);
