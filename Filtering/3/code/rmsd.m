function dist = rmsd(image1, image2)
    dist = sqrt(sum(sum((image1-image2).^2))/numel(image1));
end