// int_{-a}^{a} f(x) dx = 2 int_0^a f(x) dx for even f, illustrated with
// f(x) = 0.3x^2 + 0.4. Since f(-x) = f(x), the lobe on [0,a] and the lobe
// on [-a,0] lie on the same side of the axis and have equal area, so the
// two halves simply double rather than cancel.

import graph;
import common;

size(12cm, 7cm);
mathdefaults();

real a = 2.2;

real f(real x) { return 0.3 * x^2 + 0.4; }

real ymax = 2.4;

// axes -- curve is labeled directly, so omit the generic y-axis label to
// leave headroom for the caption above
drawAxes(-a - 0.6, a + 0.6, -0.3, ymax, ylabel="");

// both lobes lie above the axis and are filled the same color, unlike the
// odd-function illustration's opposite-sign red/blue pair
path posLobe = (0, 0)--graph(f, 0, a)--(a, 0)--cycle;
fill(posLobe, blue + opacity(0.25));

path negLobe = (-a, 0)--graph(f, -a, 0)--(0, 0)--cycle;
fill(negLobe, blue + opacity(0.25));

// curve
draw(graph(f, -a, a), blue + linewidth(1.6));
label("$y=f(x)$", (a, f(a)), NE, blue);

// guides down to the axes
dropToXAxis((a, f(a)));
dropToXAxis((-a, f(-a)));
label("$a$", (a, 0), S);
label("$-a$", (-a, 0), S);

// equal, same-sign areas -- no cancellation
label("$+A$", (a / 2, 0.35), blue);
label("$+A$", (-a / 2, 0.35), blue);

label("$\displaystyle\int_{-a}^{a} f(x)\,dx = A + A = 2\int_0^a f(x)\,dx$", (0, ymax), N);
