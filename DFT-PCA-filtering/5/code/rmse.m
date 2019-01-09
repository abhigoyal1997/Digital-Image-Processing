function rmse = rmse(a,b)

diff = double(b) - double(a);
sdiff = diff.^2;
sa = a.^2;
mse = sum(sdiff(:))/sum(sa(:));
rmse = sqrt(mse);

end