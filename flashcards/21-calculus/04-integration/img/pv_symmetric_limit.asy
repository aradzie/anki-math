// Cauchy principal value, general definition: p.v. int_{-infty}^{infty}
// f(x) dx = lim_{R -> infty} int_{-R}^{R} f(x) dx, illustrated with a
// generic positive bump f(x) = e^{-x^2} + 0.3. Unlike the ordinary
// improper integral (Type I), which pushes a single bound to infinity,
// the principal value grows a single symmetric window [-R,R] outward on
// both ends at once -- shown as the shaded area under the curve on
// [-R,R], with the curve continuing (dashed) past +-R as R -> infty.

import graph;
import common;

size(11cm, 6cm);
mathdefaults();

real R = 2;
real gap = 1.5;
real xmax = R + gap;
real xmin = -xmax;
real ymax = 1.6;

real f(real x) { return exp(-x^2) + 0.3; }

// axes
drawAxes(xmin - 0.4, xmax + 0.4, 0, ymax + 0.3);

// shaded region: int_{-R}^{R} f(x) dx
path underCurve = (-R, 0)--graph(f, -R, R)--(R, 0)--cycle;
fill(underCurve, blue + opacity(0.25));

// curve, solid on [-R,R], dashed beyond to suggest R -> infty on both ends
draw(graph(f, xmin, -R), blue + linewidth(0.8) + dashed);
draw(graph(f, -R, R), blue + linewidth(1.6));
draw(graph(f, R, xmax), blue + linewidth(0.8) + dashed);
label("$y = f(x)$", (xmax, f(xmax)), NE, blue);

// guides down to the axes
dropToXAxis((R, f(R)));
dropToXAxis((-R, f(-R)));
label("$R \to \infty$", (R, -0.15));
label("$-R \to -\infty$", (-R, -0.15));

label("$\displaystyle\int_{-R}^{R} f(x)\,dx$", (0, 0.6));
