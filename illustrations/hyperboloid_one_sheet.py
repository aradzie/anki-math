"""Hyperboloid of one sheet, rendered with PyVista."""
from pathlib import Path

import numpy as np

import common

a, b, c = 1.0, 1.0, 1.0
U = 1.0

u = np.linspace(-U, U, 13)
v = np.linspace(0, 2 * np.pi, 25)
u, v = np.meshgrid(u, v, indexing="ij")

mesh = common.parametric_surface(
    a * np.cosh(u) * np.cos(v),
    b * np.cosh(u) * np.sin(v),
    c * np.sinh(u),
)

plotter = common.make_plotter()
common.add_surface(plotter, mesh)
common.add_axes(plotter, length=2.0)
common.render_scene(plotter, Path(__file__).with_name("hyperboloid_one_sheet.png"))
