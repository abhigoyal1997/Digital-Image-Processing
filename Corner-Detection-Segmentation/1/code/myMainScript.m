%% MyMainScript

tic;
%% Your code here


%% Loading and rescaling the image to [0,1]
im = load('../data/boat.mat');
im = im.imageOrig;
im = mat2gray(im);
% im = imadjust(im, stretchlim(im));

%% Tuned parameters
sigma_smooth = 0.81;
sigma_w = 0.86;
k = 0.05;
fprintf('Tuned sigma for smoothening image gradients = %f\n', sigma_smooth);
fprintf('Tuned sigma for w(u,v) = %f\n', sigma_w);
fprintf('Tuned k for corner-ness measure = %f\n', k);

% %% Applying Harris corner detection
[cn, ev1, ev2, ix, iy, im_s] = myHarrisCornerDetector(im, sigma_smooth, sigma_w, k);

%% Using corner-ness measure to mark the corners
im_t = im;
im_t(imfilter(cn>5e-6, ones(4))) = 1;
im_r(:,:,1) = im_t;
im_r(:,:,2) = im;
im_r(:,:,3) = im;

%% Displaying

% Displaying the original image
printImage(im, 'Original image');

% Displaying the image after smoothening
printImage(mat2gray(im_s), 'Image after smoothening');

% Displaying the Gradients
printImage(ix, 'Gradient in x-direction');
printImage(iy, 'Gradient in y-direction');

% Displaying the Eigen-values
printImage(ev1, 'First eighen value');
printImage(ev2, 'Second eighen value');

% Displaying corner-ness and corners
printImage(cn, 'Corner-ness');
printImage(im_r, 'Original image with corners marked');

toc;
