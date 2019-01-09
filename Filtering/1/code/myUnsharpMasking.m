function filtered_image = myUnsharpMasking(image, scale, std, win_size)
    filtered_image = imfilter(image, fspecial('log', win_size, std));
    filtered_image = image - scale*filtered_image;
