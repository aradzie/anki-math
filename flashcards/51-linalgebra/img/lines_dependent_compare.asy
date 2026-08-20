// The two sub-cases of a dependent system of linear equations (as many
// equations as unknowns, one equation a scalar multiple of the other):
// the lines either coincide (consistent, infinitely many common points)
// or are parallel but distinct (inconsistent, no common point).

import common;

size(22cm, 9cm);
mathdefaults();

// --- left panel: coincident lines ---
real dx1 = 0;
drawAxes(dx1 - 3, dx1 + 3, -3, 3, originx=dx1);

pair La = (dx1 - 2.5, -2.5);
pair Lb = (dx1 + 2.5, 2.5);
draw(La--Lb, blue + linewidth(1.6));

label("eq. 1", La, SW, blue);
label("eq. 2", Lb, NE, blue);
label("coincident: infinitely many solutions", (dx1, -3.7), S);

// --- right panel: parallel, distinct lines ---
real dx2 = 8;
drawAxes(dx2 - 3, dx2 + 3, -3, 3, originx=dx2);

pair Pa1 = (dx2 - 2.5, -2.5 + 1.2);
pair Pb1 = (dx2 + 2.5, 2.5 + 1.2);
draw(Pa1--Pb1, blue + linewidth(1.2));
label("eq. 1", Pa1, SW, blue);

pair Pa2 = (dx2 - 2.5, -2.5 - 1.2);
pair Pb2 = (dx2 + 2.5, 2.5 - 1.2);
draw(Pa2--Pb2, red + linewidth(1.2));
label("eq. 2", Pa2, SW, red);

label("parallel, distinct: no solution", (dx2, -3.7), S);
