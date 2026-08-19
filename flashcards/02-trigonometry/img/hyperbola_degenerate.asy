// The degenerate hyperbola x^2-y^2=0 is the pair of lines y=x, y=-x
// (left); under u=x+y, v=x-y it becomes uv=0, the pair of coordinate axes
// in the u,v-plane (right).

import common;

size(16cm, 8cm);
mathdefaults();

real dx = 4;

picture left;
{
    real xmax = 1.8, ymax = 1.8;

    draw(left, (-xmax, 0)--(xmax, 0), Arrow(TeXHead));
    draw(left, (0, -ymax)--(0, ymax), Arrow(TeXHead));
    label(left, "$x$", (xmax, 0), E);
    label(left, "$y$", (0, ymax), N);

    draw(left, (-1.5, -1.5)--(1.5, 1.5), blue + linewidth(1.1));
    draw(left, (-1.5, 1.5)--(1.5, -1.5), blue + linewidth(1.1));
    label(left, "$y=x$", (1.5, 1.5), NW, blue);
    label(left, "$y=-x$", (1.5, -1.5), SW, blue);
    label(left, "$x^2-y^2=0$", (0, -ymax + 0.15), E, fontsize(9pt));
}

picture right;
{
    real xmax = 1.8, ymax = 1.8;

    draw(right, (-xmax, 0)--(xmax, 0), blue + linewidth(1.1), Arrow(TeXHead));
    draw(right, (0, -ymax)--(0, ymax), blue + linewidth(1.1), Arrow(TeXHead));
    label(right, "$u$", (xmax, 0), E);
    label(right, "$v$", (0, ymax), N);
    label(right, "$uv=0$", (0, -ymax + 0.15), E, fontsize(9pt));
}

add(left);
add(shift(dx, 0) * right);

draw((2.1, 0.9)--(2.9, 0.9), Arrow(TeXHead));
label("$u=x+y,\ v=x-y$", (2.5, 0.9), N, fontsize(8pt));
