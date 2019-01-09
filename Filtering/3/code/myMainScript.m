%% MyMainScript

tic;
%% Your code here


%% Loading image (barbara.mat)
im = load('../data/barbara.mat');
im = im.imageOrig;

%% Down Sampling
im = imgaussfilt(im,0.66);
im = im(1:2:end,1:2:end);

%% Added noise to the image
noise = randn(size(im,1)) * 0.05*(max(im(:)) - min(im(:)));
corrupted_image = max(0, im+noise);

%% Tuned parameters for this image
sigma = 0.83;
fprintf('Tuned sigma\n');
sigma

%% Applying patch based filter
im_r = myPatchBasedFiltering(corrupted_image,sigma);

fprintf('The root mean squared distance between filtered image and the original image is\n');
rmsd(im,im_r)

%% Displaying

% Displaying the Gaussian Mask
figure;
imshow(mat2gray(fspecial('gaussian', 9, 9/6)),'InitialMagnification','fit')
title('The gaussain mask to make patches isotropic');
colormap(gray(256));
axis on;
colorbar;

figure("position",[100, 100, 1200, 1200]);
% Displaying the original image (down-sampled)
subplot(1,3,1),imshow(mat2gray(im));
title('Original Image');
colormap(gray(256));
axis on;
colorbar;

% Displaying the Corrupted Image
subplot(1,3,2),imshow(mat2gray(corrupted_image));
title('Corrupted Image');
axis on;
colormap(gray(256));
colorbar;

% Displaying the Filtered Image
subplot(1,3,3),imshow(mat2gray(im_r));
title('Filtered Image');
colormap(gray(256));
axis on;
colorbar;


%% Applying perturbed values of sigma

im_r = myPatchBasedFiltering(corrupted_image, sigma*0.9);
fprintf('The root mean squared distance between filtered image and the original image with 0.9*sigma\n');
rmsd(im,im_r)

im_r = myPatchBasedFiltering(corrupted_image, sigma*1.1);
fprintf('The root mean squared distance between filtered image and the original image with 1.1*sigma\n');
rmsd(im,im_r)

toc;

tic;
%% Loading image (grass.mat)
im = imread('../data/grass.png');
im = im2double(im);

%% Added noise to the image
noise = randn(size(im,1)) * 0.05*(max(im(:)) - min(im(:)));
corrupted_image = max(0, im+noise);

%% Tuned parameters for this image
sigma = 0.0085;
fprintf('Tuned sigma\n');
sigma

%% Applying patch based filter
im_r = myPatchBasedFiltering(corrupted_image,sigma);

fprintf('The root mean squared distance between filtered image and the original image is\n');
rmsd(im,im_r)

%% Displaying

% Displaying the Gaussian Mask
figure;
imshow(mat2gray(fspecial('gaussian', 9, 9/6)),'InitialMagnification','fit')
title('The gaussain mask to make patches isotropic');
colormap(gray(256));
axis on;
colorbar;

figure("position",[100, 100, 1200, 1200]);
% Displaying the original image (down-sampled)
subplot(1,3,1),imshow(mat2gray(im));
title('Original Image');
colormap(gray(256));
axis on;
colorbar;

% Displaying the Corrupted Image
subplot(1,3,2),imshow(mat2gray(corrupted_image));
title('Corrupted Image');
axis on;
colormap(gray(256));
colorbar;

% Displaying the Filtered Image
subplot(1,3,3),imshow(mat2gray(im_r));
title('Filtered Image');
colormap(gray(256));
axis on;
colorbar;


%% Applying perturbed values of sigma

im_r = myPatchBasedFiltering(corrupted_image, sigma*0.9);
fprintf('The root mean squared distance between filtered image and the original image with 0.9*sigma\n');
rmsd(im,im_r)

im_r = myPatchBasedFiltering(corrupted_image, sigma*1.1);
fprintf('The root mean squared distance between filtered image and the original image with 1.1*sigma\n');
rmsd(im,im_r)

toc;

tic;

%% Loading image (honeyCombReal.mat)
im = imread('../data/honeyCombReal.png');
im = im2double(im);


%% Added noise to the image
noise = randn(size(im,1)) * 0.05*(max(im(:)) - min(im(:)));
corrupted_image = max(0, im+noise);

%% Tuned parameters for this image
sigma = 0.009;
fprintf('Tuned sigma\n');
sigma

%% Applying patch based filter
im_r = myPatchBasedFiltering(corrupted_image,sigma);

fprintf('The root mean squared distance between filtered image and the original image is\n');
rmsd(im,im_r)

%% Displaying

% Displaying the Gaussian Mask
figure;
imshow(mat2gray(fspecial('gaussian', 9, 9/6)),'InitialMagnification','fit')
title('The gaussain mask to make patches isotropic');
colormap(gray(256));
axis on;
colorbar;

figure("position",[100, 100, 1200, 1200]);
% Displaying the original image (down-sampled)
subplot(1,3,1),imshow(mat2gray(im));
title('Original Image');
colormap(gray(256));
axis on;
colorbar;

% Displaying the Corrupted Image
subplot(1,3,2),imshow(mat2gray(corrupted_image));
title('Corrupted Image');
axis on;
colormap(gray(256));
colorbar;

% Displaying the Filtered Image
subplot(1,3,3),imshow(mat2gray(im_r));
title('Filtered Image');
colormap(gray(256));
axis on;
colorbar;


%% Applying perturbed values of sigma

im_r = myPatchBasedFiltering(corrupted_image, sigma*0.9);
fprintf('The root mean squared distance between filtered image and the original image with 0.9*sigma\n');
rmsd(im,im_r)

im_r = myPatchBasedFiltering(corrupted_image, sigma*1.1);
fprintf('The root mean squared distance between filtered image and the original image with 1.1*sigma\n');
rmsd(im,im_r)

toc;