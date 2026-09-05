// Bernoulli's inequality: (1+x)^n >= 1+nx for x >= -1, illustrated for
// n = 3. The line 1+nx is the tangent to (1+x)^n at x=0; convexity of
// (1+x)^n on x >= -1 keeps the curve on or above its tangent everywhere
// in that domain, with equality only at x = 0.

import graph;
import common;

size(14cm, 8cm);
mathdefaults();

real s = 0.3;
int n = 3;
real f(real x) { return ((1 + x)^n) * s; }
real g(real x) { return (1 + n * x) * s; }

real xmin = -1;
real xmax = 1.2;

drawAxes(xmin - 0.3, xmax + 0.3, -1, f(xmax) + 0.3, ylabel="");

draw(graph(f, xmin, xmax), blue + linewidth(1.2));
draw(graph(g, xmin, xmax), red + linewidth(1.2));

verticalGuide((xmin, 0), -1, f(xmax) + 0.3, gray + dashed);
label("$x=-1$", (xmin, 0), S);

draw((0, 1)--(-0.65, 3.2), gray + dotted);
dot((0, s));

label("$(1+x)^n$", (xmax, f(xmax)), E, blue);
label("$1+nx$", (xmax, g(xmax)), E, red);

label("$n=3$", (0, -1.5), N);
label("equality at $x=0$", (0, -1.5), S);
