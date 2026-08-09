// Under the symmetric matrix A = [[2,1],[1,2]], the unit circle maps to an
// ellipse whose semi-axes lie along A's eigenvectors (1,1) and (1,-1), with
// lengths equal to the eigenvalues 3 and 1 -- the principal axes guaranteed
// by the Spectral Theorem.

import common;

size(9cm);
mathdefaults();

drawAxes(-3.6, 3.6, -3.6, 3.6);

pair transform(pair p) {
    return (2 * p.x + p.y, p.x + 2 * p.y);
}

draw(unitcircle, gray + dashed);
label("unit circle", dir(150), NW, gray);

guide ellipseImg;
int n = 200;
for (int i = 0; i <= n; ++i) {
    real t = 2 * pi * i / n;
    ellipseImg = ellipseImg .. transform((cos(t), sin(t)));
}
draw(ellipseImg, blue + linewidth(1.2));
label("$A(\mathrm{unit\ circle})$", transform(dir(25)), NE, blue);

pair e1 = (1, 1) / sqrt(2);   // eigenvector, lambda = 3
pair e2 = (1, -1) / sqrt(2);  // eigenvector, lambda = 1

draw(-3 * e1--3 * e1, deepgreen + linewidth(1.2));
label("$\lambda_1 = 3$", 3 * e1, NE, deepgreen);

draw(-e2--e2, red + linewidth(1.2));
label("$\lambda_2 = 1$", e2, SE, red);
