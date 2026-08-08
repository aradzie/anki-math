// Shared 3D Asymptote helpers.
//
// Import with `import common3d;` -- this resolves from any subdirectory
// because compilation always runs with flashcards/ as the working directory.
// Parallel to (not merged into) common.asy, which holds 2D-only helpers.
//
// Everything here is drawn as plain 2D content (pair paths), never path3 /
// size3(). We only use `three`'s `triple` type and `project()` as pure
// geometry helpers to turn 3D points into 2D ones ourselves; the picture
// itself stays a normal 2D picture, fit with plain size(). This is
// deliberate: mixing real path3 draws (which Asymptote auto-fits via
// size3() at shipout) with manually `project()`-ed 2D fills in the same
// picture makes Asymptote silently emit each manual fill twice -- once at
// the correct fitted scale, once more as a small stray duplicate near the
// fill's source point. Keeping every element (curve, vectors, planes) as
// plain 2D content sidesteps that entirely, since plain 2D pictures only
// ever get fit once, the same way every other (2D) illustration in this
// repo already works.

import three;    // triple, projection, perspective, cross, unit, project
import common;   // mathdefaults(), for stylistic parity with 2D files

// TNB color convention shared by every illustration in this family: T, N, B
// are always red/green/blue, and a plane's translucent fill always matches
// the color of its own normal vector.
pen Tcolor = red;
pen Ncolor = heavygreen;
pen Bcolor = blue;
pen curvepen = gray(0.35);

real vectorLength = 1;      // physical length of a drawn T/N/B arrow
real planeHalfwidth = 1.6;  // half-extent of a drawn plane quad
real planeOpacity = 0.35;   // fill opacity of a drawn plane quad

// Gap between an arrowhead and its label, as extra length along the same
// direction the arrow points -- keeps the label from crowding the tip.
real labelGap = 0.35;

// Camera/canvas setup shared verbatim by all five TNB illustrations, so
// the family reads as one consistent set. `target` should sit near the
// curve's point of evaluation so it stays centered in frame.
void tnbCamera(triple target=(0,0,0.5)) {
    size(7cm, 7cm);
    currentprojection = perspective(camera=target+(6,-7,9), up=Z,
                                     target=target, autoadjust=false);
}

// Every 3D point in this family goes through this one helper, so the
// curve, vectors, and planes all land in exactly the same 2D coordinate
// space and stay aligned with each other.
pair proj(triple v) {
    return project(v, currentprojection);
}

// Position on the circular helix r(t) = (a cos t, a sin t, b t).
triple helixPoint(real t, real a=1, real b=0.5) {
    return (a*cos(t), a*sin(t), b*t);
}
// r'(t), unnormalized.
triple helixVelocity(real t, real a=1, real b=0.5) {
    return (-a*sin(t), a*cos(t), b);
}
// r''(t), unnormalized.
triple helixAccel(real t, real a=1, real b=0.5) {
    return (-a*cos(t), -a*sin(t), 0);
}

// The right-handed orthonormal TNB frame at parameter t.
struct TNB { triple T, N, B; }

TNB helixTNB(real t, real a=1, real b=0.5) {
    TNB f;
    f.T = unit(helixVelocity(t, a, b));
    f.B = unit(cross(helixVelocity(t, a, b), helixAccel(t, a, b)));
    f.N = cross(f.B, f.T);   // N = B x T completes the right-handed triple
    return f;
}

// A bit more than one full turn of the helix, centered on t0, plus a
// filled dot marking the point of evaluation r(t0). A touch over one full
// turn (rather than exactly one) makes the coil visibly overlap itself in
// projection -- a single exact turn never self-crosses from any viewing
// angle, so it reads as a flat arc rather than a 3D coil.
void drawHelix(real t0, real a=1, real b=0.5, real turns=1.15) {
    real halfspan = turns*pi;
    int n = 120;
    guide g;
    for (int i = 0; i <= n; ++i) {
        real t = t0 - halfspan + (2*halfspan)*i/n;
        pair pt = proj(helixPoint(t, a, b));
        g = (i == 0) ? pt : g--pt;
    }
    draw(g, curvepen + linewidth(1));
    dot(proj(helixPoint(t0, a, b)), black);
}

// One TNB vector as a labeled arrow of length `len` from p, in direction
// dir (only its direction is used). `symbol` is bare, e.g. "T" -- wrapped
// in \mathbf{} here so call sites stay terse.
void drawFrameVector(triple p, triple dir, pen color, string symbol,
                      align labelAlign=NoAlign, real len=vectorLength) {
    triple tip = p + len*unit(dir);
    triple labelPos = p + (len + labelGap)*unit(dir);
    draw(proj(p)--proj(tip), color+linewidth(1.2), Arrow(TeXHead));
    label("$\mathbf{" + symbol + "}$", proj(labelPos), labelAlign, color);
}

// All three TNB vectors at p, in the shared color scheme -- used by every
// illustration in this family, planes or not.
void drawTNB(triple p, TNB f, align Talign=NoAlign, align Nalign=NoAlign,
             align Balign=NoAlign) {
    drawFrameVector(p, f.T, Tcolor, "T", Talign);
    drawFrameVector(p, f.N, Ncolor, "N", Nalign);
    drawFrameVector(p, f.B, Bcolor, "B", Balign);
}

// The plane through p spanned by directions u, v (need not be unit or
// orthogonal -- only their directions matter), drawn as a translucent flat
// color fill -- deliberately not a three.asy surface()/render(), so the
// scene stays vector SVG (see generate-illustrations SKILL.md: surface()/
// render()/lighting forces PNG raster output).
void drawPlane(triple p, triple u, triple v, pen fillcolor,
               real halfwidth=planeHalfwidth, real alpha=planeOpacity) {
    triple uu = halfwidth*unit(u);
    triple vv = halfwidth*unit(v);
    pair q0 = proj(p+uu+vv), q1 = proj(p+uu-vv),
         q2 = proj(p-uu-vv), q3 = proj(p-uu+vv);
    filldraw(q0--q1--q2--q3--cycle,
             fillcolor+opacity(alpha), fillcolor+linewidth(0.6));
}
