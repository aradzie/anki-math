// Distance from a point x0 to a plane: dropping a perpendicular from x0 to
// the plane lands at the foot, and only the component of x0 - p along the
// normal n contributes to that perpendicular distance.

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
pen distColor = red;

triple nn = unit((0.3, -0.4, 1));      // the plane's normal direction
triple P = (1.6, 0.6, 0.3);            // the fixed point p on the plane
triple u = unit(cross(nn, (0, 0, 1))); // an in-plane direction
triple v = cross(nn, u);               // a second, orthogonal in-plane direction

triple foot = P + 0.5*u + 0.4*v;       // foot of the perpendicular, inside the plane
real h = 1.3;                          // the perpendicular distance
triple X0 = foot + h*nn;               // the point off the plane

drawPlane(P, u, v, planeColor, 1.5);

dot(proj(P), black);
label("$\mathbf{p}$", proj(P), S, black);
draw(proj(P)--proj(P + 1.0*nn), nColor + linewidth(1.2), Arrow(TeXHead));
label("$\mathbf{n}$", proj(P + 1.25*nn), E, nColor);

// x0 - p, dimmed as context for the derivation
draw(proj(P)--proj(X0), posColor + linewidth(1) + dashed, Arrow(TeXHead));
label("$\mathbf{x}_0-\mathbf{p}$", proj(P + 0.3*(X0-P)), W, posColor);

// the perpendicular distance itself, dropped to the foot
draw(proj(X0)--proj(foot), distColor + linewidth(1.3));
label("$\operatorname{dist}(\mathbf{x}_0,\Pi)$", proj((X0+foot)/2), E, distColor);

// right-angle tick at the foot
real tickLen = 0.18;
triple tickN = foot + tickLen*nn;
triple tickU = foot + tickLen*unit(u);
triple tickCorner = tickN + tickLen*unit(u);
draw(proj(tickN)--proj(tickCorner)--proj(tickU), black + linewidth(0.6));

dot(proj(foot), black);
dot(proj(X0), black);
label("$\mathbf{x}_0$", proj(X0), N, black);
