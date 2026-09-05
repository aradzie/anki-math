// Range and stability picture for the real infinite power tower.
// Fixed points y = x^y are parametrized by x = y^(1/y).  The attracting
// fixed points are exactly those with 1/e <= y <= e.

import graph;

size(12cm);
defaultpen(fontsize(10pt));

real ymin = 0.12;
real ymax = 5.2;
real e = exp(1);
real lowerY = 1/e;
real upperY = e;
real lowerX = exp(-e);
real upperX = exp(1/e);

real f(real y) { return exp(log(y)/y); }

pair P(real y) { return (y, f(y)); }

// axes
draw((0, 0)--(ymax + 0.25, 0), Arrow(TeXHead));
draw((0, 0)--(0, upperX + 0.25), Arrow(TeXHead));
label("$y$", (ymax + 0.25, 0), E);
label("$x$", (0, upperX + 0.25), N);

// stable part of the curve first, with a light band underneath
guide stableBand = (lowerY, 0)--graph(f, lowerY, upperY)--(upperY, 0)--cycle;
fill(stableBand, lightgreen + opacity(0.18));
draw(graph(f, ymin, lowerY), blue + linewidth(1.0));
draw(graph(f, lowerY, upperY), heavygreen + linewidth(1.6));
draw(graph(f, upperY, ymax), blue + linewidth(1.0));

label("$x=y^{1/y}$", P(4.2), NE, blue);
label("attracting fixed points", (1.45, 0.55), N, heavygreen);

// endpoint guides
draw((lowerY, 0)--P(lowerY), dashed + gray(0.55));
draw((0, lowerX)--P(lowerY), dashed + gray(0.55));
draw((upperY, 0)--P(upperY), dashed + gray(0.55));
draw((0, upperX)--P(upperY), dashed + gray(0.55));

// reference line at y=1
draw((1, 0)--P(1), dotted + gray(0.45));

label("$1/e$", (lowerY, 0), S);
label("$1$", (1, 0), S);
label("$e$", (upperY, 0), S);
label("$e^{-e}$", (0, lowerX), W);
label("$1$", (0, 1), W);
label("$e^{1/e}$", (0, upperX), W);

dot("$(1/e,e^{-e})$", P(lowerY), SE);
dot("$(e,e^{1/e})$", P(upperY), NE);
dot("$(1,1)$", P(1), NE);
