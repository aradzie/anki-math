// output: png
// Hyperboloid of one sheet x^2/a^2 + y^2/b^2 - z^2/c^2 = 1, centered at the
// origin.

import three;
import graph3;
import common;

mathdefaults();

real a = 1, b = 1, c = 1;         // hyperboloid semi-axes
real zMax = 1.3;                  // half-height of the drawn patch
real gridHalf = 2.0;              // xy-plane grid half-extent
int gridDivisions = 14;
real axisLen = 2.2;               // x/y axis arrow length from the origin
real zAxisLen = 1.8;              // z axis arrow length from the origin

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
draw((0,0,-0.8*zAxisLen)--(0,0,zAxisLen), axispen, arrow=Arrow3);
label("$x$", (axisLen*1.04,0,0), p=labelpen);
label("$y$", (0,axisLen*1.04,0), p=labelpen);
label("$z$", (0,0,zAxisLen*1.06), p=labelpen);

// The hyperboloid surface, parametrized by height z and azimuth theta,
// drawn last as a single whole surface across its full height range.
triple hyperboloidPoint(pair uv) {
    real z = uv.x;
    real theta = uv.y;
    real r = sqrt(1 + (z/c)^2);
    return (a*r*cos(theta), b*r*sin(theta), z);
}
material surfacepen = material(diffusepen=rgb(0.70,0.09,0.09)+opacity(0.6),
                                specularpen=gray(0.5), shininess=0.15);
surface s = surface(hyperboloidPoint, (-zMax,0), (zMax,2pi), nu=48, nv=120);
draw(s, surfacepen=surfacepen);
