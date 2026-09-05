// int_{-a}^{a} f(x) dx = 0 for odd f, illustrated with f(x) = x/(1+x^2).
// Since f(-x) = -f(x), the lobe on [0,a] and the lobe on [-a,0] are
// point-symmetric about the origin and have equal magnitude but opposite
// sign area, so they cancel exactly.

import graph;
import common;

size(12cm, 7cm, IgnoreAspect);
mathdefaults();

real a = 3;

real f(real x) { return x / (1 + x^2); }

real ymax = 0.75;
real ymin = -ymax;

// axes -- curve is labeled directly, so omit the generic y-axis label to
// leave headroom for the caption above
drawAxes(-a - 0.6, a + 0.6, ymin, ymax, ylabel="");

// positive lobe: int_0^a f(x) dx = A, above the axis
path posLobe = (0, 0)--graph(f, 0, a)--(a, 0)--cycle;
fill(posLobe, blue + opacity(0.25));

// negative lobe: int_{-a}^0 f(x) dx = -A, below the axis
path negLobe = (-a, 0)--graph(f, -a, 0)--(0, 0)--cycle;
fill(negLobe, red + opacity(0.25));

// curve
draw(graph(f, -a, a), blue + linewidth(1.6));
label("$y=f(x)$", (a, f(a)), NE, blue);

// guides down to the axes
dropToXAxis((a, f(a)));
dropToXAxis((-a, f(-a)));
label("$a$", (a, -0.12));
label("$-a$", (-a, 0.12));

// signed areas: equal magnitude, opposite sign
label("$+A$", (a / 2.3, 0.15), blue);
label("$-A$", (-a / 2.3, -0.15), red);

label("$\displaystyle\int_{-a}^{a} f(x)\,dx = A - A = 0$", (0, ymax), N);
