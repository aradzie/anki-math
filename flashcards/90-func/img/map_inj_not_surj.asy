// f injective but not surjective: b4 has no preimage in A, so trying to
// build f^{-1}(b4) has nothing to point to -- the attempted red arrow
// dead-ends before reaching A.

import common;

size(10cm);
mathdefaults();

pair centerA = (-3, 0), centerB = (3, 0);
path ellipseA = ellipse(centerA, 1.3, 1.7);
path ellipseB = ellipse(centerB, 1.5, 1.9);

draw(ellipseA, black + linewidth(1));
draw(ellipseB, black + linewidth(1));

pair a1 = (-3.4, 0.7), a2 = (-3.2, -0.5), a3 = (-2.6, 0.1);
pair b1 = (2.5, 0.8), b2 = (2.6, -0.2), b3 = (2.4, -1.1), b4 = (3.9, 1.1);

closedPoint(a1); closedPoint(a2); closedPoint(a3);
closedPoint(b1); closedPoint(b2); closedPoint(b3);
closedPoint(b4, red);

draw(a1--b1, gray(0.3), Arrow(TeXHead));
draw(a2--b2, gray(0.3), Arrow(TeXHead));
draw(a3--b3, gray(0.3), Arrow(TeXHead));

// attempted inverse arrow from b4, dead-ending before it reaches A
pair stop = (-0.2, 1.3);
draw(b4--stop, red + dashed, Arrow(TeXHead));
real r = 0.09;
draw((stop.x - r, stop.y - r)--(stop.x + r, stop.y + r), red + linewidth(1.2));
draw((stop.x - r, stop.y + r)--(stop.x + r, stop.y - r), red + linewidth(1.2));

label("$A$", (-3, 2.0));
label("$B$", (3, 2.2));
label("$f^{-1}(b_4) = \, ?$", stop, N, red);
label("injective, not surjective", (0, -2.6));
