function im_r = myPatchBasedFiltering(im, sigma)
tic;
[m,n] = size(im);

patch_size = 9;
% span we can move on either side from a pixel to get a patch
patch_size_h = (patch_size-1)/2;
win_size = 25;
% span we can move on either side from a pixel to get a window
win_size_h = (win_size-1)/2;

% add gaussian filter to make patch more isotropic
gaussian_mask_sigma = patch_size/6;
gaussian_mask = fspecial('gaussian', patch_size, gaussian_mask_sigma);

% holder of output image
im_r = zeros(m,n);

% h = waitbar(0,'Please wait...');

% iterate over each pixel of input image
for i = 1:m
    for j = 1:n
    	% span of window in all directions at a specific pixel
        win_up = max(1,i-win_size_h);
        win_down = min(m,i+win_size_h);
        win_left = max(1,j-win_size_h);
        win_right = min(n,j+win_size_h);
        
        % span of patch in all directions at a specific pixel (patch p)
        p_up = max(1,i-patch_size_h);
        p_down = min(m,i+patch_size_h);
        p_left = max(1,j-patch_size_h);
        p_right = min(n,j+patch_size_h);
        
        % holders for weighted intensity and sum of weights
        intensity_num = 0.0;
        intensity_den = 0.0;

        %iterate over all pixels patches part of the window
        for iw = win_up:win_down
            for jw = win_left:win_right
            	% do not consider the same pixel for which intensity is being calculated
                if i==iw && j==jw
                    continue
                end

                % span of patch in all directions at a specific pixel for a point in the window (patch q)
                q_up = max(1,iw-patch_size_h);
                q_down = min(m,iw+patch_size_h);
                q_left = max(1,jw-patch_size_h);
                q_right = min(n,jw+patch_size_h);
                
                % calculate spans of the intersections of the areas of patch p and q
                up_dist = min(i-p_up,iw-q_up);
                down_dist = min(p_down-i,q_down-iw);
                left_dist = min(j-p_left,jw-q_left);
                right_dist = min(p_right-j,q_right-jw);
                
                % calculate weights for all pixels part of the window
                p = im(i-up_dist:i+down_dist,j-left_dist:j+right_dist);
                q = im(iw-up_dist:iw+down_dist,jw-left_dist:jw+right_dist);
                mask = gaussian_mask(1+patch_size_h-up_dist:1+patch_size_h+down_dist,1+patch_size_h-left_dist:1+patch_size_h+right_dist);
                pq_mask_sq = ((p-q).*mask).^2;
                w = exp(-sum(pq_mask_sq(:))/sigma^2);
                intensity_den = intensity_den + w;
                intensity_num = intensity_num + w*im(iw,jw);                
            end
        end
        % output intensity for the pixel as a weighted average
        im_r(i,j) = intensity_num/intensity_den;
        
    end
%     waitbar(i/m,h);
end
% close(h);
toc;
end

