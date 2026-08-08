// The osculating plane at a point on a circular helix: spanned by T and N,
// with normal vector B.

import graph3;
import common3d;

mathdefaults();

real t0 = 1;

tnbCamera();
drawHelix(t0);

TNB f = helixTNB(t0);
triple p = helixPoint(t0);
drawPlane(p, f.T, f.N, Bcolor);
drawTNB(p, f);
