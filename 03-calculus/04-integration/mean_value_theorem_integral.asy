// Mean Value Theorem for Integrals: for f continuous on [a,b], there exists
// c in (a,b) with f(c) equal to the average value of f on [a,b], so the area
// under the curve equals the area of a rectangle of height f(c) and width
// (b-a):  int_a^b f(x) dx = f(c)(b-a).  Here f(x) = x^2 on [1,3], so the
// average value is (b^3-a^3)/(3(b-a)) = 13/3 and c = sqrt(13/3).

import graph;

size(14cm, 10cm, false);
defaultpen(fontsize(10pt));

real f(real x) { return x^2; }

real a = 1;
real b = 3;
real fa = f(a);
real fb = f(b);
real avg = (b^3 - a^3) / (3 * (b - a));   // average value of f on [a,b]
real c = sqrt(avg);                        // f(c) = avg, c in (a,b)

// axes
draw((-0.3, -0.8)--(b + 0.8, -0.8), invisible);
draw((-0.3, 0)--(b + 0.8, 0), Arrow(TeXHead));
draw((0, -0.8)--(0, fb + 0.8), Arrow(TeXHead));
label("$x$", (b + 0.8, 0), E);
label("$y$", (0, fb + 0.8), N);

// area under the curve: int_a^b f(x) dx
path underCurve = (a, 0)--graph(f, a, b)--(b, 0)--cycle;
fill(underCurve, blue + opacity(0.25));

// rectangle of height f(c) = avg and width (b-a): same area
draw((a, 0)--(a, avg)--(b, avg)--(b, 0)--cycle, heavygreen + dashed + linewidth(1));

// curve
draw(graph(f, 0, b + 0.3), blue + linewidth(0.8));
draw(graph(f, a, b), blue + linewidth(1.6));
label("$y=f(x)$", (b + 0.3, f(b + 0.3)), NE, blue);

// horizontal guide at height f(c)
draw((0, avg)--(a, avg), dotted);
label("$f(c)$", (0, avg), W);

// vertical guides
draw((a, 0)--(a, fa), dotted);
draw((b, 0)--(b, fb), dotted);
draw((c, 0)--(c, avg), dotted);

// axis labels
label("$a$", (a, 0), S);
label("$c$", (c, 0), S);
label("$b$", (b, 0), S);

dot("$(c, f(c))$", (c, avg), NW);

label("$\displaystyle\int_a^b f(x)\,dx = f(c)(b-a)$", ((a + b) / 2, 8));
