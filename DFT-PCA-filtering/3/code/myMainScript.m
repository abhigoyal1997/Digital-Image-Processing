%% MyMainScript
tic;

%% Your code here

% loading input image
load('../data/image_low_frequency_noise.mat');
input_img = Z;

% Fourier transform calculation
F_input_img = fft2(Z);
F_input_img = fftshift(F_input_img);

% Using impixelinfo to get locations of the frequency of the noise pattern
% in the log magnitude of fourier transform array
u0 = [118; 140];
v0 = [125; 136];

% Use tunining to find optimal box filter size
k = 4;

F_restored_img = F_input_img(:,:);

% Notch filter
len = size(u0, 1);
for i = 1 : len
    x_center = u0(i); 
    y_center = v0(i);
    % make pixel values zero in the box around locations of noise pattern
    % frequencies in log magnitude of fourier transform array
    F_restored_img(x_center - k : x_center + k, y_center - k : y_center + k) = 0;
end

% Compute the inverse fourier transform to retrieve the restored image
img_restored = ifftshift(F_restored_img);
img_restored = ifft2(img_restored);


% Display Input Image
imagesc(input_img);
daspect([1 1 1]);
axis tight;
colormap('gray');
title('Input Image');

% display Log magnitude of Fourier transform for Input Image
log_F_input_image = abs(F_input_img);
log_F_input_image = log(log_F_input_image + 1);
figure;
imagesc(log_F_input_image);
daspect([1 1 1]);
axis tight;
colormap('jet');
title('Log magnitude of Fourier transform for Input Image');

% display Log magnitude of Fourier transform for Restored Image
log_F_restored_image = abs(F_restored_img);
log_F_restored_image = log(log_F_restored_image + 1);
figure;
imagesc(log_F_restored_image);
daspect([1 1 1]);
axis tight;
colormap('jet');
title('Log magnitude of Fourier transform after applying Notch filter');

% Display Restored Image
figure;
imagesc(abs(img_restored));
daspect([1 1 1]);
axis tight;
colormap('gray');
title('Final Restored image');

toc;