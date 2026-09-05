// sqrt(a+b) <= sqrt(a) + sqrt(b), via the Pythagorean theorem and the
// ordinary triangle inequality: legs sqrt(a) and sqrt(b) meet at a right
// angle, so the hypotenuse has length sqrt(a+b) -- and since a hypotenuse
// is at most the sum of the other two sides, sqrt(a+b) <= sqrt(a)+sqrt(b).

import geometry;
import common;

size(10cm);
mathdefaults();

pair O = (0, 0);
pair A = (0, 2.2);     // leg sqrt(a), vertical
pair B = (3.1, 0);     // leg sqrt(b), horizontal

draw(O--A, blue + linewidth(1.2));
draw(O--B, red + linewidth(1.2));
draw(A--B, heavygreen + linewidth(1.2));

// right-angle marker at O
real s = 0.25;
draw((0, s)--(s, s)--(s, 0));

label("$\sqrt{a}$", (O + A) / 2, W, blue);
label("$\sqrt{b}$", (O + B) / 2, S, red);
label("$\sqrt{a+b}$", (A + B) / 2, NE, heavygreen);

dot("$O$", O, SW);
dot(A);
dot(B);
