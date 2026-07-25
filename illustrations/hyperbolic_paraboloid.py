"""Hyperbolic paraboloid z = x^2/a^2 - y^2/b^2, rendered with PyVista."""
from pathlib import Path

import numpy as np

import common

a, b = 1.0, 1.0
L = 1.3

x = np.linspace(-L, L, 21)
y = np.linspace(-L, L, 21)
x, y = np.meshgrid(x, y, indexing="ij")
z = (x**2) / a**2 - (y**2) / b**2

mesh = common.parametric_surface(x, y, z)

plotter = common.make_plotter()
common.add_surface(plotter, mesh)
common.add_axes(plotter, length=2.0)
common.render_scene(plotter, Path(__file__).with_name("hyperbolic_paraboloid.png"))
