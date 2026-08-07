// A = {x in Q : x^2 < 2} is bounded above in Q (e.g. by 2) but has no least
// upper bound in Q: the candidate sqrt(2) is irrational, a "gap" in Q.
// Dot spacing is compressed for legibility, not to true numeric scale.

import graph;

texpreamble("\usepackage{amssymb}");

size(20cm, 5cm);
defaultpen(fontsize(10pt));

real xmin = -0.5;
real xmax = 7.5;

draw((xmin, 0)--(xmax, 0), Arrows(TeXHead));

// rationals approaching sqrt(2) from below
filldraw(circle((0.5, 0), 0.08), blue);
label("$1$", (0.5, -0.1), S);

filldraw(circle((1.9, 0), 0.08), blue);
label("$1.4$", (1.9, -0.1), S);

filldraw(circle((3.1, 0), 0.08), blue);
label("$1.41$", (3.1, -0.1), S);

filldraw(circle((4.1, 0), 0.08), blue);
label("$1.412$", (4.1, -0.1), S);

filldraw(circle((4.9, 0), 0.08), blue);
label("$1.413$", (4.9, -0.1), S);

filldraw(circle((5.5, 0), 0.08), blue);
label("$1.414\ldots$", (5.5, -0.1), S);

label("$A = \{x \in \mathbb{Q} : x^2 < 2\}$", (2.5, 0.5), N, blue);

// the gap: sqrt(2) itself, not in Q
real gap = 6.2;
draw((gap, 0)--(gap, 0.5), red + dashed);
filldraw(circle((gap, 0), 0.08), white, red);
label("$\sqrt{2} \notin \mathbb{Q}$", (gap, 0.5), N, red);
