// int_a^b f(x) dx = int_{a+c}^{a+c} f(x-c) dx: translating the interval and
// the integrand by the same constant c leaves the signed area unchanged.
// The region under f(x-c) on [a+c,b+c] is a rigid horizontal copy of the
// region under f on [a,b], shifted right by c.

import graph;
import common;

size(15cm, 8cm, false);
mathdefaults();

real c = 3;
real a = 0;
real b = 2;

real f(real x) { return 1.2 + 0.6 * sin(1.6 * x); }
real g(real x) { return f(x - c); }

real ymax = 2.6;

// axes -- curves are labeled directly, so omit the generic y-axis label to
// leave headroom for the caption above
drawAxes(a - 0.6, b + c + 0.8, -0.3, ymax, ylabel="");

// original region: int_a^b f(x) dx
path region1 = (a, 0)--graph(f, a, b)--(b, 0)--cycle;
fill(region1, blue + opacity(0.25));
draw(graph(f, a, b), blue + linewidth(1.6));

// translated region: int_{a+c}^{b+c} f(x-c) dx, a rigid copy shifted by c
path region2 = (a + c, 0)--graph(g, a + c, b + c)--(b + c, 0)--cycle;
fill(region2, heavygreen + opacity(0.25));
draw(graph(g, a + c, b + c), heavygreen + linewidth(1.6));

// translation arrow between corresponding points, showing the shift by c
real xmid = (a + b) / 2;
pair p1 = (xmid, f(xmid) + 0.2);
pair p2 = (xmid + c, f(xmid) + 0.2);
draw(p1--p2, gray, Arrow(TeXHead));
label("$c$", (p1 + p2) / 2, N, gray);

// interval endpoints
dropToXAxis((a, f(a)));
dropToXAxis((b, f(b)));
dropToXAxis((a + c, g(a + c)));
dropToXAxis((b + c, g(b + c)));
label("$a$", (a, 0), S);
label("$b$", (b, 0), S);
label("$a+c$", (a + c, 0), S);
label("$b+c$", (b + c, 0), S);

label("$y=f(x)$", (b, f(b)), NE, blue);
label("$y=f(x-c)$", (b + c, g(b + c)), NE, heavygreen);

label("$\displaystyle\int_a^b f(x)\,dx = \int_{a+c}^{b+c} f(x-c)\,dx$",
      ((a + b + c) / 2 + c / 2, ymax), N);
