// Cauchy principal value with an interior singularity: int_a^b f(x) dx
// where f is unbounded at c in (a,b), illustrated with f(x) = 1/(x-c). The
// defining limit removes a symmetric epsilon-neighborhood of c from both
// sides at once:
//   p.v. int_a^b f(x) dx
//     = lim_{eps -> 0+} ( int_a^{c-eps} f(x) dx + int_{c+eps}^b f(x) dx ),
// shown as two shaded regions shrinking toward the vertical asymptote at
// x = c together as eps -> 0+.

import graph;
import common;

size(11cm, 7cm);
mathdefaults();

real a = 0.3;
real b = 4.2;
real c = 2.25;
real eps = 0.45;
real ymax = 3;

real f(real x) { return 1 / (x - c); }

real xNearLeft = c - 1 / ymax;
real xNearRight = c + 1 / ymax;

// axes
drawAxes(0, b + 0.4, -(ymax + 0.3), ymax + 0.5);

// shaded region: int_a^{c-eps} f(x) dx, below the axis
path leftRegion = (a, 0)--graph(f, a, c - eps)--(c - eps, 0)--cycle;
fill(leftRegion, blue + opacity(0.25));

// shaded region: int_{c+eps}^b f(x) dx, above the axis
path rightRegion = (c + eps, 0)--graph(f, c + eps, b)--(b, 0)--cycle;
fill(rightRegion, blue + opacity(0.25));

// curve, solid on the active ranges, dashed as it approaches the
// asymptote at c on either side
draw(graph(f, a, c - eps), blue + linewidth(1.6));
draw(graph(f, c - eps, xNearLeft), blue + linewidth(0.8) + dashed);
draw(graph(f, xNearRight, c + eps), blue + linewidth(0.8) + dashed);
draw(graph(f, c + eps, b), blue + linewidth(1.6));
label("$y = \frac{1}{x-c}$", (c + eps, f(c + eps)), NE, blue);

// asymptote at the singularity
verticalGuide((c, 0), -(ymax + 0.3), ymax + 0.5);
label("$c$", (c, ymax + 0.15));

// guides down to the axes -- tick labels sit on the side away from the
// local shading so they don't land inside a lobe
dropToXAxis((a, f(a)));
dropToXAxis((b, f(b)));
dropToXAxis((c - eps, f(c - eps)));
dropToXAxis((c + eps, f(c + eps)));
label("$a$", (a, 0.2));
label("$b$", (b, -0.2));
label("$c-\varepsilon$", (c - eps, 0.2));
label("$c+\varepsilon$", (c + eps, -0.2));

// integral labels over each region
label("$\displaystyle\int_a^{c-\varepsilon} f$", (1.2, -0.5));
label("$\displaystyle\int_{c+\varepsilon}^b f$", (3.3, 0.5));
