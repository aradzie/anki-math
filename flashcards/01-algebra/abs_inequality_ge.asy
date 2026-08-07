// |x - a| >= c  <=>  x <= a - c  or  x >= a + c
// Solution is everything outside the closed interval [a-c, a+c].

import graph;

size(18cm, 6cm);
defaultpen(fontsize(10pt));

real a = 3;
real c = 2;
real lo = a - c;
real hi = a + c;
real xmin = lo - 1.5;
real xmax = hi + 1.5;

// number line
draw((xmin, 0)--(xmax, 0), Arrow(TeXHead));

// solution rays, shaded outward
draw((xmin, 0)--(lo, 0), blue + linewidth(2));
draw((hi, 0)--(xmax, 0), blue + linewidth(2));

// closed (included) endpoints
filldraw(circle((lo, 0), 0.08), blue);
filldraw(circle((hi, 0), 0.08), blue);
label("$a-c$", (lo, 0), S);
label("$a+c$", (hi, 0), S);

// center point a
dot((a, 0));
label("$a$", (a, 0), S);

// distance-c brackets on each side of a
draw((lo, 0.4)--(lo, 0.55)--(a, 0.55)--(a, 0.4));
label("$c$", ((lo + a) / 2, 0.55), N);

draw((a, 0.4)--(a, 0.55)--(hi, 0.55)--(hi, 0.4));
label("$c$", ((a + hi) / 2, 0.55), N);

label("$|x-a|\ge c$", (a, -0.5), S, blue);
