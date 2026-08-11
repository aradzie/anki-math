// The TNB (Tangent/Normal/Binormal) frame at a point on a circular helix.

import graph3;
import common3d;

mathdefaults();

real t0 = 1;

tnbCamera();
drawHelix(t0);

TNB f = helixTNB(t0);
triple p = helixPoint(t0);
drawTNB(p, f);
