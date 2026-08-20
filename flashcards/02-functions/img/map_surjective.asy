// Surjective f : A -> B: every point of B is hit at least once. b1 is hit
// twice, showing surjectivity says nothing about outputs being unique.

import common;

size(10cm);
mathdefaults();

pair centerA = (-3, 0), centerB = (3, 0);
path ellipseA = ellipse(centerA, 1.5, 1.9);
path ellipseB = ellipse(centerB, 1.3, 1.7);

draw(ellipseA, black + linewidth(1));
draw(ellipseB, black + linewidth(1));

pair a1 = (-3.6, 0.9), a2 = (-3.6, 0.0), a3 = (-2.6, -0.8), a4 = (-2.6, 0.9);
pair b1 = (3.3, 0.0), b2 = (2.7, -1.1), b3 = (3.4, 0.9);

closedPoint(a1); closedPoint(a2); closedPoint(a3); closedPoint(a4);
closedPoint(b1); closedPoint(b2); closedPoint(b3);

draw(a1--b1, gray(0.3), Arrow(TeXHead));
draw(a2--b1, gray(0.3), Arrow(TeXHead));
draw(a3--b2, gray(0.3), Arrow(TeXHead));
draw(a4--b3, gray(0.3), Arrow(TeXHead));

label("$A$", (-3, 2.2));
label("$B$", (3, 2.0));
label("surjective", (0, -2.6));
label("every output is hit at least once", (0, -3.0), fontsize(8pt));
