// Left vs. right Riemann sum on the same monotone increasing curve and
// partition, drawn as two panels side by side. Left panel samples each
// rectangle's height at the left endpoint (undershoots, since f is
// increasing); right panel samples at the right endpoint (overshoots).

import graph;
import common;

size(24cm, 8cm);
mathdefaults();

real f(real x) { return 0.5 + 0.15 * x^2; }

real[] xpt = {0, 1, 2, 3, 4};
int n = xpt.length - 1;
real a = xpt[0];
real b = xpt[n];
real ymax = 4.0;
real dx2 = (b - a) + 1.8; // horizontal offset of the right panel

path curve = graph(f, a, b);

void panel(real dx, bool leftSum, string sumLabel, string title) {
  drawAxes(dx - 0.3, dx + b + 0.6, -0.3, ymax, ylabel="", originx=dx);

  for (int i = 0; i <= n; ++i) {
    dropToXAxis((dx + xpt[i], f(xpt[i])));
    label("$" + string(xpt[i]) + "$", (dx + xpt[i], 0), S);
  }

  pen c = leftSum ? red : heavygreen;
  for (int i = 0; i < n; ++i) {
    real h = leftSum ? f(xpt[i]) : f(xpt[i + 1]);
    filldraw((dx + xpt[i], 0)--(dx + xpt[i], h)--(dx + xpt[i + 1], h)--(dx + xpt[i + 1], 0)--cycle,
             c + opacity(0.15), c + linewidth(0.8));
  }

  draw(shift(dx, 0) * curve, blue + linewidth(1.6));
  label("$y = f(x)$", (dx + b, f(b)), NE, blue);

  for (int i = 0; i < n; ++i) {
    real h = leftSum ? f(xpt[i]) : f(xpt[i + 1]);
    real xs = leftSum ? xpt[i] : xpt[i + 1];
    closedPoint((dx + xs, h), black);
  }
  label(title, (dx + (a + b) / 2, ymax - 0.35));
  label(sumLabel, (dx + (a + b) / 2, ymax - 0.85));
}

panel(0, true, "$\displaystyle L_4 = h\sum_{i=0}^{3} f(x_i)$", "Left sum: undershoots");
panel(dx2, false, "$\displaystyle R_4 = h\sum_{i=1}^{4} f(x_i)$", "Right sum: overshoots");
