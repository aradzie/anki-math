// Decreasing-function integral sandwich: for continuous, decreasing f, the
// rectangle of height f(n) on [n, n+1] sits above the curve (f decreases
// below f(n) past x=n), overestimating the area, so int_n^{n+1} f(x) dx <=
// f(n). The rectangle of the same height on [n-1, n] sits below the curve
// (f is above f(n) before x=n), underestimating the area, so f(n) <=
// int_{n-1}^n f(x) dx. Together: int_n^{n+1} f(x) dx <= f(n) <=
// int_{n-1}^n f(x) dx.

import graph;
import common;

size(9cm, 6cm);
mathdefaults();

real f(real x) { return 4 / x; }

real n = 4;
real xmin = n - 2;
real xmax = n + 2.5;
real ymax = f(xmin) + 0.5;

// axes
drawAxes(xmin, xmax, 0, ymax + 0.3);

// left-endpoint rectangle of height f(n) on [n-1, n]: above the curve
filldraw((n - 1, 0)--(n - 1, f(n))--(n, f(n))--(n, 0)--cycle,
         red + opacity(0.15), red + linewidth(0.8));

// right-endpoint rectangle of height f(n) on [n, n+1]: below the curve
filldraw((n, 0)--(n, f(n))--(n + 1, f(n))--(n + 1, 0)--cycle,
         heavygreen + opacity(0.15), heavygreen + linewidth(0.8));

// curve
draw(graph(f, xmin, xmax), blue + linewidth(1.6));
label("$y = f(x)$", (xmax, f(xmax)), NE, blue);

// x-axis tick labels: n-1, n, n+1
draw((n - 1, 0)--(n - 1, -0.08));
label("$n-1$", (n - 1, -0.15), S);
draw((n, 0)--(n, -0.08));
label("$n$", (n, -0.15), S);
draw((n + 1, 0)--(n + 1, -0.08));
label("$n+1$", (n + 1, -0.15), S);

// height guide
draw((xmin, f(n))--(n, f(n)), gray + dashed);
label("$f(n)$", (xmin, f(n)), W);

label("$\displaystyle \int_{n}^{n+1} f(x)\,dx \;\le\; f(n) \;\le\; \int_{n-1}^{n} f(x)\,dx$",
      (n, ymax - 0.2));

label("above curve", (n + 0.5, f(n) / 2), S, heavygreen);
label("below curve", (n - 0.5, f(n) + 0.15), N, red);
