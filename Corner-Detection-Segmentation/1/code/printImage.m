function printImage(im, t)
figure, imagesc(im);
colormap(gray(256));
daspect([1 1 1]);
axis on;
axis tight;
colorbar;
title(t);
% truesize();
end