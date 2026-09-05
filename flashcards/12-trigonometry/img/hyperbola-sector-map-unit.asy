// The unit-area sector on uv=1, ending at (e,1/e) (right), corresponds
// under u=x+y, v=x-y to the sector on x^2-y^2=1 ending at (cosh 1,sinh 1)
// (left), which has half the area, 1/2.

import common;

size(18cm, 8cm);
mathdefaults();

real t0 = 1.0;
real dx = 4.0;

picture left;
{
    real xmin = -0.4, xmax = 2.3, ymax = 1.9;
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
    label(left, "$x^2-y^2=1$", (cosh(1.15), sinh(1.15)), NW, blue);

    guide sector = (0, 0)--(1, 0);
    int m = 50;
    for (int i = 0; i <= m; ++i) {
        real t = t0 * i / m;
        sector = sector--(cosh(t), sinh(t));
    }
    sector = sector--cycle;
    fill(left, sector, orange + opacity(0.3));
    draw(left, sector, orange + linewidth(0.9));
    label(left, "area $=\dfrac{1}{2}$", (1.8, 0.35), orange);

    dot(left, (1, 0), black);
    label(left, "$(1,0)$", (1, 0), S);

    pair P0 = (cosh(t0), sinh(t0));
    dot(left, P0, blue);
    label(left, "$(\cosh 1,\sinh 1)$", P0, SE);
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

    guide sector = (0, 0)--(1, 1);
    int m = 50;
    for (int i = 0; i <= m; ++i) {
        real x = 1 + (b0 - 1) * i / m;
        sector = sector--(x, curve(x));
    }
    sector = sector--cycle;
    fill(right, sector, orange + opacity(0.3));
    draw(right, sector, orange + linewidth(0.9));
    label(right, "area $=1$", (2, 1), orange);

    dot(right, (1, 1), black);
    label(right, "$(1,1)$", (1, 1), W);

    pair Q0 = (b0, curve(b0));
    dot(right, Q0, blue);
    label(right, "$(e,1/e)$", Q0, SE);
}

add(left);
add(shift(dx, 0) * right);

draw((2.6, 1.7)--(3.4, 1.7), Arrow(TeXHead));
label("$u=x+y,\ v=x-y$", (3.0, 1.7), N, fontsize(8pt));
