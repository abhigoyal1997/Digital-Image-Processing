function im_r = myAHE(im,ws) % AHE for a given image and window size
[m,n,c] = size(im);
im_r = zeros(m,n,c); % result holder

for ci = 1:c % loop to separate out the channels (AHE on independent channels)
    for i = 1:m
        for j = 1:n
            im_r(i,j,ci) = eqValue(im,ws,i,j,ci); % find output pixel value for pixel at (i,j) in channel ci
        end
    end
end
end