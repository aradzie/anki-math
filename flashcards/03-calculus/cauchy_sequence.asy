// A Cauchy sequence: terms oscillate but the oscillation decays, so
// eventually all terms fall within an epsilon-band of each other.

import graph;

size(20cm, 10cm);
defaultpen(fontsize(10pt));

real L = 3;      // candidate limit
real eps = 0.4;  // epsilon
int ntail = 6;   // tail index: for all n >= ntail, |a_n - L| < eps
int nmax = 14;

real a(int n) {
  real sign = (n % 2 == 0) ? 1 : -1;
  return L + 2 * sign / n;
}

int midx = 8;   // a_m
int nidx = 12;  // a_n

real xmax = 15;    // right edge of the axis and epsilon-band lines
real annox = 16.3; // left edge of the annotation column, past the axis arrow
real ytop = 5;
real ybot = 0;

// axes
draw((0, 0)--(xmax + 0.8, 0), Arrow(TeXHead));
draw((0, ybot)--(0, ytop), Arrow(TeXHead));
label("$n$", (xmax + 0.8, 0), E);

// sequence path, to show the oscillation decaying
for (int n = 1; n < nmax; ++n) {
  draw((n, a(n))--(n + 1, a(n + 1)), gray + linewidth(0.5) + dashed);
}

// epsilon band around L
draw((0, L)--(xmax, L), heavygreen + dashed);
draw((0, L + eps)--(xmax, L + eps), heavygreen + dashed);
draw((0, L - eps)--(xmax, L - eps), heavygreen + dashed);
label("$L$", (0, L), W, heavygreen);
label("$L+\varepsilon$", (0, L + eps), W, heavygreen);
label("$L-\varepsilon$", (0, L - eps), W, heavygreen);

// epsilon brace, in the annotation column
real bx = annox;
draw((bx, L)--(bx, L + eps), heavygreen + linewidth(0.8));
draw((bx - 0.15, L)--(bx + 0.15, L), heavygreen + linewidth(0.8));
draw((bx - 0.15, L + eps)--(bx + 0.15, L + eps), heavygreen + linewidth(0.8));
label("$\varepsilon$", (bx + 0.35, L + eps / 2), heavygreen);

// N: tail beyond which all terms lie inside the epsilon band
draw((ntail, 0)--(ntail, ytop), purple + dashed);
label("$N$", (ntail, 0), S, purple);

// sequence dots: blue before the tail, green from N onward
for (int n = 1; n < ntail; ++n) {
  dot((n, a(n)), blue);
}
for (int n = ntail; n <= nmax; ++n) {
  dot((n, a(n)), heavygreen);
}

// guides down to the axis for the highlighted pair a_m, a_n
draw((midx, 0)--(midx, a(midx)), dotted);
draw((nidx, 0)--(nidx, a(nidx)), dotted);
label("$m$", (midx, 0), S);
label("$n$", (nidx, 0), S);

// highlighted pair a_m, a_n
dot("$a_m$", (midx, a(midx)), N, red);
dot("$a_n$", (nidx, a(nidx)), N, red);

// direct comparison: connect the pair and state the inequality above the segment
draw((midx, a(midx))--(nidx, a(nidx)), red + dotted);
label("$|a_n - a_m| < \varepsilon$", ((midx + nidx) / 2, max(a(midx), a(nidx)) + 0.35), red);
