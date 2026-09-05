// Dependency tree for z=f(x(t),y(t)): z depends on x and y, which each
// depend on t. Each edge is labeled by the derivative it contributes, and
// dz/dt sums the two root-to-leaf products -- the chain rule read off the
// tree.

import common;

size(7cm);
mathdefaults();

pair z = (0,2.2);
pair x = (-1.4,1.0);
pair y = (1.4,1.0);
pair t = (0,-0.2);

real r = 0.32;   // node radius
pen edgepen = gray(0.35)+linewidth(0.9);

draw(z--x, edgepen);
draw(z--y, edgepen);
draw(x--t, edgepen);
draw(y--t, edgepen);

// Node bubbles drawn after the edges so they cleanly cap each line end.
void node(pair p, string s) {
    filldraw(circle(p, r), white, gray(0.4));
    label(s, p);
}
node(z, "$z$");
node(x, "$x$");
node(y, "$y$");
node(t, "$t$");

label("$\dfrac{\partial f}{\partial x}$", 0.5*(z+x)+(-0.35,0));
label("$\dfrac{\partial f}{\partial y}$", 0.5*(z+y)+(0.35,0));
label("$\dfrac{dx}{dt}$", 0.5*(x+t)+(-0.35,0));
label("$\dfrac{dy}{dt}$", 0.5*(y+t)+(0.35,0));
