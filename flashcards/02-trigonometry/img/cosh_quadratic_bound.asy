// cosh(x) >= 1 + x^2/2 for all x: plots cosh(x) against the quadratic lower
// bound 1 + x^2/2, shading the gap between them to make the inequality
// visible, and marking the single point of tangency at x = 0 where both
// the values and slopes agree (g(0) = g'(0) = 0 in the flashcard's proof).

import graph;
import common;

size(11cm, 8cm, false);
mathdefaults();

real xmin = -2.15, xmax = 2.15;
real ymax = 5.4;

real coshx(real x) { return cosh(x); }
real quad(real x) { return 1 + x^2 / 2; }

drawAxes(xmin, xmax, -0.5, ymax);

// shaded gap between the quadratic bound and cosh, showing cosh >= quad
path gap = graph(quad, xmin, xmax) -- reverse(graph(coshx, xmin, xmax)) -- cycle;
fill(gap, blue + opacity(0.12));

// curves
draw(graph(coshx, xmin, xmax), blue + linewidth(1.3));
label("$\cosh x$", (xmax - 0.1, coshx(xmax - 0.1)), NW, blue);

draw(graph(quad, xmin, xmax), heavyred + dashed + linewidth(1.1));
label("$1+\dfrac{x^2}{2}$", (xmax - 0.1, xmax - 0.1), SW, heavyred);

// tangency at x = 0: equal value and equal slope
dot((0, 1), black);
label("$x=0$", (0, 1), SE, black);

label("$\cosh x \ge 1+\dfrac{x^2}{2}$", (0, ymax - 0.4));
