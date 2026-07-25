"""Elliptic (double-napped) cone, rendered with PyVista."""
from pathlib import Path

import numpy as np

import common

a, b, c = 1.0, 1.0, 1.0
R = 1.3

r = np.linspace(0, R, 11)
v = np.linspace(0, 2 * np.pi, 25)
r, v = np.meshgrid(r, v, indexing="ij")

x = a * r * np.cos(v)
y = b * r * np.sin(v)

top = common.parametric_surface(x, y, c * r)
bottom = common.parametric_surface(x, y, -c * r)

plotter = common.make_plotter()
common.add_surface(plotter, top)
common.add_surface(plotter, bottom)
common.add_axes(plotter, length=2.0)
common.render_scene(plotter, Path(__file__).with_name("elliptic_cone.png"))
