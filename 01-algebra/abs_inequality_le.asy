// |x - a| <= c  <=>  a - c <= x <= a + c
// Solution is the closed interval [a-c, a+c], centered at a with radius c.

import graph;

size(18cm, 6cm);
defaultpen(fontsize(10pt));

real a = 3;
real c = 2;
real lo = a - c;
real hi = a + c;

// number line
draw((lo - 1, 0)--(hi + 1, 0), Arrow(TeXHead));

// solution interval, shaded
draw((lo, 0)--(hi, 0), blue + linewidth(2));

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

label("$|x-a|\le c$", ((lo + hi) / 2, -0.5), S, blue);
