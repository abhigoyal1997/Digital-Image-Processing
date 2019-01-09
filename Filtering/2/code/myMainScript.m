

tic;

%% Loading image (barbara.mat)
image = load('../data/barbara.mat');
image = image.imageOrig;

%% Added noise to the image
noise = randn(size(image,1)) * 0.05*(max(image(:)) - min(image(:)));
corrupted_image = max(0, image+noise);

%% Tuned parameters for this image
std_s = 1.331;
std_i = 10.53;
win_size = 9;
fprintf('Tuned sigma_space\n');
std_s
fprintf('Tuned sigma_intensity\n');
std_i

%% Spatial filter
k = (win_size-1)/2;
[x, y]=meshgrid(-k:k,-k:k);
domain_filter=exp(-(x.^2+y.^2)/(2*std_s^2));

%% Creating the bilaterally filtered image
output_image = myBilateralFiltering(corrupted_image, std_s, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is\n');
rmsd(image,output_image)

%% Displaying

% Displaying the Spatial Gaussian Filter
figure;
imshow(domain_filter,'InitialMagnification','fit')
title('The global spatial filter');
colormap(gray(256));
axis on;
colorbar;

figure("position",[100, 100, 1200, 1200]);
% Displaying the original Image
subplot(1,3,1),imshow(mat2gray(image));
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
subplot(1,3,3),imshow(mat2gray(output_image));
title('Filtered Image');
colormap(gray(256));
axis on;
colorbar;


%% Applying perturbed values of standard deviations

output_image = myBilateralFiltering(corrupted_image, std_s*0.9, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 0.9*sigma_space\n');
rmsd(image,output_image)

output_image = myBilateralFiltering(corrupted_image, std_s*1.1, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 1.1*sigma_space\n');
rmsd(image,output_image)


output_image = myBilateralFiltering(corrupted_image, std_s, std_i*0.9, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 0.9*sigma_intensity\n');
rmsd(image,output_image)

output_image = myBilateralFiltering(corrupted_image, std_s, std_i*1.1, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 1.1*sigma_intensity\n');
rmsd(image,output_image)




%% Loading image (grass.mat)
image = imread('../data/grass.png');
image = im2double(image);

%% Added noise to the image
noise = randn(size(image,1)) * 0.05*(max(image(:)) - min(image(:)));
corrupted_image = max(0, image+noise);

%% Tuned parameters for this image
std_s = 0.6;
std_i = 1;
win_size = 5;
fprintf('Tuned sigma_space\n');
std_s
fprintf('Tuned sigma_intensity\n');
std_i
%% Spatial filter
k = (win_size-1)/2;
[x, y]=meshgrid(-k:k,-k:k);
domain_filter=exp(-(x.^2+y.^2)/(2*std_s^2));

%% Creating the bilaterally filtered image
output_image = myBilateralFiltering(corrupted_image, std_s, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is\n');
rmsd(image,output_image)

%% Displaying

% Displaying the Spatial Gaussian Filter
figure;
imshow(domain_filter,'InitialMagnification','fit')
title('The global spatial filter');
colormap(gray(256));
axis on;
colorbar;

figure("position",[100, 100, 1200, 1200]);
% Displaying the original Image
subplot(1,3,1),imshow(mat2gray(image));
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
subplot(1,3,3),imshow(mat2gray(output_image));
title('Filtered Image');
colormap(gray(256));
axis on;
colorbar;


%% Applying perturbed values of standard deviations

output_image = myBilateralFiltering(corrupted_image, std_s*0.9, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 0.9*sigma_space\n');
rmsd(image,output_image)

output_image = myBilateralFiltering(corrupted_image, std_s*1.1, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 1.1*sigma_space\n');
rmsd(image,output_image)


output_image = myBilateralFiltering(corrupted_image, std_s, std_i*0.9, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 0.9*sigma_intensity\n');
rmsd(image,output_image)

output_image = myBilateralFiltering(corrupted_image, std_s, std_i*1.1, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 1.1*sigma_intensity\n');
rmsd(image,output_image)



%% Loading image (honeyCombReal.mat)
image = imread('../data/honeyCombReal.png');
image = im2double(image);

%% Added noise to the image
noise = randn(size(image,1)) * 0.05*(max(image(:)) - min(image(:)));
corrupted_image = max(0, image+noise);

%% Tuned parameters for this image
std_s = 0.6;
std_i = 7;
win_size = 9;
fprintf('Tuned sigma_space\n');
std_s
fprintf('Tuned sigma_intensity\n');
std_i
%% Spatial filter
k = (win_size-1)/2;
[x, y]=meshgrid(-k:k,-k:k);
domain_filter=exp(-(x.^2+y.^2)/(2*std_s^2));

%% Creating the bilaterally filtered image
output_image = myBilateralFiltering(corrupted_image, std_s, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is\n');
rmsd(image,output_image)

%% Displaying

% Displaying the Spatial Gaussian Filter
figure;
imshow(domain_filter,'InitialMagnification','fit')
title('The global spatial filter');
colormap(gray(256));
axis on;
colorbar;

figure("position",[100, 100, 1200, 1200]);
% Displaying the original Image
subplot(1,3,1),imshow(mat2gray(image));
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
subplot(1,3,3),imshow(mat2gray(output_image));
title('Filtered Image');
colormap(gray(256));
axis on;
colorbar;


%% Applying perturbed values of standard deviations

output_image = myBilateralFiltering(corrupted_image, std_s*0.9, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 0.9*sigma_space\n');
rmsd(image,output_image)

output_image = myBilateralFiltering(corrupted_image, std_s*1.1, std_i, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 1.1*sigma_space\n');
rmsd(image,output_image)


output_image = myBilateralFiltering(corrupted_image, std_s, std_i*0.9, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 0.9*sigma_intensity\n');
rmsd(image,output_image)

output_image = myBilateralFiltering(corrupted_image, std_s, std_i*1.1, win_size);
fprintf('The root mean squared distance between filtered image and the original image is with 1.1*sigma_intensity\n');
rmsd(image,output_image)




toc;
