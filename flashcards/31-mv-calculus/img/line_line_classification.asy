// Two skew lines: nonparallel direction vectors d1, d2, and a connecting
// vector p2 - p1 that is not coplanar with them -- the geometric picture
// behind d1 x d2 != 0 together with (p2-p1) . (d1 x d2) != 0.

import three;
import common3d;

mathdefaults();

size(9cm, 9cm);
triple target = (0, 0, 0);
currentprojection = perspective(camera=target+(11,-8,6), up=Z,
                                 target=target, autoadjust=false);

pen l1Color = heavygreen;
pen l2Color = orange;
pen connectColor = gray(0.45);

triple P1 = (-1.3, -0.4, 0.7);          // point on line 1
triple D1 = unit((1, 0.15, 0.05));      // direction of line 1
triple P2 = (0.2, -1.1, -0.5);          // point on line 2
triple D2 = unit((0.05, 1, 0.3));       // direction of line 2, nonparallel to D1

real ext = 1.9;

// the two lines, extended in both directions through their points
draw(proj(P1 - ext*D1)--proj(P1 + ext*D1), l1Color + linewidth(1.2));
draw(proj(P2 - ext*D2)--proj(P2 + ext*D2), l2Color + linewidth(1.2));
label("$\ell_1$", proj(P1 + ext*D1), NE, l1Color);
label("$\ell_2$", proj(P2 + ext*D2), NE, l2Color);

// direction vectors, drawn as short arrows based at each line's point
draw(proj(P1)--proj(P1 + 1.1*D1), l1Color + linewidth(1.4), Arrow(TeXHead));
label("$\mathbf{d}_1$", proj(P1 + 1.1*D1), N, l1Color);
draw(proj(P2)--proj(P2 + 1.1*D2), l2Color + linewidth(1.4), Arrow(TeXHead));
label("$\mathbf{d}_2$", proj(P2 + 1.1*D2), S, l2Color);

// the connecting vector p2 - p1, dashed to mark it as auxiliary
draw(proj(P1)--proj(P2), connectColor + linewidth(1) + dashed, Arrow(TeXHead));
label("$\mathbf{p}_2-\mathbf{p}_1$", proj((P1+P2)/2), S, connectColor);

dot(proj(P1), black);
label("$\mathbf{p}_1$", proj(P1), W, black);
dot(proj(P2), black);
label("$\mathbf{p}_2$", proj(P2), E, black);
