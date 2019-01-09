function I_out = myHM(I_input, I_input_mask, I_ref, I_ref_mask)
    % compute image dimensions for input image
    [h, w, numChan] = size(I_input);
    % create placeholder for output image
    I_out = zeros(h, w, numChan);
    
    for chan = 1 : numChan
        % extract one channel of intensities for input and reg image
        I_chan_input = I_input(:, :, chan);
        I_chan_ref = I_ref(:, :, chan);
        
        % identify pixel locations in input and ref mask which are non-zero
        input_store = (I_input_mask ~= 0);
        ref_store = (I_ref_mask ~= 0);
        
        % compute histogram for the input and ref image
        pixelFreq_input = imhist(I_chan_input(input_store));
        pixelFreq_ref = imhist(I_chan_ref(ref_store));
        
        % count number of pixels in input & ref image which aren't masked
        count_input = sum(input_store(:) == 1);
        count_ref = sum(ref_store(:) == 1);
        
        % compute pdf for each pixel intensity for input and ref image
        pixelFreq_input = pixelFreq_input / count_input;
        pixelFreq_ref = pixelFreq_ref / count_ref;
        
        % compute cdf for each pixel intensity for input and ref image
        pixelCumFreq_input = cumsum(pixelFreq_input);
        pixelCumFreq_ref = cumsum(pixelFreq_ref);
        
        % create placeholder of mapping of pixel intensity values between
        % input and ref
        mapping = zeros(1, 256);
        pixel_map = 1;
        
        % find mapping for each pixel value in input image
        for i = 1:256
            while 1
                if((pixelCumFreq_ref(pixel_map) - pixelCumFreq_input(i)) >= 0)
                    mapping(i) = pixel_map;
                    break;
                end
                pixel_map = pixel_map + 1;
            end
        end
        
        % placeholder for output for one channel
        I_temp = zeros(h, w, 1);
        
        % identify those pixels in image which have particular intensity,
        % and replace them with the corresponding mapping for it and
        for i = 0:255
            I_temp(I_chan_input == i) = mapping(i + 1);
        end
        
        % replace the masked values in input image with corresponding
        % values from input image itself
        input_store_negative = (I_input_mask == 0);
        I_temp(input_store_negative) = I_chan_input(input_store_negative);
        
        % append output for one channel to final output image
        I_out(:, :, chan) = I_temp;
       
    end
    
    % convert the image from double to uint8 for proper display
    I_out = uint8(round(I_out));
    I_out = im2double(I_out);
end