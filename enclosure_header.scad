soilDepth = 8 * 10; // cm

incLength = 90 * 10; // cm
incDepth = 60 * 10; // cm
incHeight = soilDepth + 50 * 10; // cm

wallThickness = 5;

// DUMMY: mean that these variable are for aesthetics
incCornerRadius = 0;

incBasePoints = [
    [incLength, incDepth / 2, incCornerRadius],
    [0, incDepth / 2, incCornerRadius],
    [0, -incDepth / 2, incCornerRadius],
    [incLength, -incDepth / 2, incCornerRadius],
];

module lx(h, center = false) {
    mirror([0, 0, h < 0 ? 1 : 0]) linear_extrude(abs(h), center = center) children();
}
