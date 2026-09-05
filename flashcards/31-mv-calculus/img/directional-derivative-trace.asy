// Geometric interpretation of D_u f(a): slicing the surface z=f(x,y) with
// the vertical plane through a spanned by an arbitrary direction u (not a
// coordinate axis) gives a trace curve, and D_u f(a) is that curve's slope
// at a. Companion to partial_derivative_trace.svg, generalizing the
// axis-aligned slices there to a general direction.
//
// Manual projection throughout (no path3/size3): the cutting-plane fill is
// flat 2D content, and mixing that with real path3 draws in the same
// picture makes Asymptote silently double-emit the fill (see
// generate-illustrations SKILL.md, "Flat fills in 3D scenes").

import three;
import common3d;

mathdefaults();

real L = 1.6;       // domain half-extent in x and y
real C = 2.2;        // surface peak height
pair a = (0.7,-0.4);  // point of evaluation a=(a1,a2), toward the viewer so the plane isn't near the grid's far edge
pair u = (Cos(30),Sin(30));  // unit direction, deliberately off-axis
real T = 1.0;         // trace/plane half-extent along u, clipped to the domain
real zLow = -0.5, zHigh = 2.5;   // vertical extent of the cutting plane

real f(real x, real y) { return C - 0.5*x*x - 0.5*y*y; }
real Duf = -a.x*u.x - a.y*u.y;   // D_u f(a) = grad f(a) . u = (-a1,-a2).u

pen uColor = purple;

triple target = (0,0,1.1);
size(10cm,10cm);
currentprojection = perspective(camera=target+(7,-9,6), up=Z,
                                 target=target, autoadjust=false);

triple P = (a.x,a.y,f(a.x,a.y));

// Wireframe grid of the surface.
void drawGrid() {
    int n = 8;
    int m = 24;
    pen gridpen = gray(0.65)+linewidth(0.4);
    for (int i = 0; i <= n; ++i) {
        real x = -L + 2*L*i/n;
        guide g;
        for (int j = 0; j <= m; ++j) {
            real y = -L + 2*L*j/m;
            pair pt = proj((x,y,f(x,y)));
            g = (j == 0) ? pt : g--pt;
        }
        draw(g, gridpen);
    }
    for (int j = 0; j <= n; ++j) {
        real y = -L + 2*L*j/n;
        guide g;
        for (int i = 0; i <= m; ++i) {
            real x = -L + 2*L*i/m;
            pair pt = proj((x,y,f(x,y)));
            g = (i == 0) ? pt : g--pt;
        }
        draw(g, gridpen);
    }
}

guide traceCurveU() {
    int m = 40;
    guide g;
    for (int i = 0; i <= m; ++i) {
        real t = -T + 2*T*i/m;
        real x = a.x + t*u.x, y = a.y + t*u.y;
        pair pt = proj((x,y,f(x,y)));
        g = (i == 0) ? pt : g--pt;
    }
    return g;
}

void drawPlaneU(pen color) {
    triple lo = (a.x-T*u.x, a.y-T*u.y, zLow);
    triple hi0 = (a.x-T*u.x, a.y-T*u.y, zHigh);
    triple hi1 = (a.x+T*u.x, a.y+T*u.y, zHigh);
    triple lo1 = (a.x+T*u.x, a.y+T*u.y, zLow);
    filldraw(proj(lo)--proj(lo1)--proj(hi1)--proj(hi0)--cycle,
             color+opacity(0.15), color+linewidth(0.5));
}

// Small coordinate-axis gizmo, off to the side, purely for orientation.
void drawAxisGizmo() {
    triple o = (-L-0.4, -L-0.4, zLow-0.1);
    real len = 0.6;
    draw(proj(o)--proj(o+(len,0,0)), black+linewidth(0.8), Arrow(TeXHead));
    label("$x$", proj(o+(len+0.2,0,0)));
    draw(proj(o)--proj(o+(0,len,0)), black+linewidth(0.8), Arrow(TeXHead));
    label("$y$", proj(o+(0,len+0.2,0)));
    draw(proj(o)--proj(o+(0,0,len)), black+linewidth(0.8), Arrow(TeXHead));
    label("$z$", proj(o+(0,0,len+0.2)));
}

drawGrid();
drawPlaneU(uColor);
draw(traceCurveU(), uColor+linewidth(1.2));
drawAxisGizmo();

// The direction vector u itself, drawn in the base plane from a.
triple uBase = (a.x,a.y,zLow);
triple uTip = (a.x+0.6*u.x, a.y+0.6*u.y, zLow);
draw(proj(uBase)--proj(uTip), uColor+linewidth(1.2), Arrow(TeXHead));
label("$\mathbf{u}$", proj(uTip), E, uColor);

// Tangent line at P, showing the slope D_u f(a).
real dNear = 0.35, dFar = 0.9;
triple ta = (a.x-dNear*u.x, a.y-dNear*u.y, f(a.x,a.y)-Duf*dNear);
triple tb = (a.x+dFar*u.x, a.y+dFar*u.y, f(a.x,a.y)+Duf*dFar);
draw(proj(ta)--proj(tb), uColor+linewidth(1)+dashed);
label("$D_{\mathbf{u}}f(\mathbf{a})$", proj(tb), E, uColor);

dot(proj(P), black+linewidth(3));
label("$\mathbf{a}$", proj((a.x,a.y,zLow)), S);
