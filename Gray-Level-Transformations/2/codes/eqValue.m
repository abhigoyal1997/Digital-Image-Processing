function val = eqValue(im,ws,i,j,ci) % Calculate output pixel value (after AHE) for a given pixel location.
[m,n,~] = size(im);
k = (ws-1)/2; % k = max. number of left and right neighbors (of givel pixel) to consider in window.

win = im(max(1,i-k):min(m,i+k),max(1,j-k):min(n,j+k),ci); % croping the image to equalisation window corresponding to the pixel.

val = sum(win(:)<=im(i,j,ci))/numel(win); % calculate ratio of pixel values less than or equal to the center pixel value.
end