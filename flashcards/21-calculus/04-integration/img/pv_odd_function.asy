// p.v. int_{-infty}^{infty} f(x) dx = 0 for odd f, illustrated with
// f(x) = x/(1+x^2). Since f(-x) = -f(x), the positive lobe on [0,R] and
// the negative lobe on [-R,0] are point-symmetric about the origin and
// have exactly equal and opposite (but not individually zero) area, so
// int_{-R}^{R} f(x) dx = 0 identically for every R -- not just in the
// limit R -> infty.

import graph;
import common;

size(11cm, 7cm, IgnoreAspect);
mathdefaults();

real R = 4;
real gap = 1.5;
real xmax = R + gap;
real xmin = -xmax;
real ymax = 0.65;
real ymin = -ymax;

real f(real x) { return x / (1 + x^2); }

// axes -- curve is labeled directly, so omit the generic y-axis label to
// leave headroom for the caption above
drawAxes(xmin - 0.4, xmax + 0.4, ymin, ymax, ylabel="");

// positive lobe: int_0^R f(x) dx = A, above the axis
path posLobe = (0, 0)--graph(f, 0, R)--(R, 0)--cycle;
fill(posLobe, blue + opacity(0.25));

// negative lobe: int_{-R}^0 f(x) dx = -A, below the axis
path negLobe = (-R, 0)--graph(f, -R, 0)--(0, 0)--cycle;
fill(negLobe, red + opacity(0.25));

// curve, solid on [-R,R], dashed beyond to suggest R -> infty on both ends
draw(graph(f, xmin, -R), blue + linewidth(0.8) + dashed);
draw(graph(f, -R, R), blue + linewidth(1.6));
draw(graph(f, R, xmax), blue + linewidth(0.8) + dashed);
label("$y = \frac{x}{1+x^2}$", (R, f(R)), NE, blue);

// guides down to the axes
dropToXAxis((R, f(R)));
dropToXAxis((-R, f(-R)));
label("$R$", (R, -0.12));
label("$-R$", (-R, 0.12));

// signed areas: equal magnitude, opposite sign, by odd symmetry
label("$+A$", (1.3, 0.15), blue);
label("$-A$", (-1.3, -0.15), red);

// cancellation caption
label("$\displaystyle\int_{-R}^{R} f(x)\,dx = A - A = 0 \quad \forall R$", (0, ymax), N);
