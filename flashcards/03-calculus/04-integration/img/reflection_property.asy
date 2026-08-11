// int_a^b f(x) dx = int_{-b}^{-a} f(-x) dx: reflecting the graph of f
// through the y-axis and reversing the direction of integration are two
// sign flips that cancel, so the region under f(-x) on [-b,-a] is the
// mirror image of the region under f on [a,b], with equal area.

import graph;
import common;

size(14cm, 8cm, false);
mathdefaults();

real a = 1;
real b = 3;

real f(real x) { return 0.4 * (x - 1)^2 + 0.5; }
real g(real x) { return f(-x); }

real ymax = 2.8;

// axes -- the y-axis itself is the mirror line
drawAxes(-b - 0.6, b + 0.6, -0.3, ymax, ylabel="");

// original region: int_a^b f(x) dx
path region1 = (a, 0)--graph(f, a, b)--(b, 0)--cycle;
fill(region1, blue + opacity(0.25));
draw(graph(f, a, b), blue + linewidth(1.6));

// reflected region: int_{-b}^{-a} f(-x) dx, the mirror image across x=0
path region2 = (-b, 0)--graph(g, -b, -a)--(-a, 0)--cycle;
fill(region2, red + opacity(0.25));
draw(graph(g, -b, -a), red + linewidth(1.6));

// reflection guide: (b,f(b)) and (-b,g(-b)) sit at the same height, mirrored
draw((-b, f(b))--(b, f(b)), gray + dashed, Arrows(TeXHead));

// interval endpoints
dropToXAxis((a, f(a)));
dropToXAxis((b, f(b)));
dropToXAxis((-a, g(-a)));
dropToXAxis((-b, g(-b)));
label("$a$", (a, 0), S);
label("$b$", (b, 0), S);
label("$-a$", (-a, 0), S);
label("$-b$", (-b, 0), S);

label("$y=f(x)$", (b, f(b)), NE, blue);
label("$y=f(-x)$", (-b, g(-b)), NW, red);

label("$\displaystyle\int_a^b f(x)\,dx = \int_{-b}^{-a} f(-x)\,dx$", (0, ymax), N);
