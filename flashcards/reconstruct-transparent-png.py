#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = ["pillow", "numpy"]
# ///
"""Reconstruct a transparent PNG from a black-background/white-background
render pair, by difference matting:

    alpha = 1 - (white - black)
    rgb   = black / alpha

See the "SVG vs. PNG output" section of
.claude/skills/generate-illustrations/SKILL.md for why this exists and how
it's wired into flashcards/Makefile (via render-transparent-png.sh).

Usage:
    reconstruct-transparent-png.py black.png white.png out.png
        [--linear] [--warn-alpha-std F] [--fail-alpha-std F]
"""

import argparse
import sys

import numpy as np
from PIL import Image

PNG_COMPRESS_LEVEL = 6  # pinned so a future PIL default change can't alter output bytes


def load_rgb_float(path: str) -> np.ndarray:
    img = Image.open(path).convert("RGB")
    return np.asarray(img, dtype=np.float64) / 255.0


def srgb_to_linear(x: np.ndarray) -> np.ndarray:
    return np.where(x <= 0.04045, x / 12.92, ((x + 0.055) / 1.055) ** 2.4)


def linear_to_srgb(x: np.ndarray) -> np.ndarray:
    return np.where(x <= 0.0031308, 12.92 * x, 1.055 * (x ** (1.0 / 2.4)) - 0.055)


def reconstruct(
    black_path: str,
    white_path: str,
    out_path: str,
    linear: bool = False,
    eps: float = 1e-6,
    warn_alpha_std: float = 0.01,
    fail_alpha_std: float = 0.05,
) -> None:
    black = load_rgb_float(black_path)
    white = load_rgb_float(white_path)
    if black.shape != white.shape:
        raise ValueError(f"size mismatch: black={black.shape} white={white.shape}")

    if linear:
        black = srgb_to_linear(black)
        white = srgb_to_linear(white)

    alpha_rgb = 1.0 - (white - black)
    alpha = np.clip(np.mean(alpha_rgb, axis=2), 0.0, 1.0)

    alpha_std = np.std(alpha_rgb, axis=2)
    alpha_std_mean = float(alpha_std.mean())
    alpha_std_max = float(alpha_std.max())
    print(
        f"alpha_std: mean={alpha_std_mean:.4f} max={alpha_std_max:.4f} "
        f"(black/white renders should be identical apart from background; "
        f"high disagreement here means that assumption broke)",
        file=sys.stderr,
    )

    if alpha_std_mean > fail_alpha_std:
        print(
            f"error: alpha_std mean {alpha_std_mean:.4f} exceeds --fail-alpha-std "
            f"{fail_alpha_std:.4f} -- refusing to write {out_path}",
            file=sys.stderr,
        )
        sys.exit(1)
    if alpha_std_mean > warn_alpha_std:
        print(
            f"warning: alpha_std mean {alpha_std_mean:.4f} exceeds --warn-alpha-std "
            f"{warn_alpha_std:.4f}",
            file=sys.stderr,
        )

    rgb = np.zeros_like(black)
    mask = alpha > eps
    rgb[mask] = black[mask] / alpha[mask, None]
    rgb = np.clip(rgb, 0.0, 1.0)
    rgb[~mask] = 0.0
    alpha[~mask] = 0.0

    if linear:
        rgb = linear_to_srgb(rgb)

    rgba = np.dstack([rgb, alpha])
    rgba8 = np.round(np.clip(rgba, 0.0, 1.0) * 255.0).astype(np.uint8)
    Image.fromarray(rgba8, mode="RGBA").save(out_path, compress_level=PNG_COMPRESS_LEVEL)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("black_path")
    parser.add_argument("white_path")
    parser.add_argument("out_path")
    parser.add_argument(
        "--linear", action="store_true",
        help="reconstruct in linear light instead of sRGB space "
             "(sRGB is the correct default for Asymptote, which composites "
             "in gamma space by default; --linear is provided for comparison only)",
    )
    parser.add_argument("--eps", type=float, default=1e-6)
    parser.add_argument("--warn-alpha-std", type=float, default=0.01)
    parser.add_argument("--fail-alpha-std", type=float, default=0.05)
    args = parser.parse_args()

    reconstruct(
        args.black_path, args.white_path, args.out_path,
        linear=args.linear, eps=args.eps,
        warn_alpha_std=args.warn_alpha_std, fail_alpha_std=args.fail_alpha_std,
    )


if __name__ == "__main__":
    main()
