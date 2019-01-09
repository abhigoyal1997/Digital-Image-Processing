function I_out = LinearContrastStretch(I_in)
    % compute image dimensions
    [h, w, numChan]= size(I_in);
    % create placeholder for output image
    I_out = zeros(h, w, numChan);
    
    for i = 1 : numChan
        % extract one channel of image intensities
        I_chan = I_in(:, :, i);
        % find minimum pixel intensity value in image
        min_val = min(min(I_chan));
        % find maximum pixel intensity value in image
        max_val = max(max(I_chan));
        % linearly rescale the image pixel intensities to [0,255] range
        I_out(:,:,i) = ((I_chan - min_val) / (max_val - min_val));
    end
end