// Contrasting u=x+y (unnormalized) with the true rotated coordinate
// r=(x+y)/sqrt(2) along the same diagonal direction y=x: since u=sqrt(2) r,
// the point where u=1 sits closer to the origin than the point where r=1.
// The v,s pair along y=-x behaves identically by symmetry.

import common;

size(11cm, 9cm);
mathdefaults();

real xmax = 2.0, ymax = 1.8;

draw((-0.3, 0)--(xmax, 0), Arrow(TeXHead));
draw((0, -ymax)--(0, ymax), Arrow(TeXHead));
label("$x$", (xmax, 0), E);
label("$y$", (0, ymax), N);

// diagonal directions
real aLen = 1.65;
draw((0, 0)--(aLen, aLen), heavygreen + dashed);
draw((0, 0)--(aLen, -aLen), heavyred + dashed);
label("$u$-direction", (aLen, aLen), N, heavygreen);
label("$v$-direction", (aLen, -aLen), S, heavyred);

// on the u-direction: mark where u=1 (at Euclidean distance 1/sqrt(2))
// and where r=1 (at Euclidean distance 1)
pair uTick = (1 / sqrt(2)) * (1, 1) / sqrt(2);
pair rTick = 1 * (1, 1) / sqrt(2);
dot(uTick, heavygreen);
dot(rTick, heavygreen);
draw(uTick - 0.06 * (1, -1)--uTick + 0.06 * (1, -1), heavygreen);
draw(rTick - 0.06 * (1, -1)--rTick + 0.06 * (1, -1), heavygreen);
label("$u=1$", uTick, dir(135), heavygreen);
label("$r=1$", rTick, dir(-45), heavygreen);

// mirror on the v-direction
pair vTick = (1 / sqrt(2)) * (1, -1) / sqrt(2);
pair sTick = 1 * (1, -1) / sqrt(2);
dot(vTick, heavyred);
dot(sTick, heavyred);
draw(vTick - 0.06 * (1, 1)--vTick + 0.06 * (1, 1), heavyred);
draw(sTick - 0.06 * (1, 1)--sTick + 0.06 * (1, 1), heavyred);
label("$v=1$", vTick, dir(-135), heavyred);
label("$s=1$", sTick, dir(45), heavyred);

label("$u=\sqrt{2}\,r,\quad v=\sqrt{2}\,s$", (0.1, -ymax + 0.25), E, fontsize(9pt));
