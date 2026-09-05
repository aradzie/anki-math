// output: png
// Ellipsoid x^2/a^2 + y^2/b^2 + z^2/c^2 = 1, with a translucent xy-plane
// grid and translucent x/y/z axis arrows.

import three;
import graph3;
import common;

mathdefaults();

real a = 1.6, b = 1.6, c = 1.2;       // ellipsoid semi-axes
real gridHalf = 2.3;              // xy-plane grid half-extent
int gridDivisions = 10;
real axisLen = 2.5;               // x/y axis arrow length from the origin
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
draw((0,0,-0.3*zAxisLen)--(0,0,zAxisLen), axispen, arrow=Arrow3);
label("$x$", (axisLen*1.04,0,0), p=labelpen);
label("$y$", (0,axisLen*1.04,0), p=labelpen);
label("$z$", (0,0,zAxisLen*1.06), p=labelpen);

// The ellipsoid surface, parametrized by inclination theta (from +z) and
// azimuth phi, drawn last as a single whole surface -- the depth buffer
// handles occlusion against the plane/grid/axes above regardless of
// paint order.
triple ellipsoidPoint(pair uv) {
    real theta = uv.x;
    real phi = uv.y;
    return (a*sin(theta)*cos(phi), b*sin(theta)*sin(phi), c*cos(theta));
}
material ellipsoidSurfacepen = material(diffusepen=rgb(0.70,0.09,0.09)+opacity(0.5),
                                         specularpen=gray(0.5), shininess=0.15);
surface s = surface(ellipsoidPoint, (0,0), (pi,2pi), nu=80, nv=160);
draw(s, surfacepen=ellipsoidSurfacepen);
