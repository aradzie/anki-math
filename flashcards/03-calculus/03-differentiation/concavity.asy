// Concavity: the graph of f lies below every tangent line where f is
// concave down, and above every tangent line where f is concave up. Each
// parabola gets three tangents -- one horizontal at the vertex, two
// diagonal at the sides -- to show the property holds at every point, not
// just one. f' is overlaid on the same axes (a straight line, since f is
// quadratic), with the two side tangent points linked down to their
// corresponding points on f', showing concave down/up as f' decreasing/
// increasing.

import graph;
import common;

size(20cm, 16cm, false);
mathdefaults();

real xr = 2.3;
real xt = 1.8;

real[] tangentXs(real dx) { return new real[] {dx - xt, dx, dx + xt}; }

void drawPanel(real f(real), real fp(real), real dx, string concaveCaption, string fpCaption) {
    drawAxes(dx - xr - 0.3, dx + xr + 0.3, -2.2, 4.4, ylabel="$y$", originx=dx);

    // f: curve, tangents, points
    draw(graph(f, dx - xr, dx + xr), blue + linewidth(1.2));
    for (real xi : tangentXs(dx)) {
        draw((xi - 1.0, f(xi) - 1.0*fp(xi))--(xi + 1.0, f(xi) + 1.0*fp(xi)), red + dashed);
        dot((xi, f(xi)));
    }

    // f': line and points, on the same axes
    draw((dx - xr, fp(dx - xr))--(dx + xr, fp(dx + xr)), heavygreen + linewidth(1.2));
    for (real xi : tangentXs(dx)) {
        dot((xi, fp(xi)), heavygreen);
        // skip the middle guide: f'(c) = 0 already sits right on the shared x-axis
        if (abs(xi - dx) > 0.01) {
            draw((xi, f(xi))--(xi, fp(xi)), gray + dotted);
        }
    }

    // curve labels
    real xl = dx - 1;
    label("$f$", (xl, f(xl)), N, blue);
    label("$f'$", (xl, fp(xl)), S, heavygreen);

    real capY = -2.8;
    label(concaveCaption, (dx, capY), N, blue);
    label(fpCaption, (dx, capY), S, heavygreen);
}

// --- left panel: concave down (downward parabola) ---
real dx1 = 0;
real f1(real x) { return -0.4*(x - dx1)^2 + 4; }
real f1p(real x) { return -0.8*(x - dx1); }
drawPanel(f1, f1p, dx1, "concave down: graph lies below every tangent", "$f'$ strictly decreasing");

// --- right panel: concave up (upward parabola) ---
real dx2 = 5.4;
real f2(real x) { return 0.4*(x - dx2)^2 + 1; }
real f2p(real x) { return 0.8*(x - dx2); }
drawPanel(f2, f2p, dx2, "concave up: graph lies above every tangent", "$f'$ strictly increasing");
