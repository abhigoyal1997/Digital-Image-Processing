function im_r = myCLAHE(im,ws,cap)
[m,n,p] = size(im);
% new image initialized with zeros
im_r = zeros(m,n,p);

% looping through all the channels
for c = 1:p
	% looping on all the pixels of the channel
	for i = 1:m
	    for j = 1:n
	        im_r(i,j,c) = utilCLAHE(im,ws,i,j,c,cap);
	    end
	end
end
end

