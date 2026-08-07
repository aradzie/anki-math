// A partition P = {x_0, x_1, x_2, x_3, x_4} of [a,b], unevenly spaced, with
// each subinterval [x_{i-1}, x_i] bracketed and labeled by its length
// Delta x_i = x_i - x_{i-1}. Same partition points reused across the other
// illustrations in this file (riemann_sum, upper/lower Darboux sums).

size(15cm, 4cm, false);
defaultpen(fontsize(10pt));

real[] x = {0, 1, 1.8, 2.6, 4};
int n = x.length - 1;

// number line
draw((-0.4, 0)--(x[n] + 0.4, 0), Arrows(TeXHead));

// partition points
for (int i = 0; i <= n; ++i) {
  draw((x[i], -0.12)--(x[i], 0.12));
  string lbl = (i == 0) ? "x_0 = a" : (i == n) ? "x_" + string(n) + " = b" : "x_" + string(i);
  label("$" + lbl + "$", (x[i], 0.25), N);
}

// subinterval brackets with Delta x_i labels
for (int i = 1; i <= n; ++i) {
  real mid = (x[i - 1] + x[i]) / 2;
  draw((x[i - 1] + 0.05, -0.55)--(x[i] - 0.05, -0.55), Arrows(TeXHead, size=3));
  label("$\Delta x_" + string(i) + "$", (mid, -0.75), S);
}

label("$P = \{x_0, x_1, \dots, x_" + string(n) + "\}$", ((x[0] + x[n]) / 2, 1));
