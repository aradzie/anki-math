// Triangle inequality: |a + b| <= |a| + |b|.
// Going straight from O to a+b (green) is never longer than going via a
// first (blue leg, then red leg) -- the direct side of a triangle is at
// most the sum of the other two sides.

import geometry;

size(12cm);
defaultpen(fontsize(10pt));

pair O = (0, 0);
pair A = (2, 1);       // vector a
pair AB = (3, 3);      // vector a + b

// the two-leg path: a, then b
draw(O--A, blue + linewidth(1.2), Arrow(TeXHead));
draw(A--AB, red + linewidth(1.2), Arrow(TeXHead));

// the direct path: a + b
draw(O--AB, heavygreen + linewidth(1.2), Arrow(TeXHead));

label("$a$", (O + A) / 2, S, blue);
label("$b$", (A + AB) / 2, E, red);
label("$a+b$", 0.4 * AB, NW, heavygreen);

dot("$O$", O, SW);
dot(A);
dot("$a+b$", AB, NE);

label("$|a+b| \le |a| + |b|$", (O + AB) / 2 + (0, -1), S);
