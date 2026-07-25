"""Hyperboloid of two sheets, rendered with PyVista."""
from pathlib import Path

import numpy as np

import common

a, b, c = 0.65, 0.65, 0.8
U = 1.7

u = np.linspace(0, U, 11)
v = np.linspace(0, 2 * np.pi, 25)
u, v = np.meshgrid(u, v, indexing="ij")

x = a * np.sinh(u) * np.cos(v)
y = b * np.sinh(u) * np.sin(v)

top = common.parametric_surface(x, y, c * np.cosh(u))
bottom = common.parametric_surface(x, y, -c * np.cosh(u))

plotter = common.make_plotter()
common.add_surface(plotter, top)
common.add_surface(plotter, bottom)
common.add_axes(plotter, length=3.0)
common.render_scene(plotter, Path(__file__).with_name("hyperboloid_two_sheets.png"))
