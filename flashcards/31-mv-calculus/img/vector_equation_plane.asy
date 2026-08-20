// Vector equation of a plane: p is the position vector of a fixed point on
// the plane, r the position vector of any other point on it. Since r - p
// then lies in the plane, it is orthogonal to the normal vector n -- the
// geometric content of (r - p) . n = 0.

import three;
import common3d;

mathdefaults();

size(8cm, 8cm);
triple target = (0.7, 0.5, 0.3);
currentprojection = perspective(camera=target+(12,-3,3), up=Z,
                                 target=target, autoadjust=false);

pen planeColor = gray(0.6);
pen posColor = gray(0.45);
pen nColor = blue;
pen diffColor = red;

triple O = (0, 0, 0);
triple nn = unit((0.3, -0.4, 1));      // the plane's normal direction
triple P = (1.6, 0.6, 0.3);            // the fixed point p on the plane
triple u = unit(cross(nn, (0, 0, 1))); // an in-plane direction
triple v = cross(nn, u);               // a second, orthogonal in-plane direction
triple R = P + 0.9*u + 0.8*v;          // another point r on the plane

drawPlane(P, u, v, planeColor, 1.5);

// position vectors from the origin, dimmed as context
draw(proj(O)--proj(P), posColor + linewidth(1) + dashed, Arrow(TeXHead));
draw(proj(O)--proj(R), posColor + linewidth(1) + dashed, Arrow(TeXHead));
dot(proj(O), black);
label("$O$", proj(O), NW);
label("$\mathbf{p}$", proj(0.5*P), N, black);
label("$\mathbf{r}$", proj(0.55*R), NW, black);

// the normal vector n, based at p
triple nTip = P + 1.3*nn;
draw(proj(P)--proj(nTip), nColor + linewidth(1.2), Arrow(TeXHead));
label("$\mathbf{n}$", proj(nTip + 0.25*nn), E, nColor);

// r - p, the in-plane vector from p to r
draw(proj(P)--proj(R), diffColor + linewidth(1.3), Arrow(TeXHead));
label("$\mathbf{r}-\mathbf{p}$", proj((P+R)/2), S, diffColor);

dot(proj(P), black);
dot(proj(R), black);
