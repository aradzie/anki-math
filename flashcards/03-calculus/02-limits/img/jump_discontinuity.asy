// Jump discontinuity: both one-sided limits at x = c exist and are
// finite, but they disagree, so no single choice of f(c) could make f
// continuous there.

import graph;
import common;

size(12cm, 10cm);
mathdefaults();

real c = 0.5;
real Lminus = 0.5, Lplus = 2.0;

real f1(real x) { return 0.6 * x + 0.2; } // left arm, f1(c) = Lminus
real f2(real x) { return 0.6 * x + 1.7; } // right arm, f2(c) = Lplus

real xmin = -1.5, xmax = 3.3;
real ymin = -1, ymax = 3.8;

// axes
drawAxes(xmin, xmax, ymin, ymax);

// guides to the two one-sided limits
verticalGuide((c, 0), ymin, ymax);
dropToYAxis((c, Lminus));
dropToYAxis((c, Lplus));
label("$c$", (c, ymin), S);
label("$L^-$", (0, Lminus), W);
label("$L^+$", (0, Lplus), W);

// the two arms, disagreeing at c
draw(graph(f1, xmin + 0.2, c), blue + linewidth(1.2));
draw(graph(f2, c, xmax - 0.2), blue + linewidth(1.2));
label("$y=f(x)$", (xmax - 0.2, f2(xmax - 0.2)), NW, blue);

openPoint((c, Lminus), red);
openPoint((c, Lplus), red);
label("$\lim_{x\to c^-} f(x) = L^-$", (c, Lminus), NE, red);
label("$\lim_{x\to c^+} f(x) = L^+$", (c, Lplus), SE, red);
