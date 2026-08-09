// The defective (Jordan-block) matrix A = [[1,1],[0,1]] has only one
// eigendirection despite eigenvalue 1 having algebraic multiplicity 2: the
// x-axis is fixed pointwise (Av = v), but every vector off it is sheared
// away from its own line -- there is no second, independent eigenvector.

import common;

size(9cm);
mathdefaults();

drawAxes(-0.6, 2.6, -0.6, 2.2);

pair transform(pair p) {
    return (p.x + p.y, p.y);
}

draw((-0.4, 0)--(2.4, 0), deepgreen + linewidth(1.6));
label("eigenline (fixed pointwise)", (1.4, 0), N, deepgreen);

pair v = (1, 0);
dot(v, deepgreen);
label("$\mathbf{v} = A\mathbf{v}$", v, S, deepgreen);

pair u1 = (0, 1);
pair Au1 = transform(u1);
draw((0, 0)--u1, blue + linewidth(1.1), Arrow(TeXHead));
draw((0, 0)--Au1, red + linewidth(1.1), Arrow(TeXHead));
label("$\mathbf{u}$", u1, W, blue);
label("$A\mathbf{u}$", Au1, NE, red);

pair u2 = (0.5, 1.4);
pair Au2 = transform(u2);
draw((0, 0)--u2, blue + linewidth(1.1), Arrow(TeXHead));
draw((0, 0)--Au2, red + linewidth(1.1), Arrow(TeXHead));
label("$\mathbf{w}$", u2, NW, blue);
label("$A\mathbf{w}$", Au2, N, red);
