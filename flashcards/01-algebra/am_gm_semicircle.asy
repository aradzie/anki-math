// AM-GM inequality, geometric proof via semicircle.
// Diameter L--R has length a+b, split at M into segments a and b.
// By Thales, angle LPR = 90 at the point P on the semicircle above M,
// so PM^2 = LM * MR = ab, i.e. PM = sqrt(ab): the altitude equals the
// geometric mean. The radius CT = (a+b)/2 is the arithmetic mean, and
// since it is the longest distance from the diameter to the circle,
// CT >= PM, i.e. (a+b)/2 >= sqrt(ab), with equality iff M = C (a = b).

import geometry;
import common;

size(14cm);
mathdefaults();

real a = 1.5;
real b = 4;
real r = (a + b) / 2;

pair L = (0, 0);
pair R = (a + b, 0);
pair C = (r, 0);
pair M = (a, 0);
real h = sqrt(a * b);
pair P = (a, h);
pair T = (r, r);

// semicircle and diameter
draw(arc(C, r, 0, 180));
draw(L--R);

// right triangle L-P-R (Thales)
draw(L--P--R, gray);

// altitude PM: the geometric mean
draw(M--P, red + linewidth(1.2));
label("$\sqrt{ab}$", (M + P) / 2, E, red);

// radius CT: the arithmetic mean
draw(C--T, heavygreen + linewidth(1.2));
label("$\frac{a+b}{2}$", (C + T) / 2, W, heavygreen);

dot("$L$", L, SW);
dot(M);
dot(C);
dot("$R$", R, SE);
dot("$P$", P, N);

label("$a$", (L + M) / 2, S);
label("$b$", (M + R) / 2, S);
