% function returns the adjusted value for a pixel using CLAHE
function val = utilCLAHE(im,ws,i,j,c,cap)

% size of the CLAHE window
[m,n,s] = size(im);
k = (ws-1)/2;

% window around the pixel
win = im(max(1,i-k):min(m,i+k),max(1,j-k):min(n,j+k), c);

% computing the histogram and calculating the histogram threshold, and then applying it.
hist = imhist(win);
cap = numel(win)*cap;

% alpha is the average number of pixels in each bin added as a result of redistribution.
alpha = sum(max(hist(:)-cap,0))/256;
hist(hist>cap) = cap;

% updating the histogram
hist = hist + alpha;
hist = double(hist)/numel(win);

% Evaluating the cumulating sum for the concerned pixel
val = sum(hist(1:im(i,j,c)+1));
end