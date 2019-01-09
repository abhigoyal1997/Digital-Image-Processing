%% Loading and displaying the original image

im = double(imread('../data/barbara256.png'));
imshow(mat2gray(im));
title('Original Image');

%% Adding noise and displaying the noisy image

im1 = im + randn(size(im))*20;
figure;
imshow(mat2gray(im1));
title('Image with gaussian noise');

%% Part (a): PCA Denoising

tic;
im2 = myPCADenoising1(im1,7,20);
figure;
imshow(mat2gray(im2));
title('Restored Image');
fprintf('RMSE = %f\n', rmse(im,im2));
toc;

%% Part (b): PCA Dnoising with only K nearest neighbouring patches

tic;
im2 = myPCADenoising2(im1,7,20,200,31);
figure;
imshow(mat2gray(im2));
title('Restored Image');
fprintf('RMSE = %f\n', rmse(im,im2));
toc;


%% Part (c): Denoising using Bilateral filtering

tic;
im2 = myBilateralFiltering(im1,1.7,40.5,9);
figure;
imshow(mat2gray(im2));
title('Filtered Image');
fprintf('RMSE = %f\n', rmse(im,im2));
toc;

%% Comparing PCA denoising and bilateral filtering
%{
We can observe that denoising using PCA works much better than bilateral
filtering. This is because bilateral filtering doesn't make any use of
the noise model whereas PCA based denoising makes use of the fact that
noise in the image is gaussian noise with a zero mean and a known
standard deviation (in this case 20). PCA based denoising restores the
image using this noise model whereas bilateral filtering just enhances
the noisy image.

Also, we can see that the approach in part (b) works better than the one
in part (a) because in the former approach we create an eigen-space for
each patch using only the patches similar to itself. This ensures that
the estimates of average squared eigen-coefficients of original
patches (alpha_a2 in our code) are close to their true values which then
leads to a better restoration.
%}

%% Part (d): Denoising Poisson-corrupted image (original image)

% Creating Poisson-corrupted image
im1 = poissrnd(im);
figure;
imshow(mat2gray(im1));
title('Corrupted image');

% Denoising image
tic;
im1_sqrt = sqrt(im1);
im2_sqrt = myPCADenoising2(im1_sqrt, 7, 0.25, 200, 31);
im2 = im2_sqrt.^2;
figure;
imshow(mat2gray(im2));
title('Denoised poison corrupted original image')
fprintf('RMSE = %f\n', rmse(im,im2));
toc;

%% Part (d): Denoising Poisson-corrupted image (corruption after dividing pixel intensities by 20)

% Creating Poisson-corrupted image
im1 = poissrnd(im/20);
figure;
imshow(mat2gray(im1));
title('Corrupted image');

% Denoising image
tic;
im1_sqrt = sqrt(im1);
im2_sqrt = myPCADenoising2(im1_sqrt, 7, 0.25, 200, 31);
im2 = im2_sqrt.^2;
figure;
imshow(mat2gray(im2));
title('Denoised poison corrupted image after dividing pixel intensities by 20')
fprintf('RMSE = %f\n', rmse(im,im2));
toc;

%% Comparing results in both cases
%{
The result in the later case (corruption on image after dividing it by
20) is worse than the former one (corruption on original image). This is
because the PCA denoising method is derived for a true gaussian noise.
Since sqrt(im)+gaussian_noise(0,1/4) is an approximation to the Poisson
corrupted image (im1) which gets better as values in im get larger, PCA
denoising preforms worse in the later case as it has smaller im values
as compared to the former case which makes the approximation less
accurate.
%}