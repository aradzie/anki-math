// Both branches of x^2-y^2=1 (left) and both branches of uv=1 (right)
// under u=x+y, v=x-y: the right branch (x>0) maps to the first-quadrant
// branch, the left branch (x<0) maps to the third-quadrant branch.

import common;

size(26cm, 9cm);
mathdefaults();

real dx = 7.2;

picture left;
{
    real xmax = 2.0, ymax = 1.8;
    real tmin = -1.2, tmax = 1.2;

    draw(left, (-xmax, 0)--(xmax, 0), Arrow(TeXHead));
    draw(left, (0, -ymax)--(0, ymax), Arrow(TeXHead));
    label(left, "$x$", (xmax, 0), E);
    label(left, "$y$", (0, ymax), N);

    guide rightBranch, leftBranch;
    int n = 80;
    for (int i = 0; i <= n; ++i) {
        real t = tmin + (tmax - tmin) * i / n;
        pair pr = (cosh(t), sinh(t));
        pair pl = (-cosh(t), sinh(t));
        rightBranch = (i == 0) ? pr : rightBranch--pr;
        leftBranch = (i == 0) ? pl : leftBranch--pl;
    }
    draw(left, rightBranch, blue + linewidth(1.1));
    draw(left, leftBranch, purple + linewidth(1.1));
    label(left, "right branch", (cosh(0.9), sinh(0.9)), NW, blue);
    label(left, "left branch", (-cosh(0.9), sinh(0.9)), NE, purple);
    label(left, "$x^2-y^2=1$", (0, -ymax - 0.15), fontsize(9pt));
}

picture right;
{
    real xmax = 2.6, ymax = 2.6;
    real curve(real x) { return 1 / x; }

    draw(right, (-xmax, 0)--(xmax, 0), Arrow(TeXHead));
    draw(right, (0, -ymax)--(0, ymax), Arrow(TeXHead));
    label(right, "$u$", (xmax, 0), E);
    label(right, "$v$", (0, ymax), N);

    guide q1, q3;
    real xCurveMin = 0.42, xCurveMax = 2.5;
    int n = 80;
    for (int i = 0; i <= n; ++i) {
        real x = xCurveMin + (xCurveMax - xCurveMin) * i / n;
        pair p1 = (x, curve(x));
        pair p3 = (-x, -curve(x));
        q1 = (i == 0) ? p1 : q1--p1;
        q3 = (i == 0) ? p3 : q3--p3;
    }
    draw(right, q1, blue + linewidth(1.1));
    draw(right, q3, purple + linewidth(1.1));
    label(right, "1st-quadrant branch", (0.7, curve(0.7)), NE, blue);
    label(right, "3rd-quadrant branch", (-0.7, -curve(0.7)), SW, purple);
    label(right, "$uv=1$", (0, -ymax + 0.15), fontsize(9pt));
}

add(left);
add(shift(dx, 0) * right);

draw((3.0, 0.9)--(4.2, 0.9), blue, Arrow(TeXHead));
label("right $\to$ Q1", (3.6, 0.9), N, fontsize(8pt) + blue);

draw((3.0, -0.9)--(4.2, -0.9), purple, Arrow(TeXHead));
label("left $\to$ Q3", (3.6, -0.9), S, fontsize(8pt) + purple);

label("$u=x+y,\ v=x-y$", (3.6, 1.7), fontsize(9pt));
