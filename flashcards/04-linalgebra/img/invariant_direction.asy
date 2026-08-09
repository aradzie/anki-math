// The eigenvector v = (1,1) of A = [[2,1],[1,2]] spans an invariant line:
// Av = 3v lands back on that same line, scaled by the eigenvalue. A generic
// vector u = (1,0) is not an eigenvector -- its image Au = (2,1) leaves the
// x-axis, the line u itself lies on.

import common;

size(10cm);
mathdefaults();

drawAxes(-1.3, 3.6, -1.3, 3.6);

pair transform(pair p) {
    return (2 * p.x + p.y, p.x + 2 * p.y);
}

draw((-1, -1)--(3.5, 3.5), gray + dashed);
label("eigenline", (-1, -1), SW, gray);

pair v = (1, 1);
pair Av = transform(v);

draw((0, 0)--v, blue + linewidth(1.2), Arrow(TeXHead));
label("$\mathbf{v}$", v, NW, blue);

draw((0, 0)--Av, blue + linewidth(1.2), Arrow(TeXHead));
label("$A\mathbf{v} = 3\mathbf{v}$", Av, NE, blue);

pair u = (1, 0);
pair Au = transform(u);

draw((0, 0)--u, red + linewidth(1.2), Arrow(TeXHead));
label("$\mathbf{u}$", u, S, red);

draw((0, 0)--Au, red + linewidth(1.2), Arrow(TeXHead));
label("$A\mathbf{u}$", Au, E, red);
