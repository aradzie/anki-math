// Inflection point: f(x) = sin(x). Concavity reverses at every x = k*pi,
// where sin(x) = 0 -- concave up on (-pi, 0) and (pi, 2*pi), concave down on
// (0, pi) -- and the tangent line at each such point crosses the curve
// rather than staying on one side of it. Unlike x^3 (where the inflection
// point at c = 0 is also a critical point, f'(0) = 0), these inflection
// points are not critical points: f'(x) = cos(x) = +-1 there, never 0, so
// each tangent is diagonal rather than horizontal.

import graph;
import common;

size(24cm, 10cm);
mathdefaults();

real f(real x) { return sin(x); }
real fp(real x) { return cos(x); }

real xmin = -pi - 1.3;
real xmax = 2*pi + 1.3;
real ymin = -1.8;
real ymax = 1.8;

// axes
drawAxes(xmin - 0.4, xmax + 0.4, ymin, ymax);

// inflection points, generic labels, and diagonal tangents
real[] cs = {-pi, 0, pi, 2*pi};
string[] labs = {"$c_1$", "$c_2$", "$c_3$", "$c_4$"};

// vertical guides marking the concavity interval boundaries, drawn before
// the curve so the curve and dots sit on top
for (real ci : cs) {
    verticalGuide((ci, 0), ymin, ymax);
}

// curve, with f' overlaid to show it has a local extremum at each c_i
// (rather than a zero -- confirming c_i is not a critical point). f' is
// drawn in the same dashed style as the diagonal tangents, differing only
// in color, since both convey "derivative information" rather than f
// itself.
pen diagonalStyle = dashed;
draw(graph(f, xmin, xmax), blue + linewidth(1.2));
draw(graph(fp, xmin, xmax), heavygreen + diagonalStyle);

// placed in the gap between the c_1 and c_2 tangent segments, where the
// curves are well separated; each label is pushed away from the other
// curve rather than toward it
real xl = -1.3;
label("$f$", (xl, f(xl)), S, blue);
label("$f'$", (xl, fp(xl)), N, heavygreen);

for (int i = 0; i < cs.length; ++i) {
    real ci = cs[i];
    real slope = fp(ci);
    pair p1 = (ci - 1.0, -1.0 * slope);
    pair p2 = (ci + 1.0, 1.0 * slope);
    draw(p1 -- p2, red + diagonalStyle);
    closedPoint((ci, 0), black);
    // Alternate the label to the left/right of its guide line rather than
    // stacking every label below the dot -- also sidesteps c_2 sitting
    // right on the y-axis. Push the anchor out past the dot's radius so
    // the label doesn't sit on top of it.
    bool onLeft = i % 2 == 0;
    label(labs[i], (ci + (onLeft ? -0.25 : 0.25), -0.2), onLeft ? SW : SE);
    if (i == 0) label("tangent", p1, NW, red);
}

label("concave up", (-pi/2, -1.45), blue);
label("concave down", (pi/2, 1.45), blue);
label("concave up", (3*pi/2, -1.45), blue);
