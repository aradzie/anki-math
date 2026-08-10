// Oscillating (essential) discontinuity: f(x) = sin(1/x) is undefined at
// x = 0, and as x -> 0+, 1/x grows without bound, so f oscillates through
// every value in [-1,1] infinitely often -- neither one-sided limit
// exists, but not because f blows up like 1/x does.

import graph;
import common;

size(14cm, 9cm);
mathdefaults();

real f(real x) { return sin(1 / x); }

real xmin = 0.01, xmax = 1.05;
real ymin = -1.4, ymax = 1.4;

// axes
drawAxes(-0.05, xmax, ymin, ymax);

// envelope band the oscillation stays within
draw((-0.05, 1)--(xmax, 1), heavygreen + dashed);
draw((-0.05, -1)--(xmax, -1), heavygreen + dashed);
label("$y=1$", (xmax, 1), E, heavygreen);
label("$y=-1$", (xmax, -1), E, heavygreen);

// the curve itself, densely sampled to capture the growing oscillation
// frequency as x -> 0+
draw(graph(f, xmin, xmax, n=4000), blue + linewidth(0.9));
label("$f(x)=\sin(1/x)$", (0.75, 1.2), N, blue);

label("undefined at $x=0$, oscillates infinitely often as $x\to 0^+$", (0.5, -1.2), red);
