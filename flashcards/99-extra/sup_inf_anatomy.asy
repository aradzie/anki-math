// General anatomy of sup/inf: a bounded set A, its tightest bounds (sup A,
// inf A), and looser bound candidates (M, m) for contrast. Conceptual, not
// tied to concrete numbers.

import graph;

size(20cm, 6cm);
defaultpen(fontsize(10pt));

real xmin = -1;
real xmax = 11;

// number line
draw((xmin, 0)--(xmax, 0), Arrows(TeXHead));

// set A: a handful of irregularly spaced points (not an interval)
filldraw(circle((4, 0), 0.08), blue);
filldraw(circle((4.6, 0), 0.08), blue);
filldraw(circle((5.1, 0), 0.08), blue);
filldraw(circle((5.7, 0), 0.08), blue);
filldraw(circle((6.2, 0), 0.08), blue);
label("$A$", (5.1, 0.6), N, blue);

// tightest upper bound: sup A, just past the rightmost point of A
real supA = 6.8;
draw((supA, -0.3)--(supA, 0.3), dashed);
label("$\sup A$", (supA, 0.5), N);

// a looser upper bound M
real M = 8.6;
draw((M, -0.3)--(M, 0.3), dashed);
label("$M$", (M, 0.5), N);
draw((supA, -0.8)--(M, -0.8), red, Arrow(TeXHead));
label("also an upper bound, not least", ((supA + M) / 2, -1.1), S, red);

// tightest lower bound: inf A, just before the leftmost point of A
real infA = 3.4;
draw((infA, -0.3)--(infA, 0.3), dashed);
label("$\inf A$", (infA, 0.5), N);

// a looser lower bound m
real m = 1.2;
draw((m, -0.3)--(m, 0.3), dashed);
label("$m$", (m, 0.5), N);
draw((m, -0.8)--(infA, -0.8), red, Arrow(TeXHead));
label("also a lower bound, not greatest", ((m + infA) / 2, -1.1), S, red);
