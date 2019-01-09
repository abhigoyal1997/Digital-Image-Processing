function [cps, peak] = transform_peak(orig_image, shifted_image)
    orig_imgfft = fft2(orig_image);
    shifted_imgfft = fft2(shifted_image);
    conj_shifted_imgfft = conj(shifted_imgfft);
    cps = (orig_imgfft.*conj_shifted_imgfft)./abs(orig_imgfft.*shifted_imgfft);
    peak = ifft2(cps);
end