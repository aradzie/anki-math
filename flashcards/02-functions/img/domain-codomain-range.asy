// Mapping diagram for f : A -> B: the domain A on the left, the codomain B
// on the right, and a shaded sub-region of B marking the range f(A). One
// point of B (b4) is shaded but not marked as an image, showing it lies in
// the codomain without being attained -- the range is a strict subset.

import common;

size(11cm);
mathdefaults();

pair centerA = (-3, 0), centerB = (3, 0);
real aA = 1.3, bA = 1.7;
real aB = 1.9, bB = 2.1;

path ellipseA = ellipse(centerA, aA, bA);
path ellipseB = ellipse(centerB, aB, bB);

draw(ellipseA, black + linewidth(1));
draw(ellipseB, black + linewidth(1));

// range blob inside B, kept clear of B's boundary
path rangeBlob = (1.8, 0.6){dir(150)}..(2.3, 1.0)..(3.0, 0.7)..(3.3, 0.0)
    ..(3.0, -0.9)..(2.2, -1.0)..(1.7, -0.5){dir(190)}..cycle;
filldraw(rangeBlob, lightblue + opacity(0.5), blue + linewidth(0.9));

// points in A
pair a1 = (-3.5, 0.8), a2 = (-3.2, -0.6), a3 = (-2.6, 0.3);
closedPoint(a1);
closedPoint(a2);
closedPoint(a3);

// points hit in B (inside the range blob)
pair b1 = (2.1, 0.5), b2 = (2.7, -0.2), b3 = (2.5, -0.7);
closedPoint(b1);
closedPoint(b2);
closedPoint(b3);

// a point of B that is never hit -- in the codomain but not the range
pair b4 = (4.1, 0.1);
closedPoint(b4, gray(0.4));

draw(a1--b1, gray(0.3), Arrow(TeXHead));
draw(a2--b3, gray(0.3), Arrow(TeXHead));
draw(a3--b2, gray(0.3), Arrow(TeXHead));

label("$A$", (-3, 2.0));
label("(domain)", (-3, -2.1));
label("$B$", (3, 2.3));
label("(codomain)", (3, -2.4));

label("range", (2.5, 1.55));
draw((2.5, 1.4)--(2.45, 1.0), gray(0.3) + linewidth(0.6));

label("not attained", b4, N, gray(0.3) + fontsize(8pt));

label("$\operatorname{range}(f) \subseteq B$", (0, -2.7));
