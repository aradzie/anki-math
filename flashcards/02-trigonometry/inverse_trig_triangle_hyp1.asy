// Right-triangle mnemonic for cos(arcsin x) and sin(arccos x), x in (0,1).
// Hypotenuse 1, legs x and sqrt(1-x^2) by the Pythagorean theorem. The two
// acute angles are complementary: arcsin x (opposite the leg x) and
// arccos x (opposite the leg sqrt(1-x^2)).

import common;

size(8cm);
mathdefaults();

real x = 0.6;
real adj = sqrt(1 - x^2); // 0.8

pair O = (0, 0);
pair A = (adj, 0);
pair B = (adj, x);

draw(O--A--B--cycle);

// right-angle mark at A
real m = 0.06;
draw((A.x - m, A.y)--(A.x - m, A.y + m)--(A.x, A.y + m));

// angle arcs
real angO = atan(x / adj) * 180 / pi; // arcsin x, in degrees
draw(arc(O, 0.18, 0, angO));
label("$\arcsin x$", O + 0.28 * dir(angO / 2), NE);

real angB1 = 180 + angO;
draw(arc(B, 0.18, angB1, 270));
label("$\arccos x$", B + 0.3 * dir((angB1 + 270) / 2), SW);

// side labels
label("$\sqrt{1-x^2}$", (O + A) / 2, S);
label("$x$", (A + B) / 2, E);
label("$1$", (O + B) / 2, NW);

dot(O);
dot(A);
dot(B);
