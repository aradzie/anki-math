// Injective f : A -> B: distinct points of A map to distinct points of B.
// b4 is left unhit, showing injectivity says nothing about covering B.

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
closedPoint(b4, gray(0.4));

draw(a1--b1, gray(0.3), Arrow(TeXHead));
draw(a2--b2, gray(0.3), Arrow(TeXHead));
draw(a3--b3, gray(0.3), Arrow(TeXHead));

label("$A$", (-3, 2.0));
label("$B$", (3, 2.2));
label("injective", (0, -2.6));
label("distinct inputs $\to$ distinct outputs", (0, -3.0), fontsize(8pt));
