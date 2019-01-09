%% MyMainScript

tic;
%% Loading and printing image
img = imread('../data/barbara256.png');
figure, imagesc(img), colormap(gray(256)), axis image, title('Original image');

%% Ideal low pass filter with D = 40
D=40;
[new_img, H] = ideal_low_pass_filter(img, D);
figure, imagesc(abs(new_img)); colormap(gray(256)); colorbar, axis image, title('Low Pass Filter with D=40');
figure, imagesc(H, [min(min(H)) max(max(H))]); colormap(jet); colorbar, axis image, title('Ideal Filter with D=40');

%% Ideal low pass filter with D = 80
D=80;
[new_img, H] = ideal_low_pass_filter(img, D);
figure, imagesc(abs(new_img)); colormap(gray(256)); colorbar, axis image, title('Low Pass Filter with D=80');
figure, imagesc(H, [min(min(H)) max(max(H))]); colormap(jet); colorbar, axis image, title('Ideal Filter with D=80');



%% Gaussian low pass filter with D = 40
D=40;
[new_img, H] = gaussian_low_pass_filter(img, D);
figure, imagesc(abs(new_img)); colormap(gray(256)); colorbar, axis image, title('Gaussian Low Pass Filter with D=40');
figure, imagesc(H, [min(min(H)) max(max(H))]); colormap(jet); colorbar, axis image, title('Gaussian Filter with D=40');

%% Gaussian low pass filter with D = 80
D=80;
[new_img, H] = gaussian_low_pass_filter(img, D);
figure, imagesc(abs(new_img)); colormap(gray(256)); colorbar, axis image, title('Gaussian Low Pass Filter with D=80');
figure, imagesc(H, [min(min(H)) max(max(H))]); colormap(jet); colorbar, axis image, title('Gaussian Filter with D=80');

toc;
