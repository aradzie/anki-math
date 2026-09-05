// A line transversal to a plane: since d . n != 0, the line pierces the
// plane in exactly one point, found by substituting the line into the
// plane equation and solving for t.

import three;
import common3d;

mathdefaults();

size(8cm, 8cm);
triple target = (0.7, 0.5, 0.3);
currentprojection = perspective(camera=target+(12,-3,3), up=Z,
                                 target=target, autoadjust=false);

pen planeColor = gray(0.6);
pen nColor = blue;
pen dColor = red;

triple nn = unit((0.3, -0.4, 1));      // the plane's normal direction
triple I = (1.4, 0.5, 0.3);            // the point of intersection, on the plane
triple u = unit(cross(nn, (0, 0, 1))); // an in-plane direction
triple v = cross(nn, u);               // a second, orthogonal in-plane direction

triple D = unit((1.3, 0.4, 0.5));      // line direction; dot(D, nn) != 0

drawPlane(I, u, v, planeColor, 1.5);

real ext = 1.7;
draw(proj(I - ext*D)--proj(I + ext*D), dColor + linewidth(1.3));
draw(proj(I)--proj(I + 1.0*D), dColor + linewidth(1.3), Arrow(TeXHead));
label("$\mathbf{d}$", proj(I + 1.25*D), NE, dColor);

draw(proj(I)--proj(I + 1.0*nn), nColor + linewidth(1.2), Arrow(TeXHead));
label("$\mathbf{n}$", proj(I + 1.25*nn), E, nColor);

dot(proj(I), black);
label("$\mathbf{r}(t)=\mathbf{p}+t\mathbf{d}$", proj(I), SW, black);
