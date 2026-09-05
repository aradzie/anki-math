// A monotone, bounded sequence: increasing and bounded above by M, so it
// converges to its supremum L -- which need not equal M, the given bound.

import graph;
import common;

size(18cm, 10cm);
mathdefaults();

real L = 4;    // limit (the sequence's supremum)
real M = 5;    // upper bound from the hypothesis (need not be tight)
int nmax = 12;

real a(int n) {
  return L - 3 * 0.7^n;
}

real xmax = nmax + 1;
real ymin = 0;
real ymax = 6;

// axes
drawAxes(0, xmax, ymin, ymax, "$n$", "");

// sequence path, to show it climbing and flattening out
for (int n = 1; n < nmax; ++n) {
  draw((n, a(n))--(n + 1, a(n + 1)), gray + linewidth(0.5) + dashed);
}

// bound M: a hypothesis the sequence never crosses
draw((0, M)--(xmax, M), purple + dashed);
label("$M$", (0, M), W, purple);

// limit L: the supremum the sequence actually converges to, L <= M
draw((0, L)--(xmax, L), heavygreen + dashed);
label("$L$", (0, L), W, heavygreen);

// sequence dots
for (int n = 1; n <= nmax; ++n) {
  closedPoint((n, a(n)));
}
label("$a_n$", (nmax, a(nmax)), N);
