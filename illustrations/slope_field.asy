// Slope field for the ODE y' = x - y, with two solution curves overlaid:
// the exact linear solution y = x - 1, and a curved solution
// y = x - 1 + C e^{-x} approaching it as x increases.

import graph;

size(10cm);
defaultpen(fontsize(10pt));

real xmin = -3, xmax = 3;
real ymin = -3, ymax = 3;
real step = 0.5;
real seglen = 0.24;

// axes
draw((xmin - 0.3, 0)--(xmax + 0.3, 0), Arrow(TeXHead));
draw((0, ymin - 0.3)--(0, ymax + 0.3), Arrow(TeXHead));
label("$x$", (xmax + 0.3, 0), E);
label("$y$", (0, ymax + 0.3), N);

// slope field: short segments with direction (1, x - y) at each grid point
for (real x = xmin; x <= xmax + 1e-9; x += step) {
  for (real y = ymin; y <= ymax + 1e-9; y += step) {
    real m = x - y;
    real norm = sqrt(1 + m * m);
    pair dir = (1 / norm, m / norm);
    pair p0 = (x, y) - (seglen / 2) * dir;
    pair p1 = (x, y) + (seglen / 2) * dir;
    draw(p0--p1, gray(0.5));
  }
}

// solution curves y = x - 1 + C e^{-x}; clipped to the plotting window
// below since C != 0 blows up as x -> -infty
real sol0(real x) { return x - 1; }
real sol1(real x) { return x - 1 + 1.5 * exp(-x); }

draw(graph(sol0, xmin, xmax), blue + linewidth(1.2));
draw(graph(sol1, xmin, xmax), red + linewidth(1.2));

label("$y = x - 1$", (1.5, sol0(1.5)), 2 * S, blue);
label("$y = x - 1 + 1.5\,e^{-x}$", (-0.9, ymax - 0.3), red);

clip(currentpicture, box((xmin - 0.5, ymin - 0.5), (xmax + 0.5, ymax + 0.5)));

label("$y' = x - y$", (xmax - 0.9, ymin + 0.5));
