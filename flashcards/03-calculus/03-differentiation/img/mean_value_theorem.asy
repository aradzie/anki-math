// Mean Value Theorem: if f is continuous on [a,b] and differentiable on
// (a,b), there exists c in (a,b) such that f'(c) equals the slope of the
// secant line through (a, f(a)) and (b, f(b)).

import graph;
import common;

size(20cm, 10cm, false);
mathdefaults();

real f(real x) { return -0.7*(x - 2.5)*(x - 2.5) + 5; }

real a = 1;
real b = 5;
real c = (a + b) / 2;
real m = (f(b) - f(a)) / (b - a);
pair tanEnd = (c + 1.2, f(c) + m * 1.2);

// axes
drawAxes(-0.5, 6, -0.5, 7);

// curve
draw(graph(f, a, b), blue + linewidth(1.2));

// secant line through (a,f(a)) and (b,f(b))
draw((a, f(a))--(b, f(b)), heavygreen + linewidth(1.2));
label("slope $=\frac{f(b)-f(a)}{b-a}$", (c, f(a) + m * (c - a) - 0.5), S, heavygreen);

// tangent line at c, parallel to the secant
draw((c - 1.2, f(c) - m * 1.2)--tanEnd, red + dashed);
label("slope $=f'(c)$", tanEnd, E, red);

// vertical guides down to the x-axis
dropToXAxis((a, f(a)));
dropToXAxis((c, f(c)));
dropToXAxis((b, f(b)));

// axis labels
label("$a$", (a, 0), S);
label("$c$", (c, 0), S);
label("$b$", (b, 0), S);

// marked points
dot("$(a, f(a))$", (a, f(a)), NW);
dot("$(b, f(b))$", (b, f(b)), NE);
dot("$(c, f(c))$", (c, f(c)), N);
