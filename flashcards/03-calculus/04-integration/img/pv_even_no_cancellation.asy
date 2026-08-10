// p.v. int_{-infty}^{infty} f(x) dx diverges for even f, illustrated with
// f(x) = x^2/6. Since f(-x) = f(x), the lobe on [0,R] and the lobe on
// [-R,0] lie on the same side of the axis and have equal (not opposite)
// area, so int_{-R}^{R} f(x) dx = 2A grows without bound as R -> infty --
// there is no cancellation to exploit the way there is for odd f.

import graph;
import common;

size(11cm, 7cm, IgnoreAspect);
mathdefaults();

real R = 3;
real gap = 1.3;
real xmax = R + gap;
real xmin = -xmax;
real ymax = 1.9;
real ymin = -0.3;

real f(real x) { return x^2 / 6; }

// axes -- curve is labeled directly, so omit the generic y-axis label to
// leave headroom for the caption above
drawAxes(xmin - 0.4, xmax + 0.4, ymin, ymax, ylabel="");

// both lobes lie above the axis and are filled the same color, unlike the
// odd-function illustration's opposite-sign red/blue pair
path posLobe = (0, 0)--graph(f, 0, R)--(R, 0)--cycle;
fill(posLobe, blue + opacity(0.25));

path negLobe = (-R, 0)--graph(f, -R, 0)--(0, 0)--cycle;
fill(negLobe, blue + opacity(0.25));

// curve, solid on [-R,R], dashed beyond to suggest R -> infty on both ends
draw(graph(f, xmin, -R), blue + linewidth(0.8) + dashed);
draw(graph(f, -R, R), blue + linewidth(1.6));
draw(graph(f, R, xmax), blue + linewidth(0.8) + dashed);
label("$y = \frac{x^2}{6}$", (R, f(R)), NW, blue);

// guides down to the axes
dropToXAxis((R, f(R)));
dropToXAxis((-R, f(-R)));
label("$R$", (R, -0.12));
label("$-R$", (-R, -0.12));

// equal, same-sign areas -- no cancellation
label("$+A$", (2.2, 0.35), blue);
label("$+A$", (-2.2, 0.35), blue);

// divergence caption
label("$\displaystyle\int_{-R}^{R} f(x)\,dx = A + A = 2A \to \infty \quad (R \to \infty)$", (0, ymax), N);
