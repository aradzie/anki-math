// f(x) = |x| is continuous at c = 0 -- the two arms meet exactly at
// (0, 0), with no jump or hole -- but the one-sided derivatives disagree:
// slope -1 on the left, slope +1 on the right. The corner is the visual
// signature of that disagreement.

import graph;
import common;

size(14cm, 12cm);
mathdefaults();

real f(real x) { return abs(x); }

real xmin = -2.3, xmax = 2.3;
real ymin = -0.3, ymax = 2.3;

// axes
drawAxes(xmin, xmax, ymin, ymax);

// curve: two straight arms meeting at the corner
draw((-2, 2)--(0, 0), blue + linewidth(1.2));
draw((0, 0)--(2, 2), blue + linewidth(1.2));
label("$f(x)=|x|$", (1.6, f(1.6)), NW, blue);

// left arm: slope triangle showing rise/run = -1
pair lA = (-1.2, f(-1.2));
pair lB = (-0.7, f(-1.2));
pair lC = (-0.7, f(-0.7));
draw(lA--lB, red + dashed);
draw(lB--lC, red + dashed);
label("$1$", (lA + lB) / 2, N, red);
label("$1$", (lB + lC) / 2, E, red);
label("$f'(0^-)=-1$", (-1.7, 1.05), red);

// right arm: slope triangle showing rise/run = +1
pair rA = (0.7, f(0.7));
pair rB = (1.2, f(0.7));
pair rC = (1.2, f(1.2));
draw(rA--rB, red + dashed);
draw(rB--rC, red + dashed);
label("$1$", (rA + rB) / 2, S, red);
label("$1$", (rB + rC) / 2, E, red);
label("$f'(0^+)=1$", (1.7, 1.05), red);

// the corner: continuous, since f(0) = 0 matches both one-sided limits
closedPoint((0, 0));
label("$(0,0)$", (0, 0), SE);
