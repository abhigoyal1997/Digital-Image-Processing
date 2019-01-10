%% Loading, displaying and smoothening the image

im = single(rgb2gray(imread('rice.png')));
imagesc(im);
daspect([1 1 1]);
axis tight;
colormap('gray');
title('Original Image');

smooth_filter = fspecial('gaussian', 2*round(3*1) + 1, 1);
im = imfilter(im, smooth_filter);

%% 1 - Robert Operator Edge Detection

opX = [1 0; 0 -1];
opY = [0 1; -1 0];

imX = imfilter(im, opX);
imY = imfilter(im, opY);

grad = sqrt(imX.^2 + imY.^2);
angle = atan2(imY,imX)*180/pi;

% non-maximal suppression
[h,w] = size(im);
g_m = zeros(size(grad));
for i=2:h-1
    for j=2:w-1       
        if (angle(i,j)>=-22.5 && angle(i,j)<=22.5) || (angle(i,j)<-157.5 && angle(i,j)>=-180)
            if (grad(i,j) >= grad(i,j+1)) && (grad(i,j) >= grad(i,j-1))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=22.5 && angle(i,j)<=67.5) || (angle(i,j)<-112.5 && angle(i,j)>=-157.5)
            if (grad(i,j) >= grad(i+1,j+1)) && (grad(i,j) >= grad(i-1,j-1))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=67.5 && angle(i,j)<=112.5) || (angle(i,j)<-67.5 && angle(i,j)>=-112.5)
            if (grad(i,j) >= grad(i+1,j)) && (grad(i,j) >= grad(i-1,j))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=112.5 && angle(i,j)<=157.5) || (angle(i,j)<-22.5 && angle(i,j)>=-67.5)
            if (grad(i,j) >= grad(i+1,j-1)) && (grad(i,j) >= grad(i-1,j+1))
                g_m(i,j)= grad(i,j);
            end
        end
    end
end

max_g_m = max(g_m(:));

% Hysteresis Thresholding
th_low = 0.01*max_g_m;
th_high = 0.1*max_g_m;

edges = g_m>th_high;

for i=2:h-1
    for j=2:w-1 
        if (g_m(i,j)>th_low) && (g_m(i+1,j)>th_high || g_m(i-1,j)>th_high || g_m(i,j+1)>th_high || g_m(i,j-1)>th_high || g_m(i-1, j-1)>th_high || g_m(i-1, j+1)>th_high || g_m(i+1, j+1)>th_high || g_m(i+1, j-1)>th_high)
            edges(i,j) = 1;
        end
    end
end

figure, imagesc(edges);
daspect([1 1 1]);
axis tight;
colormap('gray');
title('Edge detection using Robert operator');

%% 2 - Prewitt Operator Edge Detection

opX = [1 0 -1; 1 0 -1; 1 0 -1];
opY = [1 1 1; 0 0 0; -1 -1 -1];

imX = imfilter(im, opX);
imY = imfilter(im, opY);

grad = sqrt(single(imX.^2 + imY.^2));
angle = atan2(imY,imX)*180/pi;

% non-maximal suppression
[h,w] = size(im);
g_m = zeros(size(grad));
for i=2:h-1
    for j=2:w-1       
        if (angle(i,j)>=-22.5 && angle(i,j)<=22.5) || (angle(i,j)<-157.5 && angle(i,j)>=-180)
            if (grad(i,j) >= grad(i,j+1)) && (grad(i,j) >= grad(i,j-1))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=22.5 && angle(i,j)<=67.5) || (angle(i,j)<-112.5 && angle(i,j)>=-157.5)
            if (grad(i,j) >= grad(i+1,j+1)) && (grad(i,j) >= grad(i-1,j-1))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=67.5 && angle(i,j)<=112.5) || (angle(i,j)<-67.5 && angle(i,j)>=-112.5)
            if (grad(i,j) >= grad(i+1,j)) && (grad(i,j) >= grad(i-1,j))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=112.5 && angle(i,j)<=157.5) || (angle(i,j)<-22.5 && angle(i,j)>=-67.5)
            if (grad(i,j) >= grad(i+1,j-1)) && (grad(i,j) >= grad(i-1,j+1))
                g_m(i,j)= grad(i,j);
            end
        end
    end
end

max_g_m = max(g_m(:));

% Hysteresis Thresholding
th_low = 0.01*max_g_m;
th_high = 0.1*max_g_m;

edges = g_m>th_high;

for i=2:h-1
    for j=2:w-1 
        if (g_m(i,j)>th_low) && (g_m(i+1,j)>th_high || g_m(i-1,j)>th_high || g_m(i,j+1)>th_high || g_m(i,j-1)>th_high || g_m(i-1, j-1)>th_high || g_m(i-1, j+1)>th_high || g_m(i+1, j+1)>th_high || g_m(i+1, j-1)>th_high)
            edges(i,j) = 1;
        end
    end
end

figure, imagesc(edges);

daspect([1 1 1]);
axis tight;
colormap('gray');
title('Edge detection using Prewitt operator');

%% 3 - Sobel Operator Edge Detection

opX = [1 0 -1; 2 0 -2; 1 0 -1];
opY = [1 2 1; 0 0 0; -1 -2 -1];

imX = imfilter(im, opX);
imY = imfilter(im, opY);

grad = sqrt(single(imX.^2 + imY.^2));
angle = atan2(imY,imX)*180/pi;

% non-maximal suppression
[h,w] = size(im);
g_m = zeros(size(grad));
for i=2:h-1
    for j=2:w-1       
        if (angle(i,j)>=-22.5 && angle(i,j)<=22.5) || (angle(i,j)<-157.5 && angle(i,j)>=-180)
            if (grad(i,j) >= grad(i,j+1)) && (grad(i,j) >= grad(i,j-1))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=22.5 && angle(i,j)<=67.5) || (angle(i,j)<-112.5 && angle(i,j)>=-157.5)
            if (grad(i,j) >= grad(i+1,j+1)) && (grad(i,j) >= grad(i-1,j-1))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=67.5 && angle(i,j)<=112.5) || (angle(i,j)<-67.5 && angle(i,j)>=-112.5)
            if (grad(i,j) >= grad(i+1,j)) && (grad(i,j) >= grad(i-1,j))
                g_m(i,j)= grad(i,j);
            end
        elseif (angle(i,j)>=112.5 && angle(i,j)<=157.5) || (angle(i,j)<-22.5 && angle(i,j)>=-67.5)
            if (grad(i,j) >= grad(i+1,j-1)) && (grad(i,j) >= grad(i-1,j+1))
                g_m(i,j)= grad(i,j);
            end
        end
    end
end

max_g_m = max(g_m(:));

% Hysteresis Thresholding
th_low = 0.01*max_g_m;
th_high = 0.1*max_g_m;

edges = g_m>th_high;

for i=2:h-1
    for j=2:w-1 
        if (g_m(i,j)>th_low) && (g_m(i+1,j)>th_high || g_m(i-1,j)>th_high || g_m(i,j+1)>th_high || g_m(i,j-1)>th_high || g_m(i-1, j-1)>th_high || g_m(i-1, j+1)>th_high || g_m(i+1, j+1)>th_high || g_m(i+1, j-1)>th_high)
            edges(i,j) = 1;
        end
    end
end

figure, imagesc(edges);

daspect([1 1 1]);
axis tight;
colormap('gray');
title('Edge detection using Sobel operator');