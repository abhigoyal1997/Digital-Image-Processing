function [cn, ev1, ev2, ix, iy, im_s] = myHarrisCornerDetector(im, sigma_smooth, sigma_w, k)
tic;

% gaussian filter for smoothening the image
smooth_filter = fspecial('gaussian', 2*round(3*sigma_smooth) + 1, sigma_smooth);
im_s = imfilter(im, smooth_filter);

% calculating gradients
[ix, iy] = gradient(im_s);

% w(u,v) for calculating structure tensor in Harris corner detection
w = fspecial('gaussian', 2*round(3*sigma_w)+1, sigma_w);

% A(1,1) in structure tensor A
a_xx = imfilter(ix.^2, w);

% A(2,2) in structure tensor A
a_yy = imfilter(iy.^2, w);

% A(1,2) and A(2,1) in structure tensor A
a_xy = imfilter(ix.*iy, w);

% calculating eigen-values by solving for zeroes of characteristic polynomials
x = (a_xx+a_yy)/2; % (b/2)
y = sqrt((a_xx+a_yy).^2 - 4*(a_xx.*a_yy - a_xy.^2))/2; % sqrt(b^2 - 4ac)/2
ev1 = x+y;
ev2 = x-y;

% calculating corner-ness measure
cn_m = ev1.*ev2 - k*(ev1+ev2).^2;

% non-maximum suppression
max_idx = (cn_m == ordfilt2(cn_m, 9, ones(3)));
cn = zeros(size(cn_m));
cn(max_idx) = cn_m(max_idx);

toc;
end