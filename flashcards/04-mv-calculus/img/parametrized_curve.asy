// A parametrized curve r: [a,b] -> R^3 as a mapping: the domain interval
// [a,b] sits on the left as a plain axis segment, its image curve in R^3
// sits on the right, and a dashed arrow ties a marked domain point t0 to
// its image r(t0).
//
// Manual projection throughout (no path3/size3): mixing real path3 draws
// with flat 2D content in the same picture makes Asymptote silently
// double-emit any flat fill (see generate-illustrations SKILL.md, "Flat
// fills in 3D scenes"). This scene has no fills, but stays consistent with
// the rest of the repo's 3D illustrations by routing every point through
// the same proj() helper.

import three;
import common3d;

mathdefaults();

size(11cm, 7cm);
triple target = (1, 0, 2);
// Orthographic, not perspective: a helix's circular sweep foreshortens
// sharply under perspective wherever its tangent points nearly straight
// at/away from the camera, which read as a spurious sharp bend. Parallel
// (orthographic) projection has no depth foreshortening at all, so a
// multi-turn helix renders as a uniform coil from any viewing angle.
currentprojection = orthographic(camera=target+(7,-9,6), up=Z,
                                  target=target);

real a = 0, b = 2.5*pi;
real t0 = 1.3*pi;

triple curvePoint(real t) { return helixPoint(t, 1, 0.32); }

// Domain interval [a,b], drawn as a plain 2D axis segment off to the side.
pair domainStart = (-3.6, -0.9);
real domainLen = 2.2;
pair domainPoint(real t) {
    return domainStart + ((t - a)/(b - a))*(domainLen, 0);
}

draw(domainPoint(a)--(domainPoint(b) + (0.3, 0)), black+linewidth(1),
     Arrow(TeXHead));
dot(domainPoint(a), black+linewidth(2));
label("$a$", domainPoint(a), S);
dot(domainPoint(b), black+linewidth(2));
label("$b$", domainPoint(b), S);
dot(domainPoint(t0), black+linewidth(2.5));
label("$t_0$", domainPoint(t0), S);

// Image curve r([a,b]) in R^3.
guide g;
int n = 120;
for (int i = 0; i <= n; ++i) {
    real t = a + (b-a)*i/n;
    pair pt = proj(curvePoint(t));
    g = (i == 0) ? pt : g--pt;
}
draw(g, gray(0.35)+linewidth(1));

pair Pt0 = proj(curvePoint(t0));
dot(Pt0, black+linewidth(2.5));
label("$\mathbf{r}(t_0)$", Pt0, NW);

// Dashed arrow from the domain point to its image, labeled by the map r.
draw(domainPoint(t0)--Pt0, gray(0.2)+linewidth(0.8)+dashed, Arrow(TeXHead));
