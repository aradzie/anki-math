// Second derivative test at a stationary point c (f'(c) = 0):
// f''(c) > 0 (concave up) gives a local minimum; f''(c) < 0 (concave down)
// gives a local maximum.

import graph;
import common;

size(19cm, 10cm, false);
mathdefaults();

real cOffset = 1.5;
real tangentHalfWidth = 1.2;

// --- left panel: f''(c) > 0, local minimum ---
real x0 = 0;
real c1 = x0 + cOffset;
real fMin(real x) { return 0.4*(x - c1)^2 + 1; }

drawAxes(x0 - 1.3, x0 + 4.3, -0.5, 5, originx=x0);

draw(graph(fMin, c1 - 2.5, c1 + 2.5), blue + linewidth(1.2));
draw((c1 - tangentHalfWidth, fMin(c1))--(c1 + tangentHalfWidth, fMin(c1)), red + dashed);
dropToXAxis((c1, fMin(c1)), gray + dotted);
dot((c1, fMin(c1)));
label("$c$", (c1, 0), S);
label("$f''(c) > 0$: local minimum", (c1, -0.5), S, blue);

// --- right panel: f''(c) < 0, local maximum ---
real dx = 6.1;
real c2 = dx + cOffset;
real fMax(real x) { return -0.4*(x - c2)^2 + 4; }

drawAxes(dx - 1.3, dx + 4.3, -0.5, 5, originx=dx);

draw(graph(fMax, c2 - 2.5, c2 + 2.5), blue + linewidth(1.2));
draw((c2 - tangentHalfWidth, fMax(c2))--(c2 + tangentHalfWidth, fMax(c2)), red + dashed);
dropToXAxis((c2, fMax(c2)), gray + dotted);
dot((c2, fMax(c2)));
label("$c$", (c2, 0), S);
label("$f''(c) < 0$: local maximum", (c2, -0.5), S, blue);
