// D_u f(a) = grad f(a) . u geometrically: level curves of f=C-0.5(x^2+y^2)
// are concentric circles, the gradient at a is normal to the level curve
// through a and points toward increasing f (here, toward the peak at the
// origin), and D_u f(a) is the signed length of the projection of that
// gradient onto the unit direction u.

import common;

size(9cm);
mathdefaults();

pair a = (0.8,0.6);       // point of evaluation, chosen with |a|=1
pair g = -a;               // grad f(a) = (-a1,-a2), points toward the origin
real theta = 50;           // angle between u and the gradient
pair u = rotate(theta)*unit(g);   // unit direction, off from the gradient
real Duf = dot(g,u);       // D_u f(a) = grad f(a) . u

pen gColor = red;
pen uColor = purple;

// Level curves of f, concentric circles centered on the peak at the origin.
real[] radii = {0.5, 0.75, 1.0, 1.25};
for (int i = 0; i < radii.length; ++i) {
    draw(circle((0,0), radii[i]), gray(0.65));
}

// The unit direction u, drawn from a past the projection foot.
pair foot = a + Duf*u;
draw(a--(a+1.15*u), uColor+linewidth(1.1), Arrow(TeXHead));
label("$\mathbf{u}$", a+1.15*u, dir(degrees(u)), uColor);

// The gradient vector, from a to the origin (its own length equals |a|).
draw(a--(a+g), gColor+linewidth(1.2), Arrow(TeXHead));
label("$\nabla f(\mathbf{a})$", a+g, NW, gColor);

// Right-angle drop from the gradient's tip to its foot on the u-line, and
// the projected segment itself, highlighting D_u f(a) as that length.
draw((a+g)--foot, gray(0.4)+dashed);
draw(a--foot, uColor+linewidth(2.2));
label("$D_{\mathbf{u}}f(\mathbf{a})$", 0.5*(a+foot) + 0.3*dir(degrees(u)+90), uColor);

// Angle between the gradient and u, at a.
real angG = degrees(g);
draw(arc(a, 0.45, angG, angG+theta), black);
label("$\theta$", a+0.65*dir(angG+theta/2), black);

dot(a, black+linewidth(3));
label("$\mathbf{a}$", a, dir(degrees(a)));
