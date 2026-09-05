// Bijective f : A -> B: a perfect one-to-one correspondence -- every point
// of B is hit exactly once.

import common;

size(10cm);
mathdefaults();

pair centerA = (-3, 0), centerB = (3, 0);
path ellipseA = ellipse(centerA, 1.4, 1.8);
path ellipseB = ellipse(centerB, 1.4, 1.8);

draw(ellipseA, black + linewidth(1));
draw(ellipseB, black + linewidth(1));

pair a1 = (-3.4, 0.9), a2 = (-3.4, 0.0), a3 = (-2.6, -0.9);
pair b1 = (2.6, 0.9), b2 = (2.6, 0.0), b3 = (3.4, -0.9);

closedPoint(a1); closedPoint(a2); closedPoint(a3);
closedPoint(b1); closedPoint(b2); closedPoint(b3);

draw(a1--b1, gray(0.3), Arrow(TeXHead));
draw(a2--b2, gray(0.3), Arrow(TeXHead));
draw(a3--b3, gray(0.3), Arrow(TeXHead));

label("$A$", (-3, 2.1));
label("$B$", (3, 2.1));
label("bijective", (0, -2.6));
label("one-to-one correspondence between $A$ and $B$", (0, -3.0), fontsize(8pt));
