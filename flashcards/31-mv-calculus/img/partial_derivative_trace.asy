// Geometric interpretation of f_x(a,b) and f_y(a,b): slicing the surface
// z = f(x,y) with the planes y=b and x=a gives two trace curves, and each
// partial derivative is the slope of one trace curve at (a,b,f(a,b)).
//
// Manual projection throughout (no path3/size3): the two plane fills are
// flat 2D content, and mixing that with real path3 draws in the same
// picture makes Asymptote silently double-emit the fills (see
// generate-illustrations SKILL.md, "Flat fills in 3D scenes").

import three;
import common3d;

mathdefaults();

real L = 1.6;      // domain half-extent in x and y
real C = 2.2;       // surface peak height
real a = 0.8, b = -0.6;   // point of evaluation (a,b)
real zLow = -0.5, zHigh = 2.5;   // vertical extent of the cutting planes

real f(real x, real y) { return C - 0.5*x*x - 0.5*y*y; }
real fx = -a;   // partial derivative d/dx f(x,y) = -x, at x=a
real fy = -b;   // partial derivative d/dy f(x,y) = -y, at y=b

pen xColor = red;    // associated with the y=b slice / f_x
pen yColor = blue;   // associated with the x=a slice / f_y

triple target = (0,0,1.1);
size(10cm,10cm);
currentprojection = perspective(camera=target+(7,-9,6), up=Z,
                                 target=target, autoadjust=false);

triple P = (a,b,f(a,b));

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

guide traceCurveXdir(real yFixed) {
    int m = 40;
    guide g;
    for (int i = 0; i <= m; ++i) {
        real x = -L + 2*L*i/m;
        pair pt = proj((x,yFixed,f(x,yFixed)));
        g = (i == 0) ? pt : g--pt;
    }
    return g;
}

guide traceCurveYdir(real xFixed) {
    int m = 40;
    guide g;
    for (int i = 0; i <= m; ++i) {
        real y = -L + 2*L*i/m;
        pair pt = proj((xFixed,y,f(xFixed,y)));
        g = (i == 0) ? pt : g--pt;
    }
    return g;
}

void drawPlaneY(real yFixed, pen color) {
    filldraw(proj((-L,yFixed,zLow))--proj((L,yFixed,zLow))--
             proj((L,yFixed,zHigh))--proj((-L,yFixed,zHigh))--cycle,
             color+opacity(0.15), color+linewidth(0.5));
}

void drawPlaneX(real xFixed, pen color) {
    filldraw(proj((xFixed,-L,zLow))--proj((xFixed,L,zLow))--
             proj((xFixed,L,zHigh))--proj((xFixed,-L,zHigh))--cycle,
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
drawPlaneY(b, xColor);
drawPlaneX(a, yColor);
draw(traceCurveXdir(b), xColor+linewidth(1.2));
draw(traceCurveYdir(a), yColor+linewidth(1.2));
drawAxisGizmo();

// Tangent lines at P, one per trace curve, showing the two slopes. Each
// extends further on the labeled end than the other, so the two labels
// land apart instead of crowding together near P.
real dxNear = 0.35, dxFar = 0.9;
triple t1a = (a-dxNear, b, f(a,b)-fx*dxNear);
triple t1b = (a+dxFar, b, f(a,b)+fx*dxFar);
draw(proj(t1a)--proj(t1b), xColor+linewidth(1)+dashed);
label("$f_x(a,b)$", proj(t1b), SE, xColor);

real dyNear = 0.35, dyFar = 0.9;
triple t2a = (a, b-dyFar, f(a,b)-fy*dyFar);
triple t2b = (a, b+dyNear, f(a,b)+fy*dyNear);
draw(proj(t2a)--proj(t2b), yColor+linewidth(1)+dashed);
label("$f_y(a,b)$", proj(t2a), NW, yColor);

dot(proj(P), black+linewidth(3));
label("$(a,b)$", proj((a,b,zLow)), S);

label("$y=b$", proj((L+0.1,b,zLow)), E, xColor);
label("$x=a$", proj((a,L+0.1,zLow)), E, yColor);
