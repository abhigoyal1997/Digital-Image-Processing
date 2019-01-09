%% MyMainScript

tic;

%% Loading all the images

im1 = imread('../data/barbara.png');
im2 = imread('../data/TEM.png');
im3 = imread('../data/canyon.png');
im4 = imread('../data/retina.png');
im5 = imread('../data/church.png');
im4_input = imread('../data/retina.png');
im4_input_mask = imread('../data/retinaMask.png');
im4_ref = imread('../data/retinaRef.png');
im4_ref_mask = imread('../data/retinaRefMask.png');

%% Problem 2(a) Linear Contrast Stretching

%% barbara.png
im_r = myLinearContrastStretching(im1);
printImage(im2double(im1), 'Original Image');
printImage(im_r, 'Linear Contrast Stretching output of Image');

%% TEM.png
im_r = myLinearContrastStretching(im2);
printImage(im2double(im2), 'Original Image');
printImage(im_r, 'Linear Contrast Stretching output of Image');

%% canyon.png
im_r = myLinearContrastStretching(im3);
printImage(im2double(im3), 'Original Image');
printImage(im_r, 'Linear Contrast Stretching output of Image');

%% church.png
im_r = myLinearContrastStretching(im5);
printImage(im2double(im5), 'Original Image');
printImage(im_r, 'Linear Contrast Stretching output of Image');

% The formula used for the linear function for the Linear Contrast Stretching is 
% I_out = 255 * ((I_in - I_min) / (I_max - I_min))
% where,
% I_in = input intensity for a pixel in image
% I_min = minimum pixel intensity in the complete image
% I_max = maximum pixel intensity in the complete image
% I_out = output intensity for a pixel in image
% 
% After applying constrast stretching on image 5, there is no enhancement in image contrast. 
% This is because the minimum and maximum pixel intensity values are already 0 and 255 respectively for each of the R,G and B channels.
% Thus, there is no scope for any linear stretching and thus no contrast enhacement is observed. Thus contrast stretching isn't effective for image 5.


%% Problem 2(b) Histogram Equalization (HE)

%% barbara.png
im_r = myHE(im1);
printImage(im2double(im1), 'Original Image');
printImage(im_r, 'Histogram Equalized (HE) output of Image');

%% TEM.png
im_r = myHE(im2);
printImage(im2double(im2), 'Original Image');
printImage(im_r, 'Histogram Equalized (HE) output of Image');

%% canyon.png
im_r = myHE(im3);
printImage(im2double(im3), 'Original Image');
printImage(im_r, 'Histogram Equalized (HE) output of Image');

%% church.png
im_r = myHE(im5);
printImage(im2double(im5), 'Original Image');
printImage(im_r, 'Histogram Equalized (HE) output of Image');

% After applying Histogram Equalization on image 5, we get significant contrast enhacement in the image. 
% The church and other buildings which were darker before, now become clearly and distinctly visible and their features are also more clearly observable as they become lighter due to enhacement in contrast of the image. 
% Similarly, the bricks on the pavement are more clearly observable now with improved contrast. However, the blue colour of the sky becomes lighter after HE.


%% Problem 2(c) Histogram Matching (HM)

%% retina.png
im_r1 = myHM(im4_input, im4_input_mask, im4_ref, im4_ref_mask);
im_r2 = myHE_with_mask(im4_input, im4_input_mask);
printImage(im2double(im4_input), 'Original Image');
printImage(im_r1, 'Histogram Matched (HM) output of Image');
printImage(im_r2, 'Histogram Equalized (HE) output of Image');

% When we apply histogram matching to image 4, we observe that image contrast gets significantly enhanced. 
% The nerves in the image looks faded, the black spot in the center of the image looks faded and lighter, and the rest of the image looks brighter then before. 
% The net result is that the image contrast is enhanced, the input image which is dark and dull become bright and contrasted after HM.
% 
% When we apply HE to image 4, we get a highly discoloured image as output. 
% The eye becomes bluish in colour and thus the output quality is deteriorated. 
% Although this image has an enhanced contrast, the image quality has suffered due to discolouration to shades of blue.


%% Problem 2(d) Adaptive Histogram Equalization (AHE)

%% barbara.png
printImage(im2double(im1), 'Original Image');

im_r = myAHE(im1,225); % tuned window size
printImage(im_r, 'AHE with window size=225 (tuned)');

im_r = myAHE(im1,451); % larger window size
printImage(im_r, 'AHE with window size=451 (larger)');

im_r = myAHE(im1,99); % smaller window size
printImage(im_r, 'AHE with window size=99 (smaller)');

%% TEM.png
printImage(im2double(im2), 'Original Image');

im_r = myAHE(im2,201); % tuned window size
printImage(im_r, 'AHE with window size=201 (tuned)');

im_r = myAHE(im2,401); % larger window size
printImage(im_r, 'AHE with window size=401 (larger)');

im_r = myAHE(im2,99); % smaller window size
printImage(im_r, 'AHE with window size=99 (smaller)');

%% canyon.png
printImage(im2double(im3), 'Original Image');

im_r = myAHE(im3,151); % tuned window size
printImage(im_r, 'AHE with window size=151 (tuned)');

im_r = myAHE(im3,301); % larger window size
printImage(im_r, 'AHE with window size=301 (larger)');

im_r = myAHE(im3,51); % smaller window size
printImage(im_r, 'AHE with window size=51 (smaller)');


%% Problem 2(e) Contrast Limited Adaptive Histogram Equalization (AHE)

%% barbara.png
clahe_image1 = myCLAHE(im1, 225, 0.008);
clahe_image1_ = myCLAHE(im1, 225, 0.004);
printImage(im2double(im1),'Original Image : barbara.png');
printImage(clahe_image1,'CLAHE with window size = 225 and threshold = 0.008');
printImage(clahe_image1_,'CLAHE with window size = 225 and threshold = 0.004');


%% TEM.png
clahe_image2 = myCLAHE(im2, 201, 0.008);
clahe_image2_ = myCLAHE(im2, 201, 0.004);
printImage(im2double(im2),'Original Image : TEM.png');
printImage(clahe_image2,'CLAHE with window size = 201 and threshold = 0.008');
printImage(clahe_image2_,'CLAHE with window size = 201 and threshold = 0.004');

%% canyon.png
clahe_image3 = myCLAHE(im3, 155, 0.01);
clahe_image3_ = myCLAHE(im3, 201, 0.004);
printImage(im2double(im3),'Original Image : canyon.png');
printImage(clahe_image3,'CLAHE with window size = 155 and threshold = 0.01');
printImage(clahe_image3_,'CLAHE with window size = 155 and threshold = 0.005');


toc;
