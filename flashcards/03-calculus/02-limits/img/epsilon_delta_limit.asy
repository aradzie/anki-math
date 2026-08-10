// The epsilon-delta definition of a limit: for the band of half-width
// epsilon around L, there is a punctured neighborhood of half-width delta
// around c -- excluding c itself -- whose image under f lies entirely
// inside that band. Whether f(c) is even defined plays no role.

import graph;
import common;

size(14cm, 12cm);
mathdefaults();

real c = 3;
real L = 3;
real eps = 1;
real delta = 1;
real gap = 0.15; // half-width of the visual gap at x = c

real f(real x) { return 0.15 * (x - c)^3 + 0.6 * (x - c) + L; }

real curveMin = 1, curveMax = 5;
real axMin = -0.3, axMax = 6.3;

// axes
drawAxes(axMin, axMax, axMin, axMax);

// the delta-by-epsilon box
filldraw(box((c - delta, L - eps), (c + delta, L + eps)), gray + opacity(0.08), nullpen);

// curve, with a gap at x = c: f(c) plays no role in the limit
draw(graph(f, curveMin, c - gap), blue + linewidth(1.2));
draw(graph(f, c + gap, curveMax), blue + linewidth(1.2));

// epsilon band around L
draw((axMin, L - eps)--(axMax, L - eps), heavygreen + dashed);
draw((axMin, L + eps)--(axMax, L + eps), heavygreen + dashed);
label("$L+\varepsilon$", (axMin, L + eps), W, heavygreen);
label("$L-\varepsilon$", (axMin, L - eps), W, heavygreen);

// delta neighborhood around c
draw((c - delta, axMin)--(c - delta, axMax), purple + dashed);
draw((c + delta, axMin)--(c + delta, axMax), purple + dashed);
label("$c-\delta$", (c - delta, axMin), S, purple);
label("$c+\delta$", (c + delta, axMin), S, purple);

// the portions of the curve guaranteed to lie inside the epsilon band,
// on both sides of the puncture at c
draw(graph(f, c - delta, c - gap), heavygreen + linewidth(2));
draw(graph(f, c + gap, c + delta), heavygreen + linewidth(2));

// c on the x-axis, and the open circle at (c, L): the limit value, which
// need not equal (or even be) f(c)
label("$c$", (c, 0), S);
label("$L$", (0, L), W);
draw((0, L)--(c, L), gray + dotted);
openPoint((c, L));
label("$(c, L)$", (c, L), NW);
