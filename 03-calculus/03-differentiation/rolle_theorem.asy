// Rolle's Theorem: if f is continuous on [a,b], differentiable on (a,b),
// and f(a) = f(b), there exists c in (a,b) with f'(c) = 0.

import graph;

size(20cm, 10cm, false);
defaultpen(fontsize(10pt));

real f(real x) { return -0.5*(x-3)*(x-3) + 3; }

real a = 1;
real b = 5;
real xc = (a + b) / 2;
real yc = f(xc);

// axes
draw((-0.5, 0)--(6, 0), Arrow(TeXHead));
draw((0, -0.5)--(0, 4), Arrow(TeXHead));
label("$x$", (6, 0), E);
label("$y$", (0, 4), N);

// curve
draw(graph(f, a, b), blue + linewidth(1.2));

// f(a) = f(b) guide
draw((a, f(a))--(b, f(b)), dashed);
label("$f(a) = f(b)$", ((a + b) / 2, f(a)), S);

// vertical guides down to the x-axis
draw((a, 0)--(a, f(a)), dotted);
draw((xc, 0)--(xc, yc), dotted);
draw((b, 0)--(b, f(b)), dotted);

// axis labels
label("$a$", (a, 0), S);
label("$c$", (xc, 0), S);
label("$b$", (b, 0), S);

// marked points
dot("$(a, f(a))$", (a, f(a)), NW);
dot("$(b, f(b))$", (b, f(b)), NE);
dot("$(c, f(c))$", (xc, yc), N);

// horizontal tangent at c
draw((xc - 0.8, yc)--(xc + 0.8, yc), red + dashed);
label("$f'(c) = 0$", (xc + 0.8, yc), E, red);
