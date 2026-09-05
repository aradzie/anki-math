// The plane through three noncollinear points p, q, s: the edge vectors
// q - p and s - p are nonparallel and lie in the plane, so their cross
// product n = (q-p) x (s-p) is a normal vector.

import three;
import common3d;

mathdefaults();

size(8cm, 8cm);
triple target = (0.4, 0.3, 0.5);
currentprojection = perspective(camera=target+(12,-4,4), up=Z,
                                 target=target, autoadjust=false);

pen planeColor = gray(0.6);
pen qColor = heavygreen;
pen sColor = orange;
pen nColor = blue;

triple P = (-0.4, -0.5, 0.2);          // point p
triple edgeQ = (1.5, 0.3, -0.1);       // direction of q - p
triple edgeS = (0.2, 1.3, 0.3);        // direction of s - p, nonparallel to edgeQ
triple Q = P + edgeQ;
triple S = P + edgeS;
triple nn = unit(cross(edgeQ, edgeS));

drawPlane(P, edgeQ, edgeS, planeColor, 1.7);

draw(proj(P)--proj(Q), qColor + linewidth(1.3), Arrow(TeXHead));
label("$\mathbf{q}-\mathbf{p}$", proj(P + 0.55*edgeQ), S, qColor);
draw(proj(P)--proj(S), sColor + linewidth(1.3), Arrow(TeXHead));
label("$\mathbf{s}-\mathbf{p}$", proj(P + 0.55*edgeS), W, sColor);

draw(proj(P)--proj(P + 1.1*nn), nColor + linewidth(1.2), Arrow(TeXHead));
label("$\mathbf{n}=(\mathbf{q}-\mathbf{p})\times(\mathbf{s}-\mathbf{p})$",
      proj(P + 1.35*nn), E, nColor);

dot(proj(P), black);
label("$\mathbf{p}$", proj(P), SW, black);
dot(proj(Q), black);
label("$\mathbf{q}$", proj(Q), E, black);
dot(proj(S), black);
label("$\mathbf{s}$", proj(S), N, black);
