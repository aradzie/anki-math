// f(x) = 1/(x-2): the vertical asymptote at x = 2 is why 2 is excluded from
// the domain, and the horizontal asymptote y = 0 is why 0 is excluded from
// the range -- shown as open circles on the axes, with the attained parts
// overlaid in color (orange for domain on the x-axis, red for range on the
// y-axis).

import graph;
import common;

size(10cm);
texpreamble("\usepackage{amssymb}");
mathdefaults();

real xmin = -1.6, xmax = 5.6;
real ymax = 4.2;
real eps = 0.22; // gap around the pole at x = 2 to avoid the blow-up
real edge = 0.3; // gap at the plot's outer edges

real f(real x) { return 1 / (x - 2); }

drawAxes(xmin, xmax, -ymax, ymax);

// curve
draw(graph(f, xmin + edge, 2 - eps), blue + linewidth(1.1));
draw(graph(f, 2 + eps, xmax - edge), blue + linewidth(1.1));
label("$y = \dfrac{1}{x-2}$", (xmax - edge, f(xmax - edge)), N, blue);

// domain overlay on the x-axis: R \ {2}
draw((xmin + edge, 0)--(2 - eps, 0), orange + linewidth(2.5));
draw((2 + eps, 0)--(xmax - edge, 0), orange + linewidth(2.5));
openPoint((2, 0), orange);
label("$2$", (2, 0), S);

// range overlay on the y-axis: R \ {0}
draw((0, -ymax + edge)--(0, -eps), red + linewidth(2.5));
draw((0, eps)--(0, ymax - edge), red + linewidth(2.5));
openPoint((0, 0), red);

label("domain $= \mathbb{R} \setminus \{2\}$", (3.4, -2), N, orange);
label("range $= \mathbb{R} \setminus \{0\}$", (3.4, -2), S, red);
