// Solution set of the homogeneous equation x - 2y = 0: a line through the
// origin. Two solutions v1, v2, their sum v1+v2, and a scalar multiple
// kv1 all remain on the line -- the geometric picture behind closure of a
// homogeneous system's solution set under addition and scalar
// multiplication.

import common;

size(12cm);
mathdefaults();

drawAxes(-1, 7, -1, 4);

pair dir = (2, 1);

draw(-0.8*dir--3.2*dir, gray + linewidth(1.0));
label("$x-2y=0$", 3.2*dir, NE, gray);

pair v1 = dir;
pair v2 = 2*dir;
pair vsum = v1 + v2;
pair kv1 = 0.5*dir;

draw((0,0)--v1, blue + linewidth(1.4), Arrow(TeXHead));
dot(v2, blue);
dot(vsum, heavygreen);
dot(kv1, red);

dot("$O$", (0,0), S);
label("$v_1$", v1, N, blue);
label("$v_2$", v2, N, blue);
label("$v_1+v_2$", vsum, N, heavygreen);
label("$kv_1$", kv1, S, red);
