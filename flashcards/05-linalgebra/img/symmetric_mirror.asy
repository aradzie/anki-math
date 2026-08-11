// A symmetric matrix mirrors its entries across the main diagonal:
// a_ij = a_ji. The shaded diagonal cells sit on the mirror line; two
// off-diagonal pairs are highlighted and connected to show entries
// reflected across it.

import common;

size(9cm);
mathdefaults();

int n = 4;

path cell(int row, int col) {
    real x = col - 1;
    real y = n - row;
    return (x, y)--(x + 1, y)--(x + 1, y + 1)--(x, y + 1)--cycle;
}

pair cellCenter(int row, int col) {
    return (col - 0.5, n - row + 0.5);
}

for (int i = 1; i <= n; ++i) {
    fill(cell(i, i), gray + opacity(0.35));
}

draw((0, n)--(n, 0), black + dashed + linewidth(1.0));
label("main diagonal (mirror)", (n / 2, n + 0.5), black);

for (int i = 0; i <= n; ++i) {
    draw((i, 0)--(i, n), gray);
    draw((0, i)--(n, i), gray);
}

pen pairA = blue;
pen pairB = deepgreen;

fill(cell(1, 2), pairA + opacity(0.35));
fill(cell(2, 1), pairA + opacity(0.35));
fill(cell(1, 4), pairB + opacity(0.35));
fill(cell(4, 1), pairB + opacity(0.35));

label("$a_{12}$", cellCenter(1, 2), NW);
label("$a_{21}$", cellCenter(2, 1), SE);
label("$a_{14}$", cellCenter(1, 4), NW);
label("$a_{41}$", cellCenter(4, 1), SE);

draw(cellCenter(1, 2)--cellCenter(2, 1), pairA + linewidth(1.0), Arrows(TeXHead));
draw(cellCenter(1, 4)--cellCenter(4, 1), pairB + linewidth(1.0), Arrows(TeXHead));
