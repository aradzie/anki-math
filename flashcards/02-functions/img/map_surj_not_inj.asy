// f surjective but not injective: b1 has two preimages, a1 and a2, so
// trying to build f^{-1}(b1) doesn't know which one to point to -- shown
// as two competing red return arrows.

import common;

size(10cm);
mathdefaults();

pair centerA = (-3, 0), centerB = (3, 0);
path ellipseA = ellipse(centerA, 1.5, 1.9);
path ellipseB = ellipse(centerB, 1.6, 1.7);

draw(ellipseA, black + linewidth(1));
draw(ellipseB, black + linewidth(1));

pair a1 = (-3.6, 0.5), a2 = (-3.6, -0.4), a3 = (-2.6, -0.8), a4 = (-2.6, 0.9);
pair b1 = (3.1, 0.1), b2 = (2.9, -0.9), b3 = (3.2, 1.1);

closedPoint(a1, red); closedPoint(a2, red); closedPoint(a3); closedPoint(a4);
closedPoint(b1); closedPoint(b2); closedPoint(b3);

draw(a1--b1, gray(0.3), Arrow(TeXHead));
draw(a2--b1, gray(0.3), Arrow(TeXHead));
draw(a3--b2, gray(0.3), Arrow(TeXHead));
draw(a4--b3, gray(0.3), Arrow(TeXHead));

// two competing attempted inverse arrows from b1
draw(b1--(a1 + 0.15 * (b1 - a1)), red + dashed, Arrow(TeXHead));
draw(b1--(a2 + 0.15 * (b1 - a2)), red + dashed, Arrow(TeXHead));

label("$A$", (-3, 2.2));
label("$B$", (3, 2.0));
label("$f^{-1}(b_1) = a_1 \text{ or } a_2 \, ?$", b1, N, red);
label("surjective, not injective", (0, -2.6));
