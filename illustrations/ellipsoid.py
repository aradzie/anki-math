"""Ellipsoid quadric, rendered with PyVista."""
from pathlib import Path

import numpy as np

import common

a, b, c = 1.0, 1.0, 1.0

theta = np.linspace(0, np.pi, 17)
phi = np.linspace(0, 2 * np.pi, 25)
theta, phi = np.meshgrid(theta, phi, indexing="ij")

mesh = common.parametric_surface(
    a * np.sin(theta) * np.cos(phi),
    b * np.sin(theta) * np.sin(phi),
    c * np.cos(theta),
)

plotter = common.make_plotter()
common.add_surface(plotter, mesh)
common.add_axes(plotter, length=1.5)
common.render_scene(plotter, Path(__file__).with_name("ellipsoid.png"))
