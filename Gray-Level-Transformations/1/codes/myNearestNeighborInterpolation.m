function new_img = myNearestNeighborInterpolation(orig_img)
    % Size of original image
    [size_1,size_2] = size(orig_img);
    new_img = zeros(size_1*3-2, size_2*2-1);
    new_img(1:3:end,1:2:end) = orig_img;
    % Copying odd columns to even columns
    new_img(:,2:2:end) = new_img(:,1:2:end-1);
    % Copying 1 mod 3 rows to 0 mod 3 rows
    new_img(3:3:end,:) = new_img(4:3:end,:);
    % Copying 1 mod 3 rows to 2 mod 3 rows
    new_img(2:3:end,:) = new_img(1:3:end-1,:);





