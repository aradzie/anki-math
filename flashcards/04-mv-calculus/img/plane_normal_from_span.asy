// Converting a parametric plane to a scalar equation: the two nonparallel
// spanning vectors b, c determine a normal n = b x c, giving the scalar
// equation (r-p).(b x c) = 0.

import three;
import common3d;

mathdefaults();

size(8cm, 8cm);
triple target = (0.7, 0.5, 0.3);
currentprojection = perspective(camera=target+(12,-3,3), up=Z,
                                 target=target, autoadjust=false);

pen planeColor = gray(0.6);
pen bColor = heavygreen;
pen cColor = orange;
pen nColor = blue;

triple P = (1.6, 0.6, 0.3);            // the fixed point p on the plane
triple nnRef = unit((0.3, -0.4, 1));   // reference direction, only used to build b, c
triple b = unit(cross(nnRef, (0, 0, 1))); // a direction vector parallel to the plane
triple c = cross(nnRef, b);               // a second, non-parallel direction vector
triple nn = unit(cross(b, c));

drawPlane(P, b, c, planeColor, 1.5);

draw(proj(P)--proj(P + 1.1*b), bColor + linewidth(1.3), Arrow(TeXHead));
label("$\mathbf{b}$", proj(P + 1.3*b), S, bColor);
draw(proj(P)--proj(P + 1.1*c), cColor + linewidth(1.3), Arrow(TeXHead));
label("$\mathbf{c}$", proj(P + 1.3*c), E, cColor);

draw(proj(P)--proj(P + 1.0*nn), nColor + linewidth(1.2), Arrow(TeXHead));
label("$\mathbf{n}=\mathbf{b}\times\mathbf{c}$", proj(P + 1.3*nn), E, nColor);

dot(proj(P), black);
label("$\mathbf{p}$", proj(P), S, black);
