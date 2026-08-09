// The rotation matrix R_theta has no real eigenvector when theta is not a
// multiple of pi: every direction is rotated off its own line. Three sample
// directions v (blue), each with its own line (dashed), are rotated by
// theta = 40 degrees to R_theta v (red), landing off those lines.

import common;

size(9cm);
mathdefaults();

real bound = 1.55;
drawAxes(-bound, bound, -bound, bound, xlabel="", ylabel="");

draw(unitcircle, gray);

real theta = 40;
real[] angles = {15, 130, 250};

for (int i = 0; i < angles.length; ++i) {
    real a = angles[i];
    pair p = dir(a);
    pair Rp = dir(a + theta);

    draw(-1.2 * p--1.2 * p, gray + dashed);

    draw((0, 0)--p, blue + linewidth(1.1), Arrow(TeXHead));
    draw((0, 0)--Rp, red + linewidth(1.1), Arrow(TeXHead));
}

draw(arc((0, 0), 0.4, 15, 15 + theta), black);
label("$\theta$", 0.55 * dir(15 + theta / 2), black);

label("$\mathbf{v}$", dir(15), dir(15), blue);
label("$R_\theta\mathbf{v}$", dir(15 + theta), dir(15 + theta), red);
