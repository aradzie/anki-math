// Parametric equation of a plane: starting from the fixed point p, moving
// s steps along b and t steps along c (two non-parallel vectors parallel to
// the plane) reaches any point r on the plane -- r = p + sb + tc.

import three;
import common3d;

mathdefaults();

size(8cm, 8cm);
triple target = (0.7, 0.5, 0.3);
currentprojection = perspective(camera=target+(12,-3,3), up=Z,
                                 target=target, autoadjust=false);

pen planeColor = gray(0.6);
pen posColor = gray(0.45);
pen bColor = heavygreen;
pen cColor = orange;

triple O = (0, 0, 0);
triple nn = unit((0.3, -0.4, 1));      // the plane's normal direction
triple P = (1.6, 0.6, 0.3);            // the fixed point p on the plane
triple b = unit(cross(nn, (0, 0, 1))); // a direction vector parallel to the plane
triple c = cross(nn, b);               // a second, non-parallel direction vector
real s = 0.9;
real t = 0.8;
triple sb = P + s*b;                   // p + sb
triple R = sb + t*c;                   // r = p + sb + tc

drawPlane(P, b, c, planeColor, 1.5);

// position vectors from the origin, dimmed as context
draw(proj(O)--proj(P), posColor + linewidth(1) + dashed, Arrow(TeXHead));
draw(proj(O)--proj(R), posColor + linewidth(1) + dashed, Arrow(TeXHead));
dot(proj(O), black);
label("$O$", proj(O), NW);
label("$\mathbf{p}$", proj(0.5*P), N, black);
label("$\mathbf{r}$", proj(0.55*R), NW, black);

// the parallelogram sum p + sb + tc, mirroring how a + b is drawn for the
// cross product: two colored, labeled vectors plus two plain connecting
// edges completing the parallelogram.
draw(proj(P)--proj(sb), bColor + linewidth(1.3), Arrow(TeXHead));
draw(proj(sb)--proj(R), black + linewidth(0.6));
draw(proj(R)--proj(P+t*c), black + linewidth(0.6));
draw(proj(P)--proj(P+t*c), cColor + linewidth(1.3), Arrow(TeXHead));

label("$s\mathbf{b}$", proj(P + 0.5*s*b), S, bColor);
label("$t\mathbf{c}$", proj(sb + 0.5*t*c), E, cColor);

dot(proj(P), black);
dot(proj(R), black);
