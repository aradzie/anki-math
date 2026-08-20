// A parametrized surface r: D subset R^2 -> R^3 as a mapping: the domain
// region D sits on the left as a plain rectangle in the (u,v)-plane, its
// image sheet in R^3 sits on the right (drawn as a u/v coordinate grid),
// and a dashed arrow ties a marked domain point (u0,v0) to its image
// r(u0,v0).
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

size(13cm, 7.5cm);
triple target = (0.4, 0, 0.2);
currentprojection = perspective(camera=target+(7,-9,6), up=Z,
                                 target=target, autoadjust=false);

real uLo = -1.4, uHi = 1.4;
real vLo = -1.4, vHi = 1.4;
real u0 = 0.6, v0 = -0.5;

// A genuinely curved (non-flat) sheet -- not a graph of a single-variable
// slice, so the picture doesn't read as "surface = height field only".
triple surfacePoint(real u, real v) {
    return (u, v, 0.4*sin(1.6*u)*cos(1.6*v));
}

// Domain rectangle D, drawn as a plain 2D (u,v) axis system off to the
// side, kept well clear of the surface's projected extent.
pair domainOrigin = (-5.8, -0.3);
real domainScale = 0.75;
pair domainPoint(real u, real v) {
    return domainOrigin + domainScale*(u - uLo, v - vLo);
}

pair Dsw = domainPoint(uLo, vLo);
pair Dse = domainPoint(uHi, vLo);
pair Dnw = domainPoint(uLo, vHi);
pair Dne = domainPoint(uHi, vHi);
draw(Dsw--Dse--Dne--Dnw--cycle, black+linewidth(0.8));

draw(Dsw--(Dse+(0.6,0)), black+linewidth(1), Arrow(TeXHead));
label("$u$", Dse+(0.8,0), E);
draw(Dsw--(Dnw+(0,0.6)), black+linewidth(1), Arrow(TeXHead));
label("$v$", Dnw+(0,0.8), N);

dot(domainPoint(u0, v0), black+linewidth(2.5));
label("$(u_0,v_0)$", domainPoint(u0, v0), S);

// Image sheet r(D) in R^3, drawn as a u/v coordinate grid.
int n = 10;
int m = 40;
pen gridpen = gray(0.55)+linewidth(0.4);
for (int i = 0; i <= n; ++i) {
    real u = uLo + (uHi-uLo)*i/n;
    guide g;
    for (int j = 0; j <= m; ++j) {
        real v = vLo + (vHi-vLo)*j/m;
        pair pt = proj(surfacePoint(u, v));
        g = (j == 0) ? pt : g--pt;
    }
    draw(g, gridpen);
}
for (int j = 0; j <= n; ++j) {
    real v = vLo + (vHi-vLo)*j/n;
    guide g;
    for (int i = 0; i <= m; ++i) {
        real u = uLo + (uHi-uLo)*i/m;
        pair pt = proj(surfacePoint(u, v));
        g = (i == 0) ? pt : g--pt;
    }
    draw(g, gridpen);
}

pair P0 = proj(surfacePoint(u0, v0));
dot(P0, black+linewidth(2.5));
label("$\mathbf{r}(u_0,v_0)$", P0, NE);

// Dashed arrow from the domain point to its image, labeled by the map r.
draw(domainPoint(u0, v0)--P0, gray(0.2)+linewidth(0.8)+dashed,
     Arrow(TeXHead));
label("$\mathbf{r}$", 0.5*(domainPoint(u0, v0)+P0), N);
