// An independent system of two linear equations, x + y = 4 and x - y = 0:
// the lines cross at exactly one point, the system's unique solution.

import common;

size(10cm);
mathdefaults();

drawAxes(-2, 5.5, -2, 5.5);

pair p1a = (-1, 5);
pair p1b = (5, -1);
pair p2a = (-1, -1);
pair p2b = (5, 5);

draw(p1a--p1b, blue + linewidth(1.2));
draw(p2a--p2b, red + linewidth(1.2));

label("$x+y=4$", (4, 0), SE, blue);
label("$x-y=0$", (4, 4), NE, red);

pair sol = (2, 2);
dot(sol, black + linewidth(1.5));
label("$(2,2)$", sol, N);
