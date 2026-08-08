// The three TNB planes at a point on a circular helix, shown together:
// osculating (T,N; normal B), normal (N,B; normal T), and rectifying
// (T,B; normal N).

import graph3;
import common3d;

mathdefaults();

real t0 = 1;

tnbCamera();
drawHelix(t0);

TNB f = helixTNB(t0);
triple p = helixPoint(t0);
drawPlane(p, f.T, f.N, Bcolor);
drawPlane(p, f.N, f.B, Tcolor);
drawPlane(p, f.T, f.B, Ncolor);
drawTNB(p, f);
