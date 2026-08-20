// The sign of a.b as a region of the plane relative to b: the line through
// the origin perpendicular to b (dashed) is where a.b = 0. Vectors a landing
// on the same side as b (green half) give a.b > 0 (acute theta); vectors on
// the opposite side (red half) give a.b < 0 (obtuse theta).

import common;

size(9cm);
mathdefaults();

pair O = (0, 0);
pair b = (2.6, 0);

pen bColor = red;
pen acuteColor = blue;
pen obtuseColor = deepgreen;

real halfHeight = 2.1;
real leftExtent = -2.4;
real rightExtent = 2.4;

// half-planes on either side of the boundary perpendicular to b
fill((0, -halfHeight)--(rightExtent, -halfHeight)--(rightExtent, halfHeight)--(0, halfHeight)--cycle,
     palegreen + opacity(0.35));
fill((leftExtent, -halfHeight)--(0, -halfHeight)--(0, halfHeight)--(leftExtent, halfHeight)--cycle,
     pink + opacity(0.35));

// boundary line a.b = 0, perpendicular to b through the origin
draw((0, -halfHeight)--(0, halfHeight), gray(0.4) + dashed);
label("$\mathbf{a}\cdot\mathbf{b}=0$", (0, halfHeight), N, gray(0.3));

// b, drawn from the origin
draw(O--b, bColor, Arrow(TeXHead));
label("$\mathbf{b}$", b, S, bColor);

// a in the acute region: a.b > 0
pair aAcute = 2.1 * dir(35);
draw(O--aAcute, acuteColor, Arrow(TeXHead));

// a in the obtuse region: a.b < 0
pair aObtuse = 2.1 * dir(150);
draw(O--aObtuse, obtuseColor, Arrow(TeXHead));

// inequality labels, centered horizontally in their half and dropped into
// the empty lower area so they clear the vectors and angle arcs above
label("$\mathbf{a}\cdot\mathbf{b}>0$", ((rightExtent) / 2, -halfHeight / 2), acuteColor);
label("$\mathbf{a}\cdot\mathbf{b}<0$", (leftExtent / 2, -halfHeight / 2), obtuseColor);

// angle theta_1 between b and the acute a, and theta_2 between b and the
// obtuse a -- nested arcs (smaller radius for the smaller angle) sharing b
// as their common side
draw(arc(O, 0.5, 0, 35), acuteColor);
label("$\theta_1$", 0.65 * dir(17.5), acuteColor);

draw(arc(O, 0.85, 0, 150), obtuseColor);
label("$\theta_2$", 1.05 * dir(75), obtuseColor);
