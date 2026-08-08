// The Tangent vector T at a point on a circular helix, with N and B shown
// dimmed for context.

import graph3;
import common3d;

mathdefaults();

real t0 = 1;

tnbCamera();
drawHelix(t0);

TNB f = helixTNB(t0);
triple p = helixPoint(t0);
drawTNBHighlight(p, f, "T");
