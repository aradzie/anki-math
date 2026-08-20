// Cauchy principal value: p.v. int_{-infty}^{infty} x dx = 0, even though
// the ordinary improper integral diverges (int_0^infty x dx = infty and
// int_{-infty}^0 x dx = -infty). Shows the two triangular lobes -- one
// above the axis on [0,R], one below on [-R,0] -- whose areas are equal in
// magnitude and opposite in sign for every R, so they cancel exactly in
// the symmetric limit R -> infty.

import graph;
import common;

size(11cm, 7cm);
mathdefaults();

real R = 3.5;
real gap = 1.5;
real xmax = R + gap;
real xmin = -xmax;

real f(real x) { return x; }

// axes -- curve is labeled directly, so omit the generic y-axis label to
// leave headroom for the caption above
drawAxes(xmin - 0.4, xmax + 0.4, xmin, xmax, ylabel="");

// positive lobe: int_0^R x dx = R^2/2, above the axis
path posLobe = (0, 0)--(R, R)--(R, 0)--cycle;
fill(posLobe, blue + opacity(0.25));

// negative lobe: int_{-R}^0 x dx = -R^2/2, below the axis
path negLobe = (0, 0)--(-R, -R)--(-R, 0)--cycle;
fill(negLobe, red + opacity(0.25));

// curve, solid on [-R,R], dashed beyond to suggest R -> infty on both ends
draw(graph(f, xmin, -R), blue + linewidth(0.8) + dashed);
draw(graph(f, -R, R), blue + linewidth(1.6));
draw(graph(f, R, xmax), blue + linewidth(0.8) + dashed);
label("$y = x$", (R, f(R)), NW, blue);

// guides down to the axes
dropToXAxis((R, R));
dropToXAxis((-R, -R));
label("$R$", (R, -0.3));
label("$-R$", (-R, 0.3));

// signed areas
label("$+\frac{R^2}{2}$", (2 * R / 3, R / 3), blue);
label("$-\frac{R^2}{2}$", (-2 * R / 3, -R / 3), red);

// cancellation caption
label("$\displaystyle\int_{-R}^{R} x\,dx = \frac{R^2}{2} - \frac{R^2}{2} = 0$",
      (0, xmax), N);
