function im2 = myPCADenoising1(im, p, sigma)

% Constructing the matrix P with columns as patches of image

[m,n] = size(im);
N = (m-p+1)*(n-p+1);
P = zeros(p*p, N);

for i=1:m-p+1
    for j=1:n-p+1
        P(:,(n-p+1)*(i-1)+j) = reshape(im(i:i+p-1,j:j+p-1),[],1);
    end
end

% Finding the coefficients for noisy image patches

M = P*P';
[V,~] = eig(M);
alpha = V'*P;

% Calculating the coefficients for denoised image patches

alpha_a2 = max(0, sum(alpha.^2,2)./N - sigma^2);
beta = alpha./(1+(sigma^2)./alpha_a2);

% Recontructing the patches and final image

P = V*beta;
im2 = single(zeros([m,n]));
im2_pc = single(zeros([m,n]));

for i=1:m-p+1
    for j=1:n-p+1
        im2(i:i+p-1,j:j+p-1) = im2(i:i+p-1,j:j+p-1) + reshape(P(:,(n-p+1)*(i-1)+j),p,p);
        im2_pc(i:i+p-1,j:j+p-1) = im2_pc(i:i+p-1,j:j+p-1) + 1;
    end
end

im2 = im2./im2_pc;

end

