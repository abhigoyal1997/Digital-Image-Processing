function im_r = myBilinearInterpolation(im)
[m,n] = size(im);
im = double(im);
m_r = 3*m-2; % number of rows in final image
n_r = 2*n-1; % number of columns in final image
im_r = zeros(m_r,n_r); % result holder

im_r(1:3:end,1:2:end) = im; % initialize the grid in output corresponding to input image

im_r(2:3:m_r-2,1:2:end) = (2*im_r(1:3:m_r-3,1:2:end) + im_r(4:3:m_r,1:2:end))/3; % linear interpolation to find values appearing vertically just below already known pixel values

im_r(3:3:m_r-1,1:2:end) = (im_r(1:3:m_r-3,1:2:end) + 2*im_r(4:3:m_r,1:2:end))/3; % linear interpolation to find values appearing vertically just above already known pixel values

im_r(1:end,2:2:n_r-1) = (im_r(1:end,1:2:n_r-2) + im_r(1:end,3:2:n_r))/2; % final linear interpolation to find missing columns using the linearly interpolated and initial known values

end