// The scalar triple product a . (b x c): its absolute value is the volume
// of the parallelepiped spanned by a, b, c. The base parallelogram (gray
// fill) is spanned by b and c; b x c (purple, dashed) is normal to that
// base, so the volume is the base area times the height of a measured
// along the b x c direction.

import three;
import common3d;

mathdefaults();

size(8cm, 8cm);
triple target = (0.9, 0.9, 0.8);
currentprojection = perspective(camera=target+(11, -9, 4.5), up=Z,
                                 target=target, autoadjust=false);

pen aColor = heavygreen;
pen bColor = blue;
pen cColor = red;
pen crossColor = purple;
pen edgeColor = gray(0.4);
pen baseColor = gray(0.6);

triple O = (0, 0, 0);
triple b = (1.7, 0.2, -0.1);
triple c = (0.3, 1.6, 0.1);
triple a = (-0.5, -0.4, 1.7);

triple n = unit(cross(b, c));

// base parallelogram spanned by b and c, filled to show its area
filldraw(proj(O)--proj(b)--proj(b + c)--proj(c)--cycle,
         baseColor + opacity(0.35), edgeColor + linewidth(0.6));

// remaining edges of the parallelepiped
draw(proj(a)--proj(a + b)--proj(a + b + c)--proj(a + c)--cycle,
     edgeColor + linewidth(0.6));
draw(proj(b)--proj(a + b), edgeColor + linewidth(0.6));
draw(proj(c)--proj(a + c), edgeColor + linewidth(0.6));
draw(proj(b + c)--proj(a + b + c), edgeColor + linewidth(0.6));

// a, b, c as labeled arrows from the origin
draw(proj(O)--proj(a), aColor + linewidth(1.3), Arrow(TeXHead));
draw(proj(O)--proj(b), bColor + linewidth(1.3), Arrow(TeXHead));
draw(proj(O)--proj(c), cColor + linewidth(1.3), Arrow(TeXHead));
label("$\mathbf{a}$", proj(a), NW, aColor);
label("$\mathbf{b}$", proj(b), S, bColor);
label("$\mathbf{c}$", proj(c), SE, cColor);

// b x c: normal to the base, the direction volume is measured along
draw(proj(O)--proj(2.8 * n), crossColor + linewidth(1.1) + dashed, Arrow(TeXHead));
label("$\mathbf{b}\times\mathbf{c}$", proj(2.8 * n), NE, crossColor);

dot(proj(O), black);
