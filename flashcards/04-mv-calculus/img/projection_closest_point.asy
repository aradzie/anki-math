// proj_b a is the closest point to a on span{b}: among candidate points t.b
// on the line, the perpendicular segment down to proj_b a (green) is
// shortest, while oblique segments to other points t1.b, t2.b (gray, dashed)
// are longer -- the right-angle tick at the foot is the Pythagorean reason.

import common;

size(9cm);
mathdefaults();

real lineMin = -1.0;
real lineMax = 3.6;

pair a = (1.6, 1.8);
pair foot = (a.x, 0);
pair t1 = (0.3, 0);
pair t2 = (3.0, 0);

pen closeColor = deepgreen;
pen otherColor = gray(0.45);

// the line span{b}, extending in both directions
draw((lineMin, 0)--(lineMax, 0), black, Arrows(TeXHead));
label("$\operatorname{span}\{\mathbf{b}\}$", (lineMax, 0), E);

// oblique segments from a to other candidate points on the line
draw(a--t1, otherColor + dashed);
draw(a--t2, otherColor + dashed);
dot(t1, otherColor + linewidth(3));
dot(t2, otherColor + linewidth(3));
label("$t_1\mathbf{b}$", t1, S, otherColor);
label("$t_2\mathbf{b}$", t2, S, otherColor);

// the perpendicular, shortest segment to proj_b a
draw(a--foot, closeColor + linewidth(2.0));
dot(foot, closeColor + linewidth(3));
label("$\operatorname{proj}_{\mathbf{b}}\mathbf{a}$", foot, S, closeColor);

// right-angle tick at the foot
real s = 0.15;
draw((foot.x - s, 0)--(foot.x - s, s)--(foot.x, s), black + linewidth(0.6));

dot(a, black + linewidth(3));
label("$\mathbf{a}$", a, N);
