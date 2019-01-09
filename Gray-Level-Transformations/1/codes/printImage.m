function printImage(im, t)
figure, imagesc(im);
[~,~,c] = size(im);
if c == 1
    colormap(gray(256));
else
    colormap(jet(256));
end
daspect([1 1 1]);
axis on;
axis tight;
colorbar;
title(t);
truesize();
end