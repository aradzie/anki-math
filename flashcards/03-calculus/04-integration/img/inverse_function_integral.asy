// Integral of an inverse function, geometrically. For f increasing (here
// f(x) = x^2 on x >= 0), the curve y = f(x) splits the L-shaped region
// [0,b] x [0,f(b)] minus [0,a] x [0,f(a)] into the area under the curve
// from a to b and the area left of the curve from f(a) to f(b):
//   b f(b) - a f(a) = int_a^b f(x) dx + int_{f(a)}^{f(b)} f^{-1}(y) dy.

import graph;
import common;

size(11cm, 15cm, false);
mathdefaults();

real f(real x) { return x^2 / 2; }

real a = 1.1;
real b = 2.4;
real fa = f(a);
real fb = f(b);

// axes
drawAxes(-0.2, b + 0.6, -0.2, fb + 0.6);

// region under the curve from a to b: int_a^b f(x) dx
path underCurve = (a, 0)--graph(f, a, b)--(b, 0)--cycle;
fill(underCurve, blue + opacity(0.25));

// region left of the curve from f(a) to f(b): int_{f(a)}^{f(b)} f^{-1}(y) dy
path leftOfCurve = (0, fa)--(a, fa)--graph(f, a, b)--(0, fb)--cycle;
fill(leftOfCurve, heavygreen + opacity(0.25));

// reference rectangles: [0,b] x [0,f(b)] and [0,a] x [0,f(a)]
draw((0, 0)--(b, 0)--(b, fb)--(0, fb)--cycle, dashed + gray(0.5));
draw((0, 0)--(a, 0)--(a, fa)--(0, fa)--cycle, dashed + gray(0.5));

// the curve, highlighted on [a,b]
draw(graph(f, 0, b + 0.2), blue + linewidth(0.8));
draw(graph(f, a, b), blue + linewidth(1.6));
label("$y=f(x)$", (b + 0.2, f(b + 0.2)), NE, blue);

// guides down to the axes
dropToXAxis((a, fa));
dropToXAxis((b, fb));
dropToYAxis((a, fa));
dropToYAxis((b, fb));

// axis labels
label("$a$", (a, 0), S);
label("$b$", (b, 0), S);
label("$f(a)$", (0, fa), W);
label("$f(b)$", (0, fb), W);

dot("$(a,f(a))$", (a, fa), NW);
dot("$(b,f(b))$", (b, fb), NW);

label("$\int_a^b f(x)\,dx$", ((a + b) / 2, 0.5));
label("$\int_{f(a)}^{f(b)} f^{-1}(y)\,dy$", (0.75, (fa + fb) / 2));
