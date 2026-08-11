// Geometric picture of the dot product: a (blue) and b (red) from a common
// origin, with theta the angle between them, per a.b = |a||b|cos(theta).

import common;

size(9cm);
mathdefaults();

pair O = (0, 0);
real theta = 50;

pair a = 3.0 * dir(theta);
pair b = (3.2, 0);

pen aColor = blue;
pen bColor = red;

// a and b, drawn from the origin
draw(O--a, aColor, Arrow(TeXHead));
draw(O--b, bColor, Arrow(TeXHead));

// angle theta between a and b
draw(arc(O, 0.7, 0, theta));
label("$\theta$", O + 0.95 * dir(theta / 2), N);

// labels
label("$\mathbf{a}$", a, NW, aColor);
label("$\mathbf{b}$", b, S, bColor);
