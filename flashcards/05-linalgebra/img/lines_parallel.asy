// An inconsistent system: two distinct parallel lines share no common
// point at all.

import common;

size(10cm);
mathdefaults();

drawAxes(-3, 3, -3, 3);

pair Pa1 = (-2.5, -2.5 + 1.2);
pair Pb1 = (2.5, 2.5 + 1.2);
draw(Pa1--Pb1, blue + linewidth(1.2));
label("eq. 1", Pa1, SW, blue);

pair Pa2 = (-2.5, -2.5 - 1.2);
pair Pb2 = (2.5, 2.5 - 1.2);
draw(Pa2--Pb2, red + linewidth(1.2));
label("eq. 2", Pa2, SW, red);
