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
