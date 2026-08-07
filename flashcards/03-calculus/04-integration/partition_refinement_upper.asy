// Refining a partition never increases the upper sum: zoom on the
// subinterval [x_3,x_4] = [2.6,4] from upper_darboux_sum.asy, refined by
// adding a point x' = 3.3. f is decreasing throughout, so the supremum
// M_i = f(2.6) sits at the left endpoint. The piece [2.6, x'] still starts
// at that same point, so its supremum M_i' stays unchanged; the piece
// [x', 4] no longer reaches up to x = 2.6, so its supremum M_i'' strictly
// drops below M_i. Either way, neither new piece exceeds the original
// height.

import graph;

size(12cm, 7cm, false);
defaultpen(fontsize(10pt));

real f(real x) { return 1 + 2 * sin(0.8 * x); }

real x0 = 2.6, x1 = 4, xp = 3.3;
real Mi = f(x0);    // sup on [x0, x1], attained at x0
real Mpp = f(xp);   // sup on [xp, x1], attained at xp

real xmin = 2.4, xmax = 4.2, ymax = 3.0;

// axes
draw((xmin, 0)--(xmax, 0), Arrow(TeXHead));
draw((xmin, 0)--(xmin, ymax), invisible);
label("$x$", (xmax, 0), E);

// original rectangle (dashed), height M_i, over the whole subinterval
draw((x0, 0)--(x0, Mi)--(x1, Mi)--(x1, 0), dashed + linewidth(1));

// refined rectangles: left piece keeps height M_i, right piece drops to M_i''
filldraw((x0, 0)--(x0, Mi)--(xp, Mi)--(xp, 0)--cycle, red + opacity(0.18), red + linewidth(0.8));
filldraw((xp, 0)--(xp, Mpp)--(x1, Mpp)--(x1, 0)--cycle, heavygreen + opacity(0.18), heavygreen + linewidth(0.8));

// curve
draw(graph(f, xmin, xmax), blue + linewidth(1.6));

// guides and labels
draw((xp, 0)--(xp, Mpp), dotted);
label("$x'$", (xp, 0), S);
label("$x_3$", (x0, 0), S);
label("$x_4$", (x1, 0), S);

label("$M_i$", (x0 - 0.15, Mi), W);
label("$M_i' = M_i$", ((x0 + xp) / 2, Mi + 0.15), N, red);
label("$M_i'' < M_i$", ((xp + x1) / 2, Mpp + 0.15), N, heavygreen);
