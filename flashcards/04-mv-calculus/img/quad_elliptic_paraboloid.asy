// output: png
// Elliptic paraboloid z = x^2/a^2 + y^2/b^2, vertex at the origin, opening
// upward.

import three;
import graph3;
import common;

mathdefaults();

real a = 1.3, b = 1.3;            // paraboloid semi-axes
real tMax = 1.5;                  // radial extent of the drawn bowl
real gridHalf = 2.3;              // xy-plane grid half-extent
int gridDivisions = 10;
real axisLen = 2.5;               // x/y axis arrow length from the origin
real zAxisLen = 2.9;              // z axis arrow length from the origin

size3(40cm, 40cm, 40cm);
currentprojection = perspective(camera=(6,8,4.7), up=Z, target=(0,0,0.6),
                                 autoadjust=false);

// xy-plane: a translucent white fill, sitting a hair below z=0 so the grid
// lines on top of it don't z-fight with the fill, plus a translucent gray
// grid.
path3 planeBoundary = (-gridHalf,-gridHalf,-0.002)--(gridHalf,-gridHalf,-0.002)
                     --(gridHalf,gridHalf,-0.002)--(-gridHalf,gridHalf,-0.002)--cycle;
draw(surface(planeBoundary), surfacepen=white+opacity(0.5));

pen gridpen = gray(0.55) + opacity(0.45) + linewidth(0.4);
for (int i = -gridDivisions; i <= gridDivisions; ++i) {
    real t = gridHalf * i / gridDivisions;
    draw((t,-gridHalf,0)--(t,gridHalf,0), gridpen);
    draw((-gridHalf,t,0)--(gridHalf,t,0), gridpen);
}

// x, y, z axis arrows, translucent gray, through the origin.
pen axispen = gray(0.4) + opacity(0.75) + linewidth(2);
pen labelpen = gray(0.3) + fontsize(36pt);
draw((-0.3*axisLen,0,0)--(axisLen,0,0), axispen, arrow=Arrow3);
draw((0,-0.3*axisLen,0)--(0,axisLen,0), axispen, arrow=Arrow3);
draw((0,0,-0.3*zAxisLen)--(0,0,zAxisLen), axispen, arrow=Arrow3);
label("$x$", (axisLen*1.04,0,0), p=labelpen);
label("$y$", (0,axisLen*1.04,0), p=labelpen);
label("$z$", (0,0,zAxisLen*1.06), p=labelpen);

// The paraboloid surface, parametrized by radial parameter t and azimuth
// theta, so the elliptical cross-section stays uniform at every height.
triple paraboloidPoint(pair uv) {
    real t = uv.x;
    real theta = uv.y;
    return (a*t*cos(theta), b*t*sin(theta), t^2);
}
surface s = surface(paraboloidPoint, (0,0), (tMax,2pi), nu=48, nv=120);
draw(s, surfacepen=material(diffusepen=rgb(0.70,0.09,0.09)+opacity(0.6),
                             specularpen=gray(0.5), shininess=0.15));
