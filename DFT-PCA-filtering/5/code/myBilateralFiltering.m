function output = myBilateralFiltering(image, std_s, std_i, win_size)
    output = zeros(size(image));
    k = (win_size-1)/2;
    % making a gaussian filter (spatial)
    [x, y]=meshgrid(-k:k,-k:k);
    domain_filter=exp(-(x.^2+y.^2)/(2*std_s^2));
    [m,n] = size(image);
    for i = 1:size(image,1)
        for j = 1:size(image,2)
            % neighbour patch around the pixel
            window = image(max(1,i-k):min(m,i+k),max(1,j-k):min(n,j+k));
            % Corresponding spatial weight
            spatial_part  = domain_filter((k-(i-max(1,i-k))+1):((min(m,i+k)-i)+k+1),(k-(j-max(1,j-k))+1):((min(n,j+k)-j)+k+1));
            % Corresponding Intensity weight
            intensity_part = exp(-(window-image(i,j)).^2/(2*std_i^2));
            % Total weight
            weight = spatial_part.*intensity_part;
            norm = sum(weight(:));
            output(i,j) = sum(sum(weight.*window))/norm;
        end
    end
end
