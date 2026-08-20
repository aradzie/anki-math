// Right-triangle mnemonic for sin(arctan x) and cos(arctan x).
// Adjacent leg 1, opposite leg x, hypotenuse sqrt(1+x^2) by the
// Pythagorean theorem.

import common;

size(8cm);
mathdefaults();

real x = 1;

pair O = (0, 0);
pair A = (1, 0);
pair B = (1, x);

draw(O--A--B--cycle);

// right-angle mark at A
real m = 0.06;
draw((A.x - m, A.y)--(A.x - m, A.y + m)--(A.x, A.y + m));

// angle arc at O
real angO = atan(x / 1) * 180 / pi; // arctan x, in degrees
draw(arc(O, 0.2, 0, angO));
label("$\arctan x$", O + 0.32 * dir(angO / 2), NE);

// side labels
label("$1$", (O + A) / 2, S);
label("$x$", (A + B) / 2, E);
label("$\sqrt{1+x^2}$", (O + B) / 2, NW);

dot(O);
dot(A);
dot(B);
