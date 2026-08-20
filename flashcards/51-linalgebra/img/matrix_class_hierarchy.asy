// The classes of triangular matrices form a Venn diagram, not a flat list:
// a matrix that is both upper- and lower-triangular is exactly a diagonal
// matrix (entries above AND below the diagonal are zero), and the identity
// matrix is one further-specialized diagonal matrix.

import common;

size(10cm);
mathdefaults();

pair cU = (-1.1, 0);
pair cL = (1.1, 0);
real r = 2.2;

path upperCircle = circle(cU, r);
path lowerCircle = circle(cL, r);

fill(upperCircle, blue + opacity(0.12));
fill(lowerCircle, red + opacity(0.12));
draw(upperCircle, blue);
draw(lowerCircle, red);

label("Upper-triangular", cU + (-1.3, 2.0), blue);
label("Lower-triangular", cL + (1.3, 2.0), red);

label("Diagonal", (0, 1.35));

pair cI = (0, -0.7);
real rI = 0.6;
filldraw(circle(cI, rI), white, black);
label("$I$", cI);
label("Identity", cI + (0, -1.0));

// pad the frame so the "Identity" label's descender isn't clipped
draw((-3.3, -3.4)--(-3.3, -3.4), invisible);
