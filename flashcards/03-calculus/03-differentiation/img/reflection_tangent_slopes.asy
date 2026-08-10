// The graph of f^{-1} is the reflection of the graph of f across y=x.
// Under this reflection, a tangent line of slope m at (a,f(a)) becomes a
// tangent line of slope 1/m at the reflected point (f(a),a).

import graph;
import common;

size(10cm, 10cm);
mathdefaults();

real f(real x) { return x^2; }
real finv(real x) { return sqrt(x); }

real xmax = 3.0;

real a = 1.2;
real fa = f(a); // 2.25
real m = 2 * a; // f'(a) = 3
real minv = 1 / m; // (f^{-1})'(f(a))

pair Pf = (a, fa);
pair Pinv = (fa, a);

drawAxes(-0.3, xmax, -0.3, xmax);

// mirror line
draw((-0.3, -0.3)--(xmax, xmax), gray + dashed);
label("$y=x$", (xmax - 0.3, xmax - 0.3), SE, gray);

// curves
real fDomainMax = sqrt(xmax);
draw(graph(f, 0, fDomainMax), blue + linewidth(0.8));
label("$y=f(x)$", (fDomainMax, f(fDomainMax)), W, blue);

draw(graph(finv, 0, xmax), heavygreen + linewidth(0.8));
label("$y=f^{-1}(x)$", (xmax, finv(xmax)), NW, heavygreen);

// tangent lines
real t = 0.45;
pair df = unit((1, m));
draw(Pf - t * df--Pf + t * df, blue + linewidth(1.2));
label("slope $f'(a)$", Pf + 0.4 * df, N, blue);

pair dinv = unit((1, minv));
draw(Pinv - t * dinv--Pinv + t * dinv, heavygreen + linewidth(1.2));
label("slope $1/f'(a)$", Pinv + 0.45 * dinv, E, heavygreen);

dot("$(a,f(a))$", Pf, W, blue);
dot("$(f(a),a)$", Pinv, SE, heavygreen);
