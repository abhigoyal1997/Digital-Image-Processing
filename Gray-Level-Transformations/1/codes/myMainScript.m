%% MyMainScript

tic;
%% Your code here

%% Problem 1(a) Image Shrinking

im = imread('../data/circles_concentric.png');
im_shrink2 = myShrinkImageByFactorD(im, 2);
im_shrink3 = myShrinkImageByFactorD(im, 3);

printImage(im, 'Original Image');
printImage(im_shrink2, 'Image shrunk by a factor of 2');
printImage(im_shrink3, 'Image shrunk by a factor of 3');

%% Problem 1(b) Image Enlargement using Bilinear Interpolation

im = imread('../data/barbaraSmall.png');

im_enlarge = myBilinearInterpolation(im);

printImage(im, 'Original Image');
printImage(im_enlarge, 'Enlarged Image');

%% Problem 1(c) Image Enlargement using Nearest-Neighbor Interpolation

im_enlarge = myNearestNeighborInterpolation(im);

printImage(im, 'Original Image');
printImage(im_enlarge, 'Enlarged Image');

toc;