// Unit circle with an angle theta, showing cos(theta) and sin(theta)
// as the horizontal and vertical legs of the reference triangle.

import geometry;

size(8cm);
defaultpen(fontsize(10pt));

real theta = 35;
pair O = (0, 0);
pair P = (Cos(theta), Sin(theta));
pair Px = (Cos(theta), 0);

// axes
draw((-1.4, 0)--(1.4, 0), Arrow(TeXHead));
draw((0, -1.4)--(0, 1.4), Arrow(TeXHead));
label("$x$", (1.4, 0), E);
label("$y$", (0, 1.4), N);

// unit circle
draw(circle(O, 1));

// angle arc
draw(arc(O, 0.25, 0, theta));
label("$\theta$", 0.36 * dir(theta / 2), dir(theta / 2));

// reference triangle
draw(O--P, blue + linewidth(1.2));
draw(Px--P, red + dashed);
draw(O--Px, heavygreen + linewidth(1.2));

// point on the circle
dot("$(\cos\theta, \sin\theta)$", P, NE);

// leg labels
label("$\cos\theta$", (O + Px) / 2, S, heavygreen);
label("$\sin\theta$", (Px + P) / 2, E, red);
