%% MyMainScript

tic;
%% Loading image (lionCrop.mat)
image = load('../data/lionCrop.mat');
image = image.imageOrig;

%% Linear Contrast Sketch Original Input
lin_stretch_orig_image = LinearContrastStretch(image);

%% Unsharp Masking
scale = 0.75;
std = 1.2;
win_size = 7;
unsharp_image = myUnsharpMasking(image, scale, std, win_size);
lin_stretch_unsharp_image = LinearContrastStretch(unsharp_image);
fprintf('Tuned window size\n')
win_size
fprintf('Tuned standard deviation\n')
std
fprintf('Tuned scale\n')
scale

%% Displaying
figure("position",[100, 100, 1200, 2000]);

% Displaying the Original Image
subplot(1,2,1),imshow(lin_stretch_orig_image);
title('Original  Image');
axis on;
colormap(gray(256));
colorbar;

% Displaying the Filtered Image
subplot(1,2,2),imshow(lin_stretch_unsharp_image);
title('Filtered Image');
colormap(gray(256));
axis on;
colorbar;


%% Loading image (superMoonCrop.mat)
image = load('../data/superMoonCrop.mat');
image = image.imageOrig;

%% Linear Contrast Sketch Original Input
lin_stretch_orig_image = LinearContrastStretch(image);

%% Unsharp Masking
scale = 0.75;
std = 2;
win_size = 8;
unsharp_image = myUnsharpMasking(image, scale, std, win_size);
lin_stretch_unsharp_image = LinearContrastStretch(unsharp_image);
fprintf('Tuned window size\n')
win_size
fprintf('Tuned standard deviation\n')
std
fprintf('Tuned scale\n')
scale

%% Displaying
figure("position",[100, 100, 1200, 2000]);

% Displaying the Original Image
subplot(1,2,1),imshow(lin_stretch_orig_image);
title('Original  Image');
axis on;
colormap(gray(256));
colorbar;

% Displaying the Filtered Image
subplot(1,2,2),imshow(lin_stretch_unsharp_image);
title('Filtered Image');
colormap(gray(256));
axis on;
colorbar;


toc;
