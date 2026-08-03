#!/usr/bin/env -S uv run
# /// script
# dependencies = [
#   "matplotlib",
#   "numpy",
# ]
# ///

import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm, colors


DOMAIN_MIN = -2.0
DOMAIN_MAX = 2.0
GRID_SIZE = 250
ORIGIN_MASK_RADIUS = 0.01


def main() -> None:
    x = np.linspace(DOMAIN_MIN, DOMAIN_MAX, GRID_SIZE)
    y = np.linspace(DOMAIN_MIN, DOMAIN_MAX, GRID_SIZE)
    x_grid, y_grid = np.meshgrid(x, y)

    z = x_grid + 1j * y_grid
    undefined = np.abs(z) < ORIGIN_MASK_RADIUS

    f = np.empty_like(z)
    f[~undefined] = 1 / z[~undefined]
    f[undefined] = np.nan

    magnitude = np.abs(f)
    phase = np.angle(f)
    hidden = undefined

    masked_magnitude = np.ma.masked_where(hidden, magnitude)
    masked_log_magnitude = np.ma.log(masked_magnitude)

    phase_norm = colors.Normalize(vmin=-np.pi, vmax=np.pi)
    facecolors = cm.hsv(phase_norm(phase))
    facecolors[hidden, 3] = 0.0

    fig = plt.figure(figsize=(10, 8), constrained_layout=True)
    ax = fig.add_subplot(111, projection="3d")
    ax.set_title(r"$f(z)=1/z$: height $=\log |f(z)|$, color $=\arg f(z)$")

    ax.plot_surface(
        x_grid,
        y_grid,
        masked_log_magnitude,
        facecolors=facecolors,
        rstride=1,
        cstride=1,
        linewidth=0,
        antialiased=True,
        shade=False,
    )

    ax.set_xlabel(r"$\operatorname{Re} z$")
    ax.set_ylabel(r"$\operatorname{Im} z$")
    ax.set_zlabel(r"$\log |f(z)|$")
    ax.set_xlim(DOMAIN_MIN, DOMAIN_MAX)
    ax.set_ylim(DOMAIN_MIN, DOMAIN_MAX)
    ax.set_zlim(
        np.log(1 / np.sqrt(2 * DOMAIN_MAX**2)),
        np.log(1 / ORIGIN_MASK_RADIUS),
    )
    ax.set_box_aspect((1, 1, 0.75))

    scalar_mappable = cm.ScalarMappable(norm=phase_norm, cmap=cm.hsv)
    scalar_mappable.set_array([])
    colorbar = fig.colorbar(
        scalar_mappable,
        ax=ax,
        shrink=0.72,
        pad=0.08,
        ticks=[-np.pi, -np.pi / 2, 0, np.pi / 2, np.pi],
    )
    colorbar.set_label(r"$\arg f(z)$")
    colorbar.ax.set_yticklabels(
        [r"$-\pi$", r"$-\pi/2$", r"$0$", r"$\pi/2$", r"$\pi$"]
    )

    plt.show()


if __name__ == "__main__":
    main()
