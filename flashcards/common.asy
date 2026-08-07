// Shared Asymptote helpers for illustrations under flashcards/.
// Import with `import common;` -- this resolves from any subdirectory
// because compilation always runs with flashcards/ as the working directory.

// Default pen setup used by nearly every illustration in this repository.
void mathdefaults() {
    defaultpen(fontsize(10pt));
}

// Default radius for point markers on number lines and graphs.
real pointradius = 0.08;

// A filled point, e.g. an included endpoint of a closed interval.
void closedPoint(pair p, pen color=blue, real r=pointradius) {
    filldraw(circle(p, r), color);
}

// An open (hollow) point, e.g. an excluded endpoint of an open interval.
void openPoint(pair p, pen color=blue, real r=pointradius) {
    filldraw(circle(p, r), white, color);
}

// A dotted vertical guide line from a point down to the x-axis.
void dropToXAxis(pair p, pen guidepen=dotted) {
    draw((p.x, 0)--p, guidepen);
}

// A dotted horizontal guide line from a point in to the y-axis.
void dropToYAxis(pair p, pen guidepen=dotted) {
    draw((0, p.y)--p, guidepen);
}

// Standard Cartesian axes with arrowheads: the x-axis runs from xmin to
// xmax at y=0, the y-axis from ymin to ymax at x=originx (0 unless the
// picture holds multiple axis systems, e.g. side-by-side panels). Pass
// ylabel="" to omit the y-axis label, e.g. when the vertical quantity is
// already named by the curve itself.
void drawAxes(real xmin, real xmax, real ymin, real ymax,
              string xlabel="$x$", string ylabel="$y$", real originx=0) {
    draw((xmin, 0)--(xmax, 0), Arrow(TeXHead));
    draw((originx, ymin)--(originx, ymax), Arrow(TeXHead));
    label(xlabel, (xmax, 0), E);
    if (ylabel != "") label(ylabel, (originx, ymax), N);
}

// A 1D number line from xmin to xmax at y=0. Arrowed at the right end only
// by default; pass doubleArrow=true for a line with no distinguished
// direction (e.g. the reals extending both ways).
void numberLine(real xmin, real xmax, bool doubleArrow=false) {
    draw((xmin, 0)--(xmax, 0), doubleArrow ? Arrows(TeXHead) : Arrow(TeXHead));
}
