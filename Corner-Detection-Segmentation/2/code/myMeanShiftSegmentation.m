function I_out = myMeanShiftSegmentation(I_in, h_colour, h_space, num_nbr, num_iter)
    [m, n, numChan] = size(I_in);
    
    I_temp = I_in;
    I_temp(:, :, numChan + 1) = repmat(1:m, n, 1)';
    I_temp(:, :, numChan + 2) = repmat(1:n, m, 1);
    I_temp = reshape(I_temp, m*n, numChan + 2);
    
    for iter = 1 : num_iter
        Idx = knnsearch(I_temp, I_temp, 'k', num_nbr);
        
        for i = 1 : m*n
           x_nbr = I_temp(Idx(i, :), :);
           x_diff = x_nbr - repmat(I_temp(i, :), num_nbr, 1);
           
           colour_val = (x_diff(:, 1 : numChan) / h_colour).^2;
           K_colour = exp(-1 * sum(colour_val, 2));
           space_val = (x_diff(:, numChan+1 : numChan+2) / h_space).^2;
           K_space = exp(-1 * sum(space_val, 2));
           K = K_colour .* K_space;
           
           num = sum(x_nbr .* repmat(K, 1, numChan + 2));
           denom = sum(K);
           gradient = (num / denom) - I_temp(i, :);
           
           I_temp(i, :) = I_temp(i, :) + gradient;
        end
    end
    
    I_temp = I_temp(:, 1:numChan);
    I_out = reshape(I_temp, size(I_in));
    I_out = I_out / 255;
end