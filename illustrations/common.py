"""Shared PyVista scene helpers, camera/light setup, the z-height color ramp,
axis arrows, and final render/save all live here so each illustration script
only defines its own surface.
"""
from pathlib import Path

import numpy as np
import pyvista as pv

CAMERA_POSITION = (6, -8, 5)   # currentprojection camera= in common.asy
CAMERA_TARGET = (0, 0, 0)
CAMERA_UP = (0, 0, 1)
LIGHT_POSITION = (4, -6, 8)    # currentlight position in common.asy

SURFACE_LO = np.array([0.72, 0.83, 0.96])  # surfacepenlo
SURFACE_HI = np.array([0.20, 0.42, 0.68])  # surfacepenhi
SURFACE_OPACITY = 0.8

AXIS_COLOR = "black"
AXIS_ROD_RADIUS = 0.014
AXIS_HEAD_RADIUS = 0.045
AXIS_HEAD_LENGTH = 0.13


def parametric_surface(x, y, z):
    """Build a quad-celled surface from parametric coordinate grids.

    Uses StructuredGrid (not pv.Parametric*) so `show_edges` draws a clean
    lat/long grid instead of triangulated diagonals, and recomputes point
    normals so the u=0/u=2*pi seam shades smoothly instead of showing a
    visible crease.
    """
    mesh = pv.StructuredGrid(x, y, z).extract_surface(algorithm="dataset_surface")
    return mesh.compute_normals(
        point_normals=True, cell_normals=False, consistent_normals=True, feature_angle=180
    )


def make_plotter(window_size=(1280, 1280)):
    plotter = pv.Plotter(off_screen=True, window_size=window_size)
    plotter.set_background(None)  # transparent, matches the asy pngalpha output
    plotter.enable_depth_peeling(number_of_peels=8, occlusion_ratio=0.0)
    return plotter


def add_surface(plotter, mesh):
    """Color a surface by z-height using the same ramp as surfacepenlo/hi,
    and add it with the shared shading/grid style."""
    z = mesh.points[:, 2]
    z_norm = (z - z.min()) / (z.max() - z.min())
    colors = SURFACE_LO[None, :] + (SURFACE_HI - SURFACE_LO)[None, :] * z_norm[:, None]
    mesh["colors"] = (colors * 255).astype(np.uint8)
    plotter.add_mesh(
        mesh,
        scalars="colors",
        rgb=True,
        opacity=SURFACE_OPACITY,
        smooth_shading=True,
        specular=0.4,
        specular_power=20,
        show_edges=True,
        edge_color=(0.35, 0.35, 0.35),
        edge_opacity=0.6,
        line_width=0.6,
    )


def add_axes(plotter, length):
    """Arrow-tipped X/Y/Z rods plus $x$/$y$/$z$-style labels, matching
    addAxes(L) in common.asy."""
    for direction in (np.array([1, 0, 0]), np.array([0, 1, 0]), np.array([0, 0, 1])):
        arrow = pv.Arrow(
            start=(0, 0, 0),
            direction=direction,
            tip_length=AXIS_HEAD_LENGTH / length,
            tip_radius=AXIS_HEAD_RADIUS,
            shaft_radius=AXIS_ROD_RADIUS,
            scale=length,
        )
        plotter.add_mesh(arrow, color=AXIS_COLOR)

    label_at = length + 0.15
    plotter.add_point_labels(
        np.array([[label_at, 0, 0], [0, label_at, 0], [0, 0, label_at]]),
        ["x", "y", "z"],
        italic=True,
        bold=False,
        font_size=36,
        shape=None,
        show_points=False,
        text_color="black",
        always_visible=True,
    )


def render_scene(plotter, out_path):
    """Set the shared camera/light, then anti-alias and save, matching
    renderScene() in common.asy.

    Surfaces here range from ~1 unit (ellipsoid) to ~4 units (paraboloids)
    across, so a fixed camera distance either leaves huge margins or clips
    through the mesh. `camera_position` only sets the view *direction* (a
    unit vector from CAMERA_TARGET); reset_camera() then places the camera
    along that same direction at whatever distance fits this scene's actual
    bounds, and fixes up the near/far clipping range to match.
    """
    direction = np.array(CAMERA_POSITION, dtype=float) - np.array(CAMERA_TARGET, dtype=float)
    direction /= np.linalg.norm(direction)
    plotter.camera_position = [
        tuple(np.array(CAMERA_TARGET, dtype=float) + direction),
        CAMERA_TARGET,
        CAMERA_UP,
    ]
    plotter.camera.SetViewAngle(30)
    plotter.reset_camera()
    plotter.camera.SetViewAngle(30)
    plotter.camera.Zoom(0.85)  # a little breathing room around the fitted bounds

    plotter.remove_all_lights()
    key_light = pv.Light(position=LIGHT_POSITION, light_type="scene light")
    key_light.intensity = 0.9
    plotter.add_light(key_light)
    plotter.add_light(pv.Light(light_type="headlight", intensity=0.25))

    plotter.enable_anti_aliasing("ssaa")
    out_path = Path(out_path)
    plotter.screenshot(str(out_path), transparent_background=True)
    print("wrote", out_path)
