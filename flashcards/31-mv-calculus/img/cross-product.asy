// Geometric picture of the cross product: a (blue) and b (red) span a
// parallelogram whose area equals |a x b|, with theta the angle between
// them. a x b (purple) is drawn schematically pointing straight up, out of
// the plane spanned by a and b, per the right-hand rule.

import common;

size(9cm);
mathdefaults();

pair O = (0, 0);
real theta = 50;

pair a = (3.2, 0);
pair b = 2.3 * dir(theta);
pair apb = a + b;

pen aColor = blue;
pen bColor = red;
pen crossColor = purple;

// parallelogram spanned by a and b (edges from O along a and b are drawn
// separately below, as the colored vectors themselves)
draw(a--apb--b, black);

// a and b, drawn from the origin
draw(O--a, aColor, Arrow(TeXHead));
draw(O--b, bColor, Arrow(TeXHead));

// angle theta between a and b
draw(arc(O, 0.6, 0, theta));
label("$\theta$", O + 0.85 * dir(theta / 2), E);

// a x b: perpendicular to the plane spanned by a and b, shown schematically
// pointing straight up, out of the page
pair cross = (0, 3.6);
draw(O--cross, crossColor, Arrow(TeXHead));

// labels
label("$\mathbf{a}$", a, S, aColor);
label("$\mathbf{b}$", 0.55 * b, NW, bColor);
label("$\mathbf{a}\times\mathbf{b}$", cross, N, crossColor);
label("$|\mathbf{a}\times\mathbf{b}|$", (O + a + apb + b) / 4);
