soilDepth = 8 * 10; // cm

incLength = 90 * 10; // cm
incDepth = 60 * 10; // cm
incHeight = soilDepth + 50 * 10; // cm

waterResLength = 20 * 10; // cm
waterResDepth = 50 * 10; // cm
waterResHeight = 50 * 10; // cm

waterResBottomLength = 7 * 10; // cm
waterResSlantAngle = 68; // Angle

topHatchLength = 60 * 10; // cm
topHatchDepth =  50 * 10; // cm
topHatchHeight = 7 * 10; // cm
topHatchSlantXOffset = 7 * 10; // cm

dedCoolerLength = 30 * 10; // cm
dedCoolerDepth = 8 * 10; // cm
dedCoolerHeight = 10 * 10; // cm
dedCoolerSlantXOffset = 8 * 10; // cm

elecBayLength = 25 * 10; // cm
elecBayDepth = 50 * 10; // cm
elecBayHeight = incHeight; // cm
elecBayBottomXOffset = 15 * 10; // cm
elecBaySlantAngle = 50; // Angle

humeResLength = 16 * 10; // cm
humeResDepth = 6 * 10; // cm
humeResHeight = 18 * 10; // cm
humeResSlantXOffset = 4 * 10; // cm
humeResXOffset = 8 * 10; // cm

extBlockLength = 20 * 10; // cm
extBlockDepth = incDepth; // cm
extBlockHeight = 10 * 10; // cm

extPipeCrossSideLength = 8 * 10; // cm

sideHatchZOffset = 12 * 10; // cm
sideHatchXOffset = 3 * 10; // cm
sideHatchLength = 40 * 10; // cm
sideHatchDepth = 6 * 10; // cm
sideHatchHeight = incHeight - soilDepth - sideHatchZOffset; // cm
sideHatchSlantXOffset = 4 * 10; // cm

wallThickness = 5;

// DUMMY: mean that these variable are for aesthetics
incBaseCornerRadius = 0;
waterResSideCornerRadius = 0;
topHatchSideCornerRadius = 0;
dedCoolerBaseCornerRadius = 0;
elecBaySideCornerRadius = 0;
humeResBaseCornerRadius = 0;
extBlockSideCornerRadius = 0;
extPipeSideCornerRadius = 0;
sideHatchBaseCornerRadius = 0;

incBasePoints = [
    [incLength, incDepth / 2, incBaseCornerRadius],
    [0, incDepth / 2, incBaseCornerRadius],
    [0, -incDepth / 2, incBaseCornerRadius],
    [incLength, -incDepth / 2, incBaseCornerRadius],
];

waterResSidePoints = [
    [0, 0, waterResSideCornerRadius],
    [-waterResBottomLength, 0, waterResSideCornerRadius],
    [-waterResLength, -(tan(waterResSlantAngle) * (waterResLength - waterResBottomLength)), waterResSideCornerRadius],
    [-waterResLength, -waterResHeight, waterResSideCornerRadius],
    [0, -waterResHeight, waterResSideCornerRadius],
];

topHatchSidePoints = [
    [0, 0, topHatchSideCornerRadius],
    [topHatchSlantXOffset, -topHatchHeight, topHatchSideCornerRadius],
    [topHatchLength - topHatchSlantXOffset, -topHatchHeight, topHatchSideCornerRadius],
    [topHatchLength, 0, topHatchSideCornerRadius],
];

dedCoolerBasePoints = [
    [0, 0, dedCoolerBaseCornerRadius],
    [dedCoolerSlantXOffset, -dedCoolerDepth, dedCoolerBaseCornerRadius],
    [dedCoolerLength - dedCoolerSlantXOffset, -dedCoolerDepth, dedCoolerBaseCornerRadius],
    [dedCoolerLength, 0, dedCoolerBaseCornerRadius],
];

elecBaySidePoints = [
    [0, 0, elecBaySideCornerRadius],
    [elecBayBottomXOffset, 0, elecBaySideCornerRadius],
    [elecBayLength, tan(elecBaySlantAngle) * (elecBayLength -elecBayBottomXOffset), elecBaySideCornerRadius],
    [0, elecBayHeight, elecBaySideCornerRadius],
];

humeResBasePoints = [
    [0, 0, humeResBaseCornerRadius],
    [humeResSlantXOffset, -humeResDepth, humeResBaseCornerRadius],
    [humeResLength - humeResSlantXOffset, -humeResDepth, humeResBaseCornerRadius],
    [humeResLength, 0, humeResBaseCornerRadius],
];

extBlockSidePoints = [
    [extBlockLength, extBlockHeight, extBlockSideCornerRadius],
    [0, extBlockHeight, extBlockSideCornerRadius],
    [0, 0, extBlockSideCornerRadius],
    [extBlockLength, 0, extBlockSideCornerRadius],
];

extPipeSidePoints = [
    [0, 0, extPipeSideCornerRadius],
    [incLength, 0, extPipeSideCornerRadius],
    [incLength, extPipeCrossSideLength, extPipeSideCornerRadius],
    [extPipeCrossSideLength, extPipeCrossSideLength, extPipeSideCornerRadius],
    [extPipeCrossSideLength, incHeight - soilDepth - extPipeCrossSideLength, extPipeSideCornerRadius],
    [incLength, incHeight - soilDepth - extPipeCrossSideLength, extPipeSideCornerRadius],
    [incLength, incHeight - soilDepth, extPipeSideCornerRadius],
    [0, incHeight - soilDepth, extPipeSideCornerRadius],
];

sideHatchBasePoints = [
    [0, 0, sideHatchBaseCornerRadius],
    [sideHatchSlantXOffset, sideHatchDepth, sideHatchBaseCornerRadius],
    [sideHatchLength - sideHatchSlantXOffset, sideHatchDepth, sideHatchBaseCornerRadius],
    [sideHatchLength, 0, sideHatchBaseCornerRadius],
];

module lx(h, center = false) {
    mirror([0, 0, h < 0 ? 1 : 0]) linear_extrude(abs(h), center = center) children();
}
