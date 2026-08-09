// Matrix multiplication is not commutative: applying the shear B then the
// rotation A gives a different image of the unit square than applying A
// then B. A = rotation by 90 deg = [[0,-1],[1,0]], B = horizontal shear
// = [[1,1],[0,1]]. AB (apply B first, then A) and BA (apply A first, then
// B) are drawn from the same origin for comparison.

import common;

size(10cm);
mathdefaults();

drawAxes(-2.2, 2.2, -1.2, 2.6);

pair transform(real m11, real m12, real m21, real m22, pair p) {
    return (m11 * p.x + m12 * p.y, m21 * p.x + m22 * p.y);
}

pair sq0 = (0, 0);
pair sq1 = (1, 0);
pair sq2 = (1, 1);
pair sq3 = (0, 1);

draw(sq0--sq1--sq2--sq3--cycle, gray + dashed);
label("unit square", (1.0, 0.5), gray);

// AB: apply B first, then A
pair ab1 = transform(0, -1, 1, 1, sq1);
pair ab2 = transform(0, -1, 1, 1, sq2);
pair ab3 = transform(0, -1, 1, 1, sq3);

draw(sq0--ab1--ab2--ab3--cycle, blue + linewidth(1.2));
label("$AB$", ab2, N, blue);

// BA: apply A first, then B
pair ba1 = transform(1, -1, 1, 0, sq1);
pair ba2 = transform(1, -1, 1, 0, sq2);
pair ba3 = transform(1, -1, 1, 0, sq3);

draw(sq0--ba1--ba2--ba3--cycle, red + linewidth(1.2));
label("$BA$", ba1, NE, red);
