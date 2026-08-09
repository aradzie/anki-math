// Type II improper integral: int_a^b f(x) dx where f is unbounded near a,
// illustrated with f(x) = 1/sqrt(x) on (0,1]. The defining limit is
//   int_a^b f(x) dx = lim_{eps -> 0+} int_{a+eps}^b f(x) dx,
// shown as the shaded area under the curve from a+eps to b, with the curve
// continuing (dashed) toward the vertical asymptote at x = a as eps -> 0+.

import graph;
import common;

size(9cm, 7cm);
mathdefaults();

real a = 0.5;
real b = 4;
real eps = a + 0.5;
real ymax = 3;
real xdraw = a + 1 / (ymax * ymax); // how close the dashed curve approaches the asymptote

real f(real x) { return 1 / sqrt(x - a); }

// axes
drawAxes(0, b + 0.6, 0, ymax + 0.3);

// shaded region: int_{a+eps}^b f(x) dx
path underCurve = (eps, 0)--graph(f, eps, b)--(b, 0)--cycle;
fill(underCurve, blue + opacity(0.25));

// curve, dashed near the asymptote, solid on [eps,b]
draw(graph(f, xdraw, eps), blue + linewidth(0.8) + dashed);
draw(graph(f, eps, b), blue + linewidth(1.6));
label("$y = 1/\sqrt{x}$", (eps, f(eps)), NE, blue);

// guides down to the axes
draw((a, 0)--(a, ymax), dotted);
dropToXAxis((eps, f(eps)));
dropToXAxis((b, f(b)));
label("$a$", (a, -0.15));
label("$a+\varepsilon$", (eps, -0.15));
label("$b$", (b, -0.15));

label("$\displaystyle\int_{a+\varepsilon}^b f(x)\,dx$", ((eps + b) / 2, 1.5));
