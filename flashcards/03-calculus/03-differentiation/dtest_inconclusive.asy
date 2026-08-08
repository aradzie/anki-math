// f''(c) = 0 is inconclusive: at c = 0, f(x) = x^4 has a local minimum,
// f(x) = -x^4 has a local maximum, and f(x) = x^3 has neither -- all three
// share f'(0) = f''(0) = 0.

import graph;
import common;

size(20cm, 9cm, false);
mathdefaults();

real xr = 1.4;
real panelHalfWidth = 1.7;

// --- panel 1: x^4, local minimum ---
real dx1 = 0;
real f1(real x) { return (x - dx1)^4; }
drawAxes(dx1 - panelHalfWidth, dx1 + panelHalfWidth, -5, 5, originx=dx1);
draw(graph(f1, dx1 - xr, dx1 + xr), blue + linewidth(1.2));
dot((dx1, 0));
label("$c$", (dx1, 0), NE);
label("$f(x) = x^4$", (dx1, -3), S, blue);
label("local minimum", (dx1, -4.2), S, blue);

// --- panel 2: -x^4, local maximum ---
real dx2 = 4;
real f2(real x) { return -(x - dx2)^4; }
drawAxes(dx2 - panelHalfWidth, dx2 + panelHalfWidth, -5, 5, originx=dx2);
draw(graph(f2, dx2 - xr, dx2 + xr), blue + linewidth(1.2));
dot((dx2, 0));
label("$c$", (dx2, 0), NE);
label("$f(x) = -x^4$", (dx2, -3), S, blue);
label("local maximum", (dx2, -4.2), S, blue);

// --- panel 3: x^3, not an extremum ---
real dx3 = 8;
real f3(real x) { return (x - dx3)^3; }
drawAxes(dx3 - panelHalfWidth, dx3 + panelHalfWidth, -5, 5, originx=dx3);
draw(graph(f3, dx3 - xr, dx3 + xr), blue + linewidth(1.2));
dot((dx3, 0));
label("$c$", (dx3, 0), NE);
label("$f(x) = x^3$", (dx3, -3), S, blue);
label("not an extremum", (dx3, -4.2), S, blue);
