// (0,1): sup=1 and inf=0 exist but are not attained (hollow endpoints).
// [0,1]: max=sup=1 and min=inf=0 are attained (filled endpoints).

import graph;
import common;

size(16cm, 8cm);
mathdefaults();

real x0 = 0;
real x1 = 4;

// top: open interval (0,1)
real ytop = +0.5;
draw((x0, ytop)--(x1, ytop), blue + linewidth(1.2));
openPoint((x0, ytop));
openPoint((x1, ytop));
label("$(0,1)$", ((x0 + x1) / 2, ytop + 0.1), N, blue);
label("$\inf = 0$, not attained", (x0, ytop - 0.1), S);
label("$\sup = 1$, not attained", (x1, ytop - 0.1), S);

// bottom: closed interval [0,1]
real ybot = -0.5;
draw((x0, ybot)--(x1, ybot), blue + linewidth(1.2));
closedPoint((x0, ybot));
closedPoint((x1, ybot));
label("$[0,1]$", ((x0 + x1) / 2, ybot + 0.1), N, blue);
label("$\min = \inf = 0$", (x0, ybot - 0.1), S);
label("$\max = \sup = 1$", (x1, ybot - 0.1), S);
