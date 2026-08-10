// The epsilon-delta definition of continuity: for the band of half-width
// epsilon around f(c), there is a neighborhood of half-width delta around c
// whose image under f lies entirely inside that band.

import graph;
import common;

size(14cm, 12cm);
mathdefaults();

real c = 3;
real eps = 1;
real delta = 1;

real f(real x) { return 0.15 * (x - c)^3 + 0.6 * (x - c) + 3; }

real fc = f(c);

real curveMin = 1, curveMax = 5;
real axMin = -0.3, axMax = 6.3;

// axes
drawAxes(axMin, axMax, axMin, axMax);

// the delta-by-epsilon box: the curve over [c-delta, c+delta] must stay
// inside this box for delta to "work" for this epsilon
filldraw(box((c - delta, fc - eps), (c + delta, fc + eps)), gray + opacity(0.08), nullpen);

// curve
draw(graph(f, curveMin, curveMax), blue + linewidth(1.2));

// epsilon band around f(c)
draw((axMin, fc - eps)--(axMax, fc - eps), heavygreen + dashed);
draw((axMin, fc + eps)--(axMax, fc + eps), heavygreen + dashed);
label("$f(c)+\varepsilon$", (axMin, fc + eps), W, heavygreen);
label("$f(c)-\varepsilon$", (axMin, fc - eps), W, heavygreen);

// delta neighborhood around c
draw((c - delta, axMin)--(c - delta, axMax), purple + dashed);
draw((c + delta, axMin)--(c + delta, axMax), purple + dashed);
label("$c-\delta$", (c - delta, axMin), S, purple);
label("$c+\delta$", (c + delta, axMin), S, purple);

// the portion of the curve guaranteed to lie inside the epsilon band
draw(graph(f, c - delta, c + delta), heavygreen + linewidth(2));

// guides and the point (c, f(c))
dropToXAxis((c, fc));
dropToYAxis((c, fc));
label("$c$", (c, 0), S);
label("$f(c)$", (0, fc), W);
closedPoint((c, fc));
label("$(c, f(c))$", (c, fc), NW);
