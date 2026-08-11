// a decomposed relative to b: proj_b a is the vector part of a along b, the
// dashed drop marks the right angle at the foot, comp_b a is the signed
// scalar length of that drop (dimension line below the axis), and the
// remainder a - proj_b a is the perpendicular part of a.

import common;

size(9cm);
mathdefaults();

pair O = (0, 0);
pair b = (2.0, 0);
real theta = 50;
pair a = 2.6 * dir(theta);
pair foot = (a.x, 0);   // b is along the x-axis, so the foot is (comp_b a, 0)

pen aColor = blue;
pen bColor = red;
pen projColor = purple;
pen perpColor = deepgreen;

// a and b, drawn from the origin
draw(O--a, aColor, Arrow(TeXHead));
label("$\mathbf{a}$", a, N, aColor);
draw(O--b, bColor, Arrow(TeXHead));
label("$\mathbf{b}$", b, S, bColor);

// dashed drop from the tip of a to its foot on the b-line
draw(a--foot, gray(0.5) + dashed);

// right-angle tick at the foot
real s = 0.15;
draw((foot.x - s, 0)--(foot.x - s, s)--(foot.x, s), black + linewidth(0.6));

// proj_b a: the vector part of a along b
draw(O--foot, projColor + linewidth(2.2));
label("$\operatorname{proj}_{\mathbf{b}}\mathbf{a}$", 0.5 * foot, N, projColor);

// comp_b a: the signed scalar length, shown as a dimension line below the axis
real dimY = -0.5;
draw((0, dimY)--foot.x * (1, 0) + (0, dimY), black + linewidth(0.6), Arrows(TeXHead, size=4));
draw((0, dimY - 0.06)--(0, dimY + 0.06), black + linewidth(0.6));
draw((foot.x, dimY - 0.06)--(foot.x, dimY + 0.06), black + linewidth(0.6));
label("$\operatorname{comp}_{\mathbf{b}}\mathbf{a}$", (foot.x / 2, dimY), S);

// a - proj_b a: the perpendicular remainder
draw(foot--a, perpColor + linewidth(1.4));
label("$\mathbf{a}-\operatorname{proj}_{\mathbf{b}}\mathbf{a}$", 0.5 * (foot + a), E, perpColor);

dot(O, black + linewidth(3));
