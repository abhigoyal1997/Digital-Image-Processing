function I_out = myLinearContrastStretching(I_in)
    % convert the image from uint8 to double
    I_in_temp = im2double(I_in);
    % compute image dimensions
    [h, w, numChan]= size(I_in_temp);
    % create placeholder for output image
    I_out = zeros(h, w, numChan);
    
    for i = 1 : numChan
        % extract one channel of image intensities
        I_chan = I_in_temp(:, :, i);
        % find minimum pixel intensity value in image
        min_val = min(min(I_chan));
        % find maximum pixel intensity value in image
        max_val = max(max(I_chan));
        % linearly rescale the image pixel intensities to [0,255] range
        I_out(:,:,i) = 255 * ((I_chan - min_val) / (max_val - min_val));
    end
    
    % convert the image from double to uint8 for proper display
    I_out = uint8(round(I_out));
    I_out = im2double(I_out);
end