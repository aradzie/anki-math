// The normal plane at a point on a circular helix: spanned by N and B,
// with normal vector T.

import graph3;
import common3d;

mathdefaults();

real t0 = 1;

tnbCamera();
drawHelix(t0);

TNB f = helixTNB(t0);
triple p = helixPoint(t0);
drawPlane(p, f.N, f.B, Tcolor);
drawTNB(p, f);
