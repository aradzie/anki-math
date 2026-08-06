// Refining a partition never decreases the lower sum: zoom on the
// subinterval [x_3,x_4] = [2.6,4] from lower_darboux_sum.asy, refined by
// adding a point x' = 3.3. f is decreasing throughout, so the infimum
// m_i = f(4) sits at the right endpoint. The piece [x', 4] still ends at
// that same point, so its infimum m_i'' stays unchanged; the piece
// [2.6, x'] no longer reaches down to x = 4, so its infimum m_i' strictly
// rises above m_i. Either way, neither new piece drops below the original
// height.

import graph;

size(12cm, 7cm, false);
defaultpen(fontsize(10pt));

real f(real x) { return 1 + 2 * sin(0.8 * x); }

real x0 = 2.6, x1 = 4, xp = 3.3;
real mi = f(x1);    // inf on [x0, x1], attained at x1
real mp = f(xp);    // inf on [x0, xp], attained at xp

real xmin = 2.4, xmax = 4.2, ymax = 3.0;

// axes
draw((xmin, 0)--(xmax, 0), Arrow(TeXHead));
draw((xmin, 0)--(xmin, ymax), invisible);
label("$x$", (xmax, 0), E);

// original rectangle (dashed), height m_i, over the whole subinterval
draw((x0, 0)--(x0, mi)--(x1, mi)--(x1, 0), dashed + linewidth(1));

// refined rectangles: left piece rises to m_i', right piece keeps height m_i
filldraw((x0, 0)--(x0, mp)--(xp, mp)--(xp, 0)--cycle, red + opacity(0.18), red + linewidth(0.8));
filldraw((xp, 0)--(xp, mi)--(x1, mi)--(x1, 0)--cycle, heavygreen + opacity(0.18), heavygreen + linewidth(0.8));

// curve
draw(graph(f, xmin, xmax), blue + linewidth(1.6));

// guides and labels
draw((xp, 0)--(xp, mp), dotted);
label("$x'$", (xp, 0), S);
label("$x_3$", (x0, 0), S);
label("$x_4$", (x1, 0), S);

label("$m_i$", (x1 + 0.15, mi), E);
label("$m_i' > m_i$", ((x0 + xp) / 2, mp + 0.15), N, red);
label("$m_i'' = m_i$", ((xp + x1) / 2, mi + 0.15), N, heavygreen);
