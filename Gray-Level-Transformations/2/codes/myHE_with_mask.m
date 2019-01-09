function I_out = myHE_with_mask(I_in, I_in_mask)
    % compute image dimensions
    [h, w, numChan] = size(I_in);
    % create placeholder for output image
    I_out = zeros(h, w, numChan);
    
    for chan = 1 : numChan
        % extract one channel of image intensities
        I_chan = I_in(:, :, chan);
        % identify pixel locations in mask which are non-zero
        input_store = (I_in_mask ~= 0);
        % compute histogram for the image
        pixelFreq = imhist(I_chan(input_store));
        % count number of pixels in image which aren't masked
        count_input = sum(input_store(:) == 1);
        % compute pdf for each pixel intensity value
        pixelFreq = pixelFreq / (count_input);
        % compute cdf for each pixel intensity value
        pixelCumFreq = cumsum(pixelFreq);
        
        % placeholder for output for one channel
        I_temp = zeros(h, w, 1);
        
        % identify those pixels in image which have particular intensity,
        % and replace them with the cumulative frequency value for it and
        % rescale to [0, 255] range
        for i = 0:255
            I_temp(I_chan == i) = pixelCumFreq(i + 1) * 255;
        end
        
        % replace the masked values in input image with corresponding
        % values from input image itself
        input_store_negative = (I_in_mask == 0);
        I_temp(input_store_negative) = I_chan(input_store_negative);
        
        % append output for one channel to final output image
        I_out(:, :, chan) = I_temp;
    end
    
    % convert the image from double to uint8 for proper display
    I_out = uint8(round(I_out));
    I_out = im2double(I_out);
end