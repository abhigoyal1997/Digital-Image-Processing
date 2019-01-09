function [new_img,H] = gaussian_low_pass_filter(img,D)
    [height, width] = size(img);
    padded_img = img;
    imgfft = fft2(padded_img);
    imgfft_shifted = fftshift(imgfft);
    
    H = zeros(size(imgfft));
       for u=1:height
           for v=1:width
               if((u-128)^2 + (v-128)^2 <= D^2)
                   H(u,v) = exp(-((u-128)^2 + (v-128)^2)/(2*D^2));
               end
           end
       end
    new_img = ifft2(ifftshift(imgfft_shifted.*H));
    H = log(abs(H)+1);
end
