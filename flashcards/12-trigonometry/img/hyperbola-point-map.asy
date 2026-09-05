// The point (cosh t, sinh t) on x^2-y^2=1 (left) maps to (e^t, e^{-t}) on
// uv=1 (right) under u=x+y, v=x-y.

import common;

size(16cm, 8cm);
mathdefaults();

real t0 = 1.0;
real dx = 4.0;

picture left;
{
    real xmin = -0.4, xmax = 2.2, ymax = 1.9;
    real tmin = -1.3, tmax = 1.3;

    draw(left, (xmin, 0)--(xmax, 0), Arrow(TeXHead));
    draw(left, (0, -ymax)--(0, ymax), Arrow(TeXHead));
    label(left, "$x$", (xmax, 0), E);
    label(left, "$y$", (0, ymax), N);

    guide branch;
    int n = 80;
    for (int i = 0; i <= n; ++i) {
        real t = tmin + (tmax - tmin) * i / n;
        pair pt = (cosh(t), sinh(t));
        branch = (i == 0) ? pt : branch--pt;
    }
    draw(left, branch, blue + linewidth(1.1));
    label(left, "$x^2-y^2=1$", (cosh(0.7), sinh(0.7)), W, blue);

    pair P0 = (cosh(t0), sinh(t0));
    dot(left, P0, heavygreen);
    label(left, "$(\cosh t,\sinh t)$", P0, SE);
}

picture right;
{
    real xmin = -0.4, xmax = 3.3, ymax = 3.0;
    real b0 = exp(t0);

    real curve(real x) { return 1 / x; }

    draw(right, (xmin, 0)--(xmax, 0), Arrow(TeXHead));
    draw(right, (0, -0.4)--(0, ymax), Arrow(TeXHead));
    label(right, "$u$", (xmax, 0), E);
    label(right, "$v$", (0, ymax), N);

    guide branch;
    real xCurveMin = 0.32, xCurveMax = 3.2;
    int n = 80;
    for (int i = 0; i <= n; ++i) {
        real x = xCurveMin + (xCurveMax - xCurveMin) * i / n;
        pair pt = (x, curve(x));
        branch = (i == 0) ? pt : branch--pt;
    }
    draw(right, branch, blue + linewidth(1.1));
    label(right, "$uv=1$", (2.7, curve(2.7)), NE, blue);

    pair Q0 = (b0, curve(b0));
    dot(right, Q0, heavygreen);
    label(right, "$(e^{t},e^{-t})$", Q0, SE);
}

add(left);
add(shift(dx, 0) * right);

// connecting arrow between the two panels
draw((2.3, 1.8)--(3.1, 1.8), Arrow(TeXHead));
label("$u=x+y,\ v=x-y$", (2.7, 1.8), N, fontsize(8pt));
