// output: png
// Elliptic cone z^2/c^2 = x^2/a^2 + y^2/b^2, apex at the origin.

import three;
import graph3;
import common;

mathdefaults();

real a = 1, b = 1, c = 1;         // cone semi-axes
real rMax = 1.3;                  // radial extent of each drawn nappe
real gridHalf = 1.7;              // xy-plane grid half-extent
int gridDivisions = 14;
real axisLen = 1.9;               // x/y axis arrow length from the origin
real zAxisLen = 1.7;              // z axis arrow length from the origin

size3(40cm, 40cm, 40cm);
currentprojection = perspective(camera=(6,8,4.5), up=Z, target=(0,0,0),
                                 autoadjust=false);

// xy-plane: a translucent white fill, sitting a hair below z=0 so the grid
// lines on top of it don't z-fight with the fill, plus a translucent gray
// grid, and the x/y/z axis arrows through the origin.
path3 planeBoundary = (-gridHalf,-gridHalf,-0.002)--(gridHalf,-gridHalf,-0.002)
                     --(gridHalf,gridHalf,-0.002)--(-gridHalf,gridHalf,-0.002)--cycle;
draw(surface(planeBoundary), surfacepen=white+opacity(0.5));

pen gridpen = gray(0.55) + opacity(0.45) + linewidth(0.4);
for (int i = -gridDivisions; i <= gridDivisions; ++i) {
    real t = gridHalf * i / gridDivisions;
    draw((t,-gridHalf,0)--(t,gridHalf,0), gridpen);
    draw((-gridHalf,t,0)--(gridHalf,t,0), gridpen);
}

pen axispen = gray(0.4) + opacity(0.75) + linewidth(2);
pen labelpen = gray(0.3) + fontsize(36pt);
draw((-0.3*axisLen,0,0)--(axisLen,0,0), axispen, arrow=Arrow3);
draw((0,-0.3*axisLen,0)--(0,axisLen,0), axispen, arrow=Arrow3);
draw((0,0,-0.9*zAxisLen)--(0,0,zAxisLen), axispen, arrow=Arrow3);
label("$x$", (axisLen*1.04,0,0), p=labelpen);
label("$y$", (0,axisLen*1.04,0), p=labelpen);
label("$z$", (0,0,zAxisLen*1.06), p=labelpen);

// Each nappe, parametrized by radius r and azimuth theta, meeting at the
// apex (origin) where both share the same r=0 point. Drawn last, in
// either order -- the depth buffer sorts them against the plane/grid/
// axes above and against each other correctly.
material surfacepen = material(diffusepen=rgb(0.70,0.09,0.09)+opacity(0.6),
                                specularpen=gray(0.5), shininess=0.15);

triple upperNappePoint(pair uv) {
    real r = uv.x;
    real theta = uv.y;
    return (a*r*cos(theta), b*r*sin(theta), c*r);
}
triple lowerNappePoint(pair uv) {
    triple p = upperNappePoint(uv);
    return (p.x, p.y, -p.z);
}
surface upper = surface(upperNappePoint, (0,0), (rMax,2pi), nu=36, nv=120);
surface lower = surface(lowerNappePoint, (0,0), (rMax,2pi), nu=36, nv=120);

draw(lower, surfacepen=surfacepen);
draw(upper, surfacepen=surfacepen);
