#!/usr/bin/env -S uv run
# /// script
# dependencies = [
#   "matplotlib",
#   "numpy",
# ]
# ///

"""Render a quadric surface as a transparent PNG with an xy-plane grid and
origin-centered axes, matching this directory's flashcard illustration style.

Usage: ./quadric.py --shape ellipsoid
"""

import argparse

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import LightSource
from matplotlib.patches import FancyArrowPatch
from mpl_toolkits.mplot3d import proj3d


SURFACE_COLOR = "firebrick"
SURFACE_ALPHA = 0.7
GRID_COLOR = "0.6"
GRID_ALPHA = 0.5
AXIS_COLOR = "0.45"
AXIS_ALPHA = 0.65
RESOLUTION = 100
GRID_DIVISIONS = 18
ELEV, AZIM = 18, 45
LIGHT = LightSource(azdeg=315, altdeg=18)
FIGSIZE = 8.0
DPI = 300


class Arrow3D(FancyArrowPatch):
    def __init__(self, xs, ys, zs, *args, **kwargs):
        super().__init__((0, 0), (0, 0), *args, **kwargs)
        self._verts3d = xs, ys, zs

    def do_3d_projection(self, renderer=None):
        xs3d, ys3d, zs3d = self._verts3d
        xs, ys, zs = proj3d.proj_transform(xs3d, ys3d, zs3d, self.axes.M)
        self.set_positions((xs[0], ys[0]), (xs[1], ys[1]))
        return min(zs)


def ellipsoid():
    phi = np.linspace(0, np.pi, RESOLUTION)
    theta = np.linspace(0, 2 * np.pi, RESOLUTION)
    phi, theta = np.meshgrid(phi, theta)
    x = np.sin(phi) * np.cos(theta)
    y = np.sin(phi) * np.sin(theta)
    z = np.cos(phi)
    return {
        "surfaces": [(x, y, z)],
        "xlim": (-1.5, 1.5),
        "ylim": (-1.5, 1.5),
        "zlim": (-1.5, 1.5),
        "grid_half": 1.5,
    }


def elliptic_paraboloid():
    r = np.linspace(0, 1.3, RESOLUTION)
    theta = np.linspace(0, 2 * np.pi, RESOLUTION)
    r, theta = np.meshgrid(r, theta)
    x = r * np.cos(theta)
    y = r * np.sin(theta)
    z = r**2
    return {
        "surfaces": [(x, y, z)],
        "xlim": (-1.3, 1.3),
        "ylim": (-1.3, 1.3),
        "zlim": (0, 1.9),
        "grid_half": 1.3,
    }


def hyperbolic_paraboloid():
    x = np.linspace(-1.2, 1.2, RESOLUTION)
    y = np.linspace(-1.2, 1.2, RESOLUTION)
    x, y = np.meshgrid(x, y)
    z = x**2 - y**2
    return {
        "surfaces": [(x, y, z)],
        "xlim": (-1.3, 1.3),
        "ylim": (-1.3, 1.3),
        "zlim": (-1.5, 1.5),
        "grid_half": 1.3,
    }


def hyperboloid_one_sheet():
    z = np.linspace(-1.3, 1.3, RESOLUTION)
    theta = np.linspace(0, 2 * np.pi, RESOLUTION)
    z, theta = np.meshgrid(z, theta)
    r = np.sqrt(1 + z**2)
    x = r * np.cos(theta)
    y = r * np.sin(theta)
    return {
        "surfaces": [(x, y, z)],
        "xlim": (-1.7, 1.7),
        "ylim": (-1.7, 1.7),
        "zlim": (-1.3, 1.3),
        "grid_half": 1.7,
    }


def hyperboloid_two_sheets():
    u_max = 1.19  # cosh(u_max) ~= 1.8
    vertex_gap = 0.4  # distance from each vertex to the xy-plane
    u = np.linspace(0, u_max, RESOLUTION)
    theta = np.linspace(0, 2 * np.pi, RESOLUTION)
    u, theta = np.meshgrid(u, theta)
    r = np.sinh(u)
    x = r * np.cos(theta)
    y = r * np.sin(theta)
    # cosh(u) - 1 keeps each bowl's own radius-vs-height curve unchanged;
    # vertex_gap then sets how close the vertex sits to the xy-plane.
    z = vertex_gap + (np.cosh(u) - 1)
    return {
        "surfaces": [(x, y, z), (x, y, -z)],
        "xlim": (-1.6, 1.6),
        "ylim": (-1.6, 1.6),
        "zlim": (-1.3, 1.3),
        "grid_half": 1.6,
    }


def elliptic_cone():
    r = np.linspace(0, 1.3, RESOLUTION)
    theta = np.linspace(0, 2 * np.pi, RESOLUTION)
    r, theta = np.meshgrid(r, theta)
    x = r * np.cos(theta)
    y = r * np.sin(theta)
    return {
        "surfaces": [(x, y, r), (x, y, -r)],
        "xlim": (-1.3, 1.3),
        "ylim": (-1.3, 1.3),
        "zlim": (-1.3, 1.3),
        "grid_half": 1.3,
    }


SHAPES = {
    "ellipsoid": ellipsoid,
    "elliptic_paraboloid": elliptic_paraboloid,
    "hyperbolic_paraboloid": hyperbolic_paraboloid,
    "hyperboloid_one_sheet": hyperboloid_one_sheet,
    "hyperboloid_two_sheets": hyperboloid_two_sheets,
    "elliptic_cone": elliptic_cone,
}


SEGMENT_LENGTH = 0.06  # short pieces let matplotlib's depth-sort interleave
                       # each one individually with the surface facets, rather
                       # than treating a whole long line as one in-front/behind unit


def draw_segmented_line(ax, p0, p1, color, alpha, linewidth):
    p0 = np.array(p0, dtype=float)
    p1 = np.array(p1, dtype=float)
    n = max(1, int(np.linalg.norm(p1 - p0) / SEGMENT_LENGTH))
    pts = np.linspace(p0, p1, n + 1)
    for i in range(n):
        ax.plot(
            [pts[i][0], pts[i + 1][0]],
            [pts[i][1], pts[i + 1][1]],
            [pts[i][2], pts[i + 1][2]],
            color=color, alpha=alpha, linewidth=linewidth,
        )


def draw_xy_grid(ax, half_extent):
    ticks = np.linspace(-half_extent, half_extent, GRID_DIVISIONS + 1)
    for t in ticks:
        draw_segmented_line(
            ax, (t, -half_extent, 0), (t, half_extent, 0),
            GRID_COLOR, GRID_ALPHA, 0.5,
        )
        draw_segmented_line(
            ax, (-half_extent, t, 0), (half_extent, t, 0),
            GRID_COLOR, GRID_ALPHA, 0.5,
        )


def draw_axes(ax, xlim, ylim, zlim):
    def axis_arrow(p1):
        p1 = np.array(p1, dtype=float)
        head_start = 0.88 * p1
        draw_segmented_line(ax, (0, 0, 0), head_start, AXIS_COLOR, AXIS_ALPHA, 2)
        head = Arrow3D(
            [head_start[0], p1[0]], [head_start[1], p1[1]], [head_start[2], p1[2]],
            mutation_scale=14, lw=2, arrowstyle="-|>",
            color=AXIS_COLOR, alpha=AXIS_ALPHA,
        )
        ax.add_artist(head)

    x_pos, x_neg = xlim[1] * 1.08, xlim[0] * 0.3
    y_pos, y_neg = ylim[1] * 1.08, ylim[0] * 0.3
    z_pos = zlim[1] * 1.1 if zlim[1] > 0 else zlim[1] * 0.9
    z_neg = zlim[0] * 1.08 if zlim[0] < 0 else 0

    draw_segmented_line(ax, (x_neg, 0, 0), (0, 0, 0), AXIS_COLOR, AXIS_ALPHA, 2)
    axis_arrow((x_pos, 0, 0))
    draw_segmented_line(ax, (0, y_neg, 0), (0, 0, 0), AXIS_COLOR, AXIS_ALPHA, 2)
    axis_arrow((0, y_pos, 0))
    if z_neg:
        draw_segmented_line(ax, (0, 0, z_neg), (0, 0, 0), AXIS_COLOR, AXIS_ALPHA, 2)
    axis_arrow((0, 0, z_pos))

    ax.text(x_pos * 1.08, 0, 0, "X", color=AXIS_COLOR, fontsize=20,
            fontweight="bold", ha="center", va="center")
    ax.text(0, y_pos * 1.08, 0, "Y", color=AXIS_COLOR, fontsize=20,
            fontweight="bold", ha="center", va="center")
    ax.text(0, 0, z_pos * 1.08, "Z", color=AXIS_COLOR, fontsize=20,
            fontweight="bold", ha="center", va="center")


def render(shape_name):
    config = SHAPES[shape_name]()

    fig = plt.figure(figsize=(FIGSIZE, FIGSIZE))
    fig.patch.set_alpha(0.0)
    ax = fig.add_subplot(111, projection="3d")
    ax.patch.set_alpha(0.0)
    ax.set_axis_off()

    xlim, ylim, zlim = config["xlim"], config["ylim"], config["zlim"]
    ax.set_xlim(*xlim)
    ax.set_ylim(*ylim)
    ax.set_zlim(*zlim)
    ax.set_box_aspect((xlim[1] - xlim[0], ylim[1] - ylim[0], zlim[1] - zlim[0]))
    ax.view_init(elev=ELEV, azim=AZIM)

    draw_xy_grid(ax, config["grid_half"])

    for x, y, z in config["surfaces"]:
        ax.plot_surface(
            x, y, z,
            color=SURFACE_COLOR, alpha=SURFACE_ALPHA,
            rstride=RESOLUTION // 22, cstride=RESOLUTION // 22,
            linewidth=0.3, edgecolor="#5a0a0a", shade=True, lightsource=LIGHT,
            antialiased=True,
        )

    draw_axes(ax, xlim, ylim, zlim)

    out_path = f"quad_{shape_name}.png"
    fig.savefig(out_path, transparent=True, dpi=DPI, bbox_inches="tight", pad_inches=0.15)
    plt.close(fig)
    print(f"wrote {out_path}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--shape", choices=sorted(SHAPES),
        help="shape to render; omit to render all shapes",
    )
    args = parser.parse_args()
    for shape_name in [args.shape] if args.shape else sorted(SHAPES):
        render(shape_name)


if __name__ == "__main__":
    main()
